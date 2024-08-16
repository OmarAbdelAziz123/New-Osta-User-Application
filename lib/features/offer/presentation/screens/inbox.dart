import 'dart:async';

import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sound/public/flutter_sound_recorder.dart';

// import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:lottie/lottie.dart';
import 'package:osta_user_app/common/widgets/loading_two.dart';
import 'package:osta_user_app/features/booking/managers/booking_cubit.dart';
import 'package:osta_user_app/features/inbox/inbox_for_user/presentation/widgets/container_number_of_order_widget/container_number_of_order_widget.dart';
import 'package:osta_user_app/features/offer/managers/offers_orders_cubit.dart';
import 'package:osta_user_app/features/offer/managers/socket_cubit/socket_cubit.dart';
import 'package:osta_user_app/features/offer/models/inbox/get_all_messages_model.dart';
import 'package:osta_user_app/features/offer/presentation/screens/offers_screen.dart';
import 'package:osta_user_app/features/offer/presentation/widgets/inbox/audio_message_bubble.dart';
import 'package:osta_user_app/features/offer/presentation/widgets/inbox/audio_player_widget.dart';
import 'package:osta_user_app/features/profile/models/help_center/get_tickets_customer_services_model.dart';
import 'package:osta_user_app/utils/constants/exports.dart';
import 'package:osta_user_app/utils/constants/log_util.dart';
import 'package:osta_user_app/utils/dio/dio_helper.dart';
import 'package:osta_user_app/utils/formatters/formatter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:audioplayers/audioplayers.dart';

class InboxScreen2 extends StatefulWidget {
  const InboxScreen2({super.key, required this.data});

  final Map data;

  @override
  State<InboxScreen2> createState() => _InboxScreen2State();
}

class _InboxScreen2State extends State<InboxScreen2> {
  ScrollController scrollController = ScrollController();

  /// Recorde
  late final RecorderController recorderController;
  final PlayerController playerController = PlayerController();
  late Directory appDirectory;
  String? path;
  bool isLoading = true;
  bool _recordAllowed = false;
  String? musicFile;
  bool isRecording = false;
  bool isRecordingCompleted = false;

  /// Text Form Field
  TextEditingController controller = TextEditingController();
  final FocusNode focusNode = FocusNode();
  bool isFieldFocused = false;
  bool isChecked = false;
  bool isShown = false;
  XFile? _selectPhotoOrVideo;

  /// Shown Images
  bool isImageShown = false;
  bool isSendingImage = false;
  String imageUrl = "";
  String? localImagePath;

  int countPage = 1;
  List<TicketsList> ticketsList = [];

  ValueNotifier<List<Messages>> messagesListLocally =
      ValueNotifier<List<Messages>>([]);

  // List<MessageResult> messagesListLocally = [];

  AudioPlayer player = AudioPlayer();
  Duration? _duration;
  Duration? _position;

  FlutterSoundRecorder? _recorder;
  bool _isRecording = false;
  String _filePath = 'audio_example';

  Future<void> requestPermissions() async {
    await Permission.microphone.request();
    await Permission.storage.request();
  }

  Timer? _timer;
  int _recordingDuration = 0;

  Future<String> getFilePath() async {
    Directory tempDir = await getTemporaryDirectory();
    return '${tempDir.path}/audio_example.aac';
  }

  Future<void> startRecording() async {
    _filePath = await getFilePath();
    await _recorder!.startRecorder(
      toFile: _filePath,
      codec: Codec.aacMP4,
    );
    _startTimer();
    setState(() {
      _isRecording = true;
    });
  }

  ///TODO
  Future<void> stopRecording() async {
    await _recorder!.stopRecorder();
    setState(() {
      _isRecording = false;
    });
    _stopTimer();
    Future.delayed(Duration.zero).then((value) async {
      await OffersOrdersCubit.get(context).inboxFunction(
          orderId: widget.data['orderId'].toString(),
          content: null,
          mediaList: [_filePath]);
    });
    setState(() {
      messagesListLocally.value.insert(0, Messages(content: null, isMe: true, media: [Media(url: _filePath)], options: null, createdAt: DateTime.now().toString()));

      messagesListLocally.value = List<Messages>.from(messagesListLocally.value);

      _recordingDuration = 0;
    });
  }

  Future<void> openAudioSession() async {
    await _recorder!.openRecorder();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      setState(() {
        _recordingDuration++;
      });
    });
  }

  void _stopTimer() {
    if (_timer != null) {
      _timer!.cancel();
      _timer = null;
    }
  }

  String _formatDuration(int seconds) {
    final minutes = (seconds / 60).floor();
    final remainingSeconds = seconds % 60;
    return '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  Widget _buildRecordingIndicator() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(24.0),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.fiber_manual_record, color: Colors.white),
          const SizedBox(width: 8.0),
          Text(
            'Recording: ${_formatDuration(_recordingDuration)}',
            style: const TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }

  Future<void> _initializeRecorder() async {
    await Permission.microphone.request();
    if (await Permission.microphone.isGranted) {
      await _recorder!.openRecorder();
    } else {
      // Handle the case when microphone permission is not granted
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.translate('microPhonePermissionIsRequired')!)),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _recorder = FlutterSoundRecorder();
    _initializeRecorder();
    // _requestRecordPermissions(context);

    /// Add listener to focus node
    focusNode
        .addListener(() => setState(() => isFieldFocused = focusNode.hasFocus));

    /// To Refresh Messages
    OffersOrdersCubit.get(context).getAllMessagesFunction(
        orderId: widget.data['orderId'].toString(),
        page: countPage,
        perPage: 10,
    );

    _getDir();
    _initialiseControllers();
    scrollController.addListener(() {
      if (scrollController.offset >=
              scrollController.position.maxScrollExtent &&
          !scrollController.position.outOfRange) {
        if (OffersOrdersCubit.get(context)
                .getAllMessagesModel
                .result!
                .messages!
                .isEmpty ||
            OffersOrdersCubit.get(context)
                    .getAllMessagesModel
                    .result!
                    .messages ==
                []) {
        } else {
          // OffersOrdersCubit.get(context).getAllMessagesFunction(
          //     orderId: widget.data['orderId'].toString(), page: countPage, perPage: 10);

          // setState(() {
          //   countPage++;
          // });
        }

        // Reached the bottom
        logSuccess('Reached the bottom');
      }

      if (scrollController.offset <=
              scrollController.position.minScrollExtent &&
          !scrollController.position.outOfRange) {
        // Reached the top
        logSuccess('Reached the top');
      }
    });

    _recorder = FlutterSoundRecorder();
    // _recorder!.openAudioSession();
    openAudioSession();
    requestPermissions();
  }

  @override
  void dispose() {
    recorderController.dispose();
    playerController.dispose();

    /// Clean up the focus node and controller when the widget is disposed.
    focusNode.dispose();
    controller.dispose();
    scrollController.dispose();
    _recorder!.closeRecorder();
    _recorder = null;

    /// Release all sources and dispose the player.
    player.dispose();
    super.dispose();
    _recorder = null;
  }

  String formatTime(String dateTimeString) {
    final DateTime dateTime = DateTime.parse(dateTimeString);
    final DateFormat formatter = DateFormat('HH:mm');
    return formatter.format(dateTime);
  }

  void _initialiseControllers() {
    recorderController = RecorderController()
      ..androidEncoder = AndroidEncoder.opus
      ..androidOutputFormat =
          AndroidOutputFormat.ogg // Set to OGG for Opus encoding
      ..iosEncoder = IosEncoder.kAudioFormatMPEG4AAC // iOS fallback encoder
      ..sampleRate = 44100;
  }

  int indexButtonSelected = 0;
  String content = '';
  List<String> contentErrors = [];
  String contentLoading = '';

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: BlocConsumer<OffersOrdersCubit, OffersOrdersState>(
          listener: (context, state) {
            if (state is GetAllMessagesSuccessState) {
              if (context.mounted) {
                if (OCacheHelper.getString(key: CacheKeys.userId) != null) {
                  logSuccess('In Navigation Menu');
                  SocketCubit.get(context).socketFunc(
                    conversationId: OffersOrdersCubit.get(context)
                        .getAllMessagesModel
                        .result!
                        .conversation!
                        .id!,
                    userId: int.parse(
                        OCacheHelper.getString(key: CacheKeys.userId)!),
                  );
                }
              }

              messagesListLocally.value.addAll(OffersOrdersCubit.get(context)
                  .getAllMessagesModel
                  .result!
                  .messages!);
              logSuccess(messagesListLocally.toString());
            }
            if (state is InboxSuccessState) {
              setState(() {
                // controller.clear();
                // messagesListLocally.value.insert(0, OffersOrdersCubit.get(context).sendMessageResponse.data!);
                //
                // messagesListLocally.value = List<Messages>.from(messagesListLocally.value);
                contentErrors.removeWhere((element) =>
                    element ==
                    OffersOrdersCubit.get(context)
                        .sendMessageResponse
                        .data!
                        .content);
              });
            } else if (state is InboxErrorState) {
              contentErrors.add(content);
              // ODeviceUtils.showSnackBar(
              //   context: context,
              //   message: state.message,
              //   textStyle: OStyles.bodyLargeRegular,
              //   textColor: OColors.whiteColor,
              //   bgColor: OColors.error,
              // );
            }
            if (state is MakeOrderIsDoneSuccessState) {
              BookingCubit.get(context)
                  .getOrdersByFilterFunction(status: 'accepted');
              context.pushNamedAndRemoveUntil(ORoutesName.navigationMenuRoute,
                  arguments: 1, predicate: (route) => false);
              ODeviceUtils.showSnackBar(
                  context: context,
                  message: AppLocalizations.of(context)!.translate('successfully')!,
                  textStyle: OStyles.bodyLargeRegular,
                  textColor: OColors.whiteColor,
                  bgColor: OColors.success);
            } else if (state is MakeOrderIsDoneErrorState) {
              if (state.message != 'Order done successfully') {
                ODeviceUtils.showSnackBar(
                  context: context,
                  message: state.message,
                  textStyle: OStyles.bodyLargeRegular,
                  textColor: OColors.whiteColor,
                  bgColor: OColors.error,
                );
              }
            }
            if (state is MakeActionSuccessState) {
              setState(() {
                messagesListLocally.value.insert(0,
                    OffersOrdersCubit.get(context).sendMessageResponse.data!);

                messagesListLocally.value =
                    List<Messages>.from(messagesListLocally.value);
                indexButtonSelected += 1;
                messagesListLocally.value[indexButtonSelected].options?.actionStatus = '0';
              });
              logSuccess(indexButtonSelected.toString());
            }
            if (state is MakeActionErrorState) {
              if (state.message != 'Message sent successfully') {
                ODeviceUtils.showSnackBar(
                  context: context,
                  message: state.message,
                  textStyle: OStyles.bodyLargeRegular,
                  textColor: OColors.whiteColor,
                  bgColor: OColors.error,
                );
              }
            }
          },
          builder: (context, state) {
            var inboxCubit = OffersOrdersCubit.get(context);

            // int lastIndex = inboxCubit.getAllMessagesModel.result!.messages!.length - 1;
            // String content = inboxCubit.getAllMessagesModel.result!.messages![lastIndex].content!;

            /// Use a regular expression to extract the number from the content string
            // RegExp regExp = RegExp(r'#(\d+)');
            // Match? match = regExp.firstMatch(content);
            // String? orderNumber = match?.group(1);

            return BlocListener<SocketCubit, SocketState>(
              listener: (context, state) {
                if (state is SocketInboxListenState) {
                  setState(() {
                    // messagesListLocally.value.add(MessageResult(content: controller.text.trim(), isMe: true, createdAt: DateTime.now().toString()));
                    controller.clear();
                    messagesListLocally.value.insert(0, SocketCubit.get(context).socketResponseModel.data!);

                    messagesListLocally.value = List<Messages>.from(messagesListLocally.value);
                  });
                }
              },
              child: Stack(
                children: [
                  Column(
                    children: [
                      /// App Bar
                      Padding(
                        padding:
                            EdgeInsets.only(left: 24.w, right: 24.w, top: 68.h),
                        child: AppBarWidget(
                          leading: IconButton(
                              icon: const Icon(Icons.arrow_back),
                              onPressed: () {
                                // context.pop();
                                context.pushReplacementNamed(
                                    ORoutesName.navigationMenuRoute,
                                    arguments: 1);
                                messagesListLocally.value.clear();
                                inboxCubit.getAllMessagesModel =
                                    GetAllMessagesModel();
                                // }), title: inboxCubit.getAllMessagesModel.result!.conversation!.name ?? '',
                              }),
                          title: inboxCubit.getAllMessagesModel.result == null
                              ? '...'
                              : inboxCubit
                                  .getAllMessagesModel.result!.participant!,
                          actions: Container(),
                          widthOfText: 260.w,
                        ),
                      ),

                      /// Make Space
                      // SizedBox(height: 24.h),

                      /// Body in Chat
                      Expanded(
                          child: Padding(
                        padding: EdgeInsets.only(left: 24.w, right: 24.w, top: 0.h, bottom: 10.h),
                        child: ValueListenableBuilder(
                          valueListenable: messagesListLocally,
                          builder: (context, value, child) {
                            return state is GetAllMessagesLoadingState ||
                                    inboxCubit.getAllMessagesModel.result ==
                                        null
                                ? LoadingWidget(
                                    iconColor: OColors.primaryColor500)
                                : inboxCubit.getAllMessagesModel.result!
                                            .messages!.isEmpty &&
                                        value.isEmpty
                                    ? Text(AppLocalizations.of(context)!.translate('emptyMessages')!)
                                    : ListView.separated(
                                        controller: scrollController,
                                        shrinkWrap: true,
                                        reverse: true,
                                        itemCount: value.length,
                                        separatorBuilder: (context, index) {
                                          return SizedBox(height: 12.h);
                                        },
                                        itemBuilder: (context, index) {
                                          // value = value.reversed.toList();

                                          bool isMe = value[index].isMe!;

                                          var media = value[index].media;

                                          /// All Messages in Chat
                                          return Row(
                                            mainAxisAlignment: isMe
                                                ? MainAxisAlignment.end
                                                : MainAxisAlignment.start,
                                            children: [
                                              Stack(
                                                children: [
                                                  Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 20.w,
                                                            vertical: 12.h),
                                                    decoration: BoxDecoration(
                                                      color: isMe
                                                          ? null
                                                          : OColors
                                                              .greyScale100,
                                                      gradient: isMe
                                                          ? AppGradients
                                                              .purpleGradient
                                                          : null,
                                                      borderRadius: isMe
                                                          ? BorderRadius.only(
                                                              topLeft: Radius.circular(15.r),
                                                              bottomRight: Radius.circular(15.r),
                                                              bottomLeft: Radius.circular(15.r))
                                                          : BorderRadius.only(
                                                              topRight: Radius.circular(15.r),
                                                              bottomRight: Radius.circular(15.r),
                                                              bottomLeft: Radius.circular(15.r)),
                                                    ),
                                                    child: Column(
                                                      crossAxisAlignment: isMe
                                                          ? CrossAxisAlignment
                                                              .end
                                                          : CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        value[index].content ==
                                                                    null &&
                                                                value[index]
                                                                    .media!
                                                                    .isNotEmpty
                                                            ? value[index].media![0]
                                                                        .url!
                                                                        .endsWith('opus') ||
                                                                    value[index]
                                                                        .media![
                                                                            0]
                                                                        .url!
                                                                        .endsWith(
                                                                            'aac')
                                                                ?

                                                                /// Audio
                                                                AudioPlayerWidget(
                                                                    url: value[index].media![0].url!,
                                                                    sendingTime: OFormatter.formatTime(formatTime(value[index].createdAt!)),
                                                                    isMe: isMe,
                                                                  )
                                                                :

                                                                /// Image
                                                                Container(
                                                                    padding: EdgeInsets.symmetric(
                                                                        horizontal:
                                                                            2.w,
                                                                        vertical:
                                                                            2.h),
                                                                    child:
                                                                        Stack(
                                                                      children: [
                                                                        InkWell(
                                                                          onTap:
                                                                              () {
                                                                            setState(() {
                                                                              isSendingImage = false;
                                                                              // isImageShown = true;
                                                                              imageUrl = value[index].media![0].url!;
                                                                            });
                                                                            context.pushNamed(ORoutesName.imageDetailScreenRoute, arguments: {
                                                                              'imageUrl': imageUrl,
                                                                              'heroTag': 'imageHero$index',
                                                                              'nameOfSender': isMe ? 'You' : 'Other',
                                                                            });
                                                                          },
                                                                          child:
                                                                              Hero(
                                                                            tag:
                                                                                'imageHero$index',
                                                                            child: value[index].id == null
                                                                                ? ConstrainedBox(
                                                                                    constraints: BoxConstraints(
                                                                                      minWidth: ODeviceUtils.getScreenWidth(context) / 4,
                                                                                      maxWidth: ODeviceUtils.getScreenWidth(context) / 4,
                                                                                    ),
                                                                                    child: Image.file(File(localImagePath!)),
                                                                                  )
                                                                                : ConstrainedBox(
                                                                                    constraints: BoxConstraints(
                                                                                      minWidth: ODeviceUtils.getScreenWidth(context) / 4,
                                                                                      maxWidth: ODeviceUtils.getScreenWidth(context) / 4,
                                                                                    ),
                                                                                    child: value[index].media![0].url!.startsWith('http')
                                                                                        ? Image.network(value[index].media![0].url!)
                                                                                        : Image.file(File(value[index].media![0].url!)),
                                                                                  ),
                                                                          ),
                                                                        ),
                                                                        Positioned(
                                                                          right:
                                                                              8.w,
                                                                          bottom:
                                                                              2.h,
                                                                          child: Text(
                                                                              formatTime(value[index].createdAt!),
                                                                              style: OStyles.bodyMediumRegular.copyWith(color: OColors.greyScale400)),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  )
                                                            :

                                                            /// Content
                                                            Row(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .end,
                                                                children: [
                                                                  value[index].options?.url ==
                                                                          null
                                                                      ? InkWellWidget(
                                                                          onTap: () {
                                                                            if (contentErrors.isNotEmpty) {
                                                                              for (var element in contentErrors) {
                                                                                if (value[index].content == element) {
                                                                                  contentLoading = element;
                                                                                  inboxCubit.inboxFunction(orderId: widget.data['orderId'].toString(), content: element);
                                                                                  setState(() {});
                                                                                  logWarning((contentErrors.any((error) => value[index].content == error) && state is InboxLoadingState && contentLoading == value[index].content).toString());
                                                                                }
                                                                              }
                                                                            }
                                                                          },
                                                                          child:
                                                                              TextMessageWidget(
                                                                                 color: isMe ? OColors.whiteColor : OColors.greyScale900,
                                                                            text:
                                                                                value[index].content!,
                                                                            isMe:
                                                                                isMe,
                                                                            isError: contentErrors.any((error) =>
                                                                                value[index].content ==
                                                                                error),
                                                                            isLoading: contentErrors.any((error) => value[index].content == error) &&
                                                                                state is InboxLoadingState &&
                                                                                contentLoading == value[index].content,
                                                                          ),
                                                                        )
                                                                      : !isMe
                                                                          ? Column(
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                              children: [
                                                                                Container(
                                                                                  constraints: BoxConstraints(
                                                                                    maxWidth: ODeviceUtils.getScreenWidth(context).w / 2,
                                                                                  ),
                                                                                  child: Text.rich(
                                                                                    TextSpan(
                                                                                      text: value[index].content!.contains('provider_request_additional_cost') ? 'Provider Request Additional Cost: ' : '',
                                                                                      style: OStyles.bodyLargeRegular.copyWith(
                                                                                        color: OColors.greyScale900,
                                                                                      ),
                                                                                      children: [
                                                                                        if (value[index].content!.contains('%'))
                                                                                          TextSpan(
                                                                                            text: '55%',
                                                                                            style: OStyles.bodyLargeBold.copyWith(
                                                                                              color: OColors.primaryColor500,
                                                                                            ),
                                                                                          ),
                                                                                      ],
                                                                                    ),
                                                                                    textAlign: isMe ? TextAlign.left : TextAlign.right,
                                                                                    overflow: TextOverflow.clip,
                                                                                  ),
                                                                                ),

                                                                                ///Make Space
                                                                                if (value[index].options?.actionStatus == '1') SizedBox(height: 16.w),
                                                                                state is MakeActionLoadingState && indexButtonSelected == index
                                                                                    ? Center(
                                                                                        child: Container(
                                                                                        height: 30.h,
                                                                                        width: 30.w,
                                                                                        child: const LoadingTwo(),
                                                                                      ))
                                                                                    : (state is MakeActionSuccessState && indexButtonSelected == index) || value[index].options?.actionStatus == '0'
                                                                                        ? const SizedBox()
                                                                                        : Row(
                                                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                            children: [
                                                                                              // First option
                                                                                              Container(
                                                                                                width: ODeviceUtils.getScreenWidth(context) / 4.8,
                                                                                                height: ODeviceUtils.getScreenHeight(context) / 28,
                                                                                                child: SecondButtonWidget(
                                                                                                  bgColor: value[index].options!.options![0].name == 'accept' ? OColors.primaryColor500 : Colors.transparent,
                                                                                                  widget: Text(value[index].options!.options![0].name == 'accept' ? 'Accept' : 'Reject' ?? 'Option', style: OStyles.bodyMediumMedium.copyWith(color: value[index].options!.options![0].name == 'accept' ? OColors.whiteColor : OColors.blackColor)),
                                                                                                  border: value[index].options!.options![0].name == 'reject'
                                                                                                      ? Border.all(
                                                                                                          color: OColors.primaryColor500,
                                                                                                          width: 2.w,
                                                                                                        )
                                                                                                      : null,
                                                                                                  borderRadius: BorderRadius.circular(15.r),
                                                                                                  onTap: () {
                                                                                                    indexButtonSelected = index;
                                                                                                    setState(() {});
                                                                                                    inboxCubit.makeActionFunc(messageId: inboxCubit.getAllMessagesModel.result!.messages![index].id!, responseValue: '1');
                                                                                                    // inboxCubit.makeActionFunc(messageId: value[index].id!, responseValue: '1');
                                                                                                  },
                                                                                                ),
                                                                                              ),

                                                                                              SizedBox(width: 12.w),
                                                                                              // Space between buttons

                                                                                              /// Second option
                                                                                              Container(
                                                                                                width: ODeviceUtils.getScreenWidth(context) / 4.8,
                                                                                                height: ODeviceUtils.getScreenHeight(context) / 28,
                                                                                                child: SecondButtonWidget(
                                                                                                  bgColor: value[index].options!.options![1].name == 'accept' ? OColors.primaryColor500 : Colors.transparent,
                                                                                                  widget: Text(value[index].options!.options![1].name == 'accept' ? 'Accept' : 'Reject' ?? 'Option', style: OStyles.bodyMediumMedium.copyWith(color: value[index].options!.options![1].name == 'accept' ? OColors.whiteColor : OColors.blackColor)),
                                                                                                  border: value[index].options!.options![1].name == 'reject'
                                                                                                      ? Border.all(
                                                                                                          color: OColors.primaryColor500,
                                                                                                          width: 2.w,
                                                                                                        )
                                                                                                      : null,
                                                                                                  borderRadius: BorderRadius.circular(15.r),
                                                                                                  onTap: () {
                                                                                                    // logSuccess(inboxCubit.getAllMessagesModel.result!.messages![index].id!.toString());
                                                                                                    // OCacheHelper.putInt(key: CacheKeys.buttonIndex, value: index);
                                                                                                    indexButtonSelected = index;
                                                                                                    setState(() {});
                                                                                                    inboxCubit.makeActionFunc(messageId: value[index].id!, responseValue: '0');
                                                                                                  },
                                                                                                ),
                                                                                              ),
                                                                                            ],
                                                                                          ),
                                                                              ],
                                                                            )
                                                                          : InkWellWidget(
                                                                    onTap: () {
                                                                      if (contentErrors.isNotEmpty) {
                                                                        for (var element in contentErrors) {
                                                                          if (value[index].content == element) {
                                                                            contentLoading = element;
                                                                            inboxCubit.inboxFunction(orderId: widget.data['orderId'].toString(), content: element);
                                                                            setState(() {});
                                                                            logWarning((contentErrors.any((error) => value[index].content == error) && state is InboxLoadingState && contentLoading == value[index].content).toString());
                                                                          }
                                                                        }
                                                                      }
                                                                    },
                                                                    child:
                                                                    TextMessageWidget(
                                                                      color: isMe ? OColors.whiteColor : OColors.greyScale900,
                                                                      text:
                                                                      value[index].content!,
                                                                      isMe:
                                                                      isMe,
                                                                      isError: contentErrors.any((error) =>
                                                                      value[index].content ==
                                                                          error),
                                                                      isLoading: contentErrors.any((error) => value[index].content == error) &&
                                                                          state is InboxLoadingState &&
                                                                          contentLoading == value[index].content,
                                                                    ),
                                                                  ),
                                                                  Text('    ',
                                                                      style: OStyles
                                                                          .bodyMediumRegular
                                                                          .copyWith(
                                                                              color: OColors.greyScale400)),
                                                                  Text(
                                                                      OFormatter.formatTime(formatTime(
                                                                          value[index]
                                                                              .createdAt!)),
                                                                      style: OStyles
                                                                          .bodyMediumRegular
                                                                          .copyWith(
                                                                              color: OColors.greyScale400)),
                                                                ],
                                                              ),
                                                        // if(value[index].content == null )
                                                        //   Row(
                                                        //   children: [
                                                        //     Text(OFormatter.formatTime(formatTime(value[index].createdAt!)), style: OStyles.bodyMediumRegular.copyWith(color: OColors.greyScale400)),
                                                        //
                                                        //     // Text(), style: OStyles.bodyMediumRegular.copyWith(color: OColors.greyScale400)),
                                                        //   ],
                                                        // ),
                                                      ],
                                                    ),
                                                  ),
                                                  // if(value[index].content == null) Positioned(
                                                  //   right: 8.w,
                                                  //   bottom: 2.h,
                                                  //   child: Text(formatTime(value[index].createdAt!), style: OStyles.bodyMediumRegular.copyWith(color: OColors.greyScale400)),
                                                  // )
                                                ],
                                              ),
                                            ],
                                          );
                                        },
                                      );
                          },
                        ),
                      )),

                      /// Field, Select Image, Send/Recorde Icon
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 10.h),
                        child: Column(
                          children: [
                            /// In Provider Application
                            // Container(
                            //   color: OColors.greyScale100,
                            //   padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 34.h),
                            //   // color: Colors.red,
                            //   child: Row(
                            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //     children: [
                            //       Text('Total', style: OStyles.bodyXLargeSemiBold),
                            //       Text('300', style: OStyles.bodyXLargeSemiBold),
                            //       GestureDetector(
                            //         onTap: () {
                            //           inboxCubit.makeOrderIsDoneFunc(orderId: widget.data['orderId'], paymentMethod: 'cash');
                            //         },
                            //         child: Container(
                            //           padding: EdgeInsets.symmetric(horizontal: 36.w, vertical: 16.h),
                            //           decoration: BoxDecoration(
                            //             color: OColors.primaryColor500,
                            //             borderRadius: BorderRadius.circular(12.r),
                            //           ),
                            //           child:  Center(
                            //             child: state is MakeOrderIsDoneLoadingState
                            //                 ? Lottie.asset(OImages.loadingTwo, height: ODeviceUtils.getScreenHeight(context) / 34)
                            //                 : Text('Buy', style: OStyles.bodyXLargeSemiBold.copyWith(color: OColors.whiteColor)),
                            //           ),
                            //         ),
                            //       ),
                            //       // ThirdButtonWidget(
                            //       //   isRejected: false,
                            //       //   widgetInButton: Center(
                            //       //     child: Text('Buy', style: OStyles.bodyXLargeSemiBold.copyWith(color: OColors.primaryColor500)),
                            //       //   ),
                            //       //   textStyle: OStyles.bodyXLargeSemiBold,
                            //       //   containerColor: OColors.primaryColor500,
                            //       //   width: 0,
                            //       //   height: 0,
                            //       //   borderRadius: 27.r,
                            //       //   onTap: () {
                            //       //
                            //       //   },
                            //       // )
                            //     ]
                            //   ),
                            // ),

                            Padding(
                              padding: EdgeInsets.only(
                                right: 12.w,
                                left: 12.w,
                                bottom: 30.h,
                              ),
                              // padding: EdgeInsets.symmetric(
                              //     vertical: 10.h, horizontal: 16.w),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: _isRecording
                                        ?

                                        /// Record Design
                                        // AudioWaveforms(
                                        //   enableGesture: true,
                                        //   size: Size(
                                        //       MediaQuery.of(context).size.width / 2,
                                        //       50),
                                        //   recorderController: recorderController,
                                        //   waveStyle: const WaveStyle(
                                        //     waveColor: Colors.white,
                                        //     extendWaveform: true,
                                        //     showMiddleLine: false,
                                        //   ),
                                        //   decoration: BoxDecoration(
                                        //     borderRadius: BorderRadius.circular(12.0),
                                        //     color: const Color(0xFF1E1B26),
                                        //   ),
                                        //   padding: const EdgeInsets.only(left: 18),
                                        //   margin: const EdgeInsets.symmetric(
                                        //       horizontal: 15),
                                        // )

                                        _buildRecordingIndicator()

                                        /// Field To Write
                                        : TextFormFieldWidget(
                                            controller: controller,
                                            textInputType:
                                                TextInputType.emailAddress,
                                            focusNode: focusNode,
                                            hintText: AppLocalizations.of(context)!.translate('message')!,
                                      onChanged: (value) {
                                        logWarning(value);
                                        if(value != '') {
                                          setState(() {
                                            content = value;
                                          });
                                        }
                                      },
                                            hintColor: isFieldFocused
                                                ? OColors.primaryColor500
                                                : OColors.greyScale500,
                                            suffixIcon: IconButton(
                                                icon: Icon(Icons.image,
                                                    color: OColors.greyScale300,
                                                    size: 25.sp),
                                                onPressed: sendPhotoOrVideo),
                                            fillColor: isFieldFocused
                                                ? OColors.purpleTransparent
                                                    .withOpacity(.08)
                                                : OColors.greyScale50,
                                            borderSide: isFieldFocused
                                                ? BorderSide(
                                                    color:
                                                        OColors.primaryColor500)
                                                : BorderSide.none,
                                            obscureText: false,
                                          ),
                                  ),
                                  SizedBox(width: 16.w),
                                  GestureDetector(
                                      onTap: controller.text.isNotEmpty
                                          ?
                                          /// When Make Recorde
                                          () {
                                              XFile? file = _selectPhotoOrVideo;
                                              List<String> media = [];
                                              if (file != null) {
                                                media.add(file.path);
                                              }

                                              inboxCubit.inboxFunction(
                                                  orderId: widget.data['orderId'].toString(),
                                                  content: controller.text);
                                              setState(() {
                                                messagesListLocally.value.insert(0, Messages(content: controller.text, isMe: true, media: [], options: null, createdAt: DateTime.now().toString()));

                                                messagesListLocally.value = List<Messages>.from(messagesListLocally.value);
                                                controller.clear();
                                              });
                                            }
                                          : () {},
                                      onLongPressStart: (details) {
                                        startRecording();
                                      },
                                      onLongPressEnd: (details) {
                                        stopRecording();
                                      },

                                      /// Send / Recorde Icon
                                      child: Container(
                                        height: 56.h,
                                        width: 56.w,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50.r),
                                          gradient: AppGradients.purpleGradient,
                                        ),
                                        child: Center(
                                          child: Icon(
                                            controller.text.isNotEmpty ||
                                                    _selectPhotoOrVideo != null
                                                ? Icons.send
                                                : _isRecording
                                                    ? Icons.stop
                                                    : Icons.mic,
                                            color: OColors.whiteColor,
                                          ),
                                        ),
                                      )),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  /// When Select Image to Send in Chat
                  if(isImageShown) Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: OColors.blackColor.withOpacity(.5),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        isSendingImage
                            ? Image.file(File(_selectPhotoOrVideo!.path))
                            : imageUrl.startsWith('http')
                            ? Image.network(imageUrl)
                            : Image.file(File(localImagePath!)),

                        Positioned(
                            top: ODeviceUtils.getScreenHeight(context).h / 10,
                            left: 25.w,
                            child: CircleAvatar(
                              backgroundColor: OColors.primaryColor400,
                              child: IconButton(onPressed: () {
                                setState(() {
                                  isImageShown = false;
                                });
                              }, icon: Icon(Icons.close, color: OColors.whiteColor)),
                            )),

                        if(isSendingImage) Positioned(
                          bottom: 30.h,
                          child: CircleAvatar(
                            backgroundColor: OColors.primaryColor500,
                            child: IconButton(onPressed: () {
                              List<String> media = [];
                              if (_selectPhotoOrVideo != null) {
                                media.add(_selectPhotoOrVideo!.path);
                              }

                              inboxCubit.inboxFunction(
                                  orderId: widget.data['orderId'].toString(),
                                  mediaList: media);
                              setState(() {
                                messagesListLocally.value.insert(0, Messages(id: 10, content: null, isMe: true, media: [Media(url: _selectPhotoOrVideo!.path)], options: null, createdAt: DateTime.now().toString()));
                                messagesListLocally.value = List<Messages>.from(messagesListLocally.value);
                              });

                              setState(() {
                                isImageShown = false;
                                isSendingImage = false;
                                _selectPhotoOrVideo = null;
                              });
                            }, icon: Icon(Icons.send, color: OColors.whiteColor)),
                          ),
                        )
                      ],
                    ),
                  ),

                  // if(orderNumber != null) ...[
                  Positioned(
                    top: ODeviceUtils.getScreenHeight(context) / 7,
                    left: ODeviceUtils.getScreenWidth(context) / 3.6,
                    // right: ODeviceUtils.getScreenWidth(context) / 2,
                    child: ContainerNumberOfOrderWidget(
                      numberOfOrder: (OffersOrdersCubit.get(context).getAllMessagesModel.result?.messages?.last.content ?? '').split('number ').last,
                      // Order accepted, number #1
                    ),
                  ),
                  // ],
                  // if(!isImageShown) ContainerNumberOfOrderWidget(numberOfOrder: inboxCubit.getAllMessagesModel.result!.messages!.last.content!),
                ],
              ),
            );
          },
        ),
        // ),
      ),
    );
  }

  /// Open Gallery
  Future<void> sendPhotoOrVideo() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _selectPhotoOrVideo = image;
        isImageShown = true;

        /// todo
        isSendingImage = true;
        localImagePath = _selectPhotoOrVideo!.path;
        print(_selectPhotoOrVideo!.path);
      });
    } else {
      // User canceled the image picking
      print('No image selected');
    }
  }

  /// Start Record
  void _startOrStopRecording(BuildContext context) async {
    _requestRecordPermissions(context);

    try {
      if (_recordAllowed) {
        if (isRecording) {
          recorderController.reset();

          path = await recorderController.stop(false);

          if (path != null) {
            isRecordingCompleted = true;
            Future.delayed(Duration.zero).then((value) async {
              await OffersOrdersCubit.get(context).inboxFunction(
                  orderId: widget.data['orderId'].toString(),
                  content: controller.text,
                  mediaList: [path!]);
            });
            debugPrint('Test $path');
            debugPrint("Recorded file size: ${File(path!).lengthSync()}");
          }
        } else {
          path = "${appDirectory.path}/recording.opus";
          await recorderController.record(path: path);
        }
      } else {
        _requestRecordPermissions(context);
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setState(() {
        isRecording = !isRecording;
      });
    }
  }

  /// Record Directory
  Future<void> _getDir() async {
    appDirectory = Directory(
      "${(await getApplicationDocumentsDirectory()).path}/Osta/Records",
    );
    if (appDirectory.existsSync() == false) {
      await appDirectory.create(recursive: true);
    }
    path = "${appDirectory.path}/recording.opus";
    setState(() {});
  }

  void _requestRecordPermissions(BuildContext context) async {
    PermissionStatus storageStatus = await Permission.storage.status;
    PermissionStatus microphoneStatus = await Permission.microphone.status;

    if (microphoneStatus.isDenied ||
        microphoneStatus.isRestricted ||
        microphoneStatus.isLimited) {
      // Request microphone permission
      microphoneStatus = await Permission.microphone.request();
    }

    // await Permission.storage([PermissionGroup.storage]);

    // if (storageStatus.isDenied || storageStatus.isRestricted || storageStatus.isLimited) {
    //   // Request storage permission
    //   storageStatus = await Permission.storage.request();
    // }
    Map<Permission, PermissionStatus> statuses = await [
      Permission.camera,
      Permission.microphone,
      // Add other permissions you need here
    ].request();

    // Handle the cases when the user has permanently denied the permissions
    if (microphoneStatus.isPermanentlyDenied) {
      // Show a dialog guiding the user to app settings
      _showPermissionDialog(context, 'Microphone Permission',
          'This app needs microphone access to record audio. Please enable microphone access in the app settings.');
    }

    if (storageStatus.isPermanentlyDenied) {
      // Show a dialog guiding the user to app settings
      _showPermissionDialog(context, 'Storage Permission',
          'This app needs storage access to save recordings. Please enable storage access in the app settings.');
    }

    _recordAllowed = storageStatus.isGranted && microphoneStatus.isGranted;

    setState(() {});

    if (!microphoneStatus.isGranted) {
      // showToast(context.micPermissionError, ToastState.warning);
    }
    if (!storageStatus.isGranted) {
      // showToast(context.storagePermissionError, ToastState.warning);
    }

    if (_recordAllowed) {
      await _getDir();
    }
  }

  void _showPermissionDialog(
      BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(AppLocalizations.of(context)!.translate('cancel')!),
            ),
            TextButton(
              onPressed: () {
                openAppSettings();
                Navigator.of(context).pop();
              },
              child: Text(AppLocalizations.of(context)!.translate('openSettings')!),
            ),
          ],
        );
      },
    );
  }

  /// Download Audio
  Future<File?> _downloadMedia(int orderId, int mediaId) async {
    try {
      if (appDirectory == null) return null;
      final file = File('${appDirectory?.path}/$orderId/$mediaId.opus');
      if (file.existsSync()) {
        logSuccess("file: ${file.path}");
        return file;
      }
      await DioHelper.downloadMedia(
        url: 'downloadFiles',
        path: file.path,
        onReceiveProgress: showDownloadProgress,
        query: {
          "id": mediaId,
        },
      );
      logSuccess("file: ${file.path}");
      logSuccess("===============================================");
      return file;
    } on DioError catch (e) {
      logError("downloadMedia Error Response: ${e.requestOptions}");
      logError("downloadMedia Error Response: ${e.response}");
    } catch (e) {
      logError("downloadMedia Error: $e");
    }
    return null;
  }

  void showDownloadProgress(received, total) {
    if (total != -1) {
      logSuccess((received / total * 100).toStringAsFixed(0) + "%");
    }
  }
}

class ImageDetailScreen extends StatelessWidget {
  final Map<dynamic, dynamic> data;

  const ImageDetailScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: OColors.greyScale50,
      appBar: AppBar(
        backgroundColor: OColors.greyScale50,
        title: Text(data['nameOfSender'], style: OStyles.bodyXLargeBold),
      ),
      body: Center(
        child: Hero(
          tag: data['heroTag'],
          child: data['imageUrl'].startsWith('http') ? Image.network(data['imageUrl']) : Image.file(File(data['imageUrl'])),
        ),
      ),
    );
  }
}

/// Widget
class TextMessageWidget extends StatelessWidget {
  const TextMessageWidget(
      {super.key,
      required this.text,
      required this.isMe,
      required this.isError,
      required this.color,
      required this.isLoading});

  final String text;
  final Color color;
  final bool isMe, isError, isLoading;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: ODeviceUtils.getScreenWidth(context).w / 2,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (isError && !isLoading)
            Icon(Icons.info, size: 24.sp, color: OColors.warning),
          if (isLoading)
            SizedBox(
              width: 30.w,
              height: 30.h,
              child: const Center(child: LoadingTwo()),
            ),
          if (isError || isLoading) SizedBox(width: 8.w),
          Flexible(
            child: Text(
              text,
              style: OStyles.bodyLargeRegular.copyWith(color: color),
              // overflow: TextOverflow.clip,
              textAlign: isMe ? TextAlign.right : TextAlign.left,
            ),
          ),
        ],
      ),
    );
  }
}
