import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:osta_user_app/features/offer/managers/offers_orders_cubit.dart';
import 'package:osta_user_app/features/offer/models/inbox/get_all_messages_model.dart';
import 'package:osta_user_app/features/offer/presentation/widgets/inbox/audio_message_bubble.dart';
import 'package:osta_user_app/utils/constants/exports.dart';
import 'package:osta_user_app/utils/constants/log_util.dart';
import 'package:osta_user_app/utils/dio/dio_helper.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

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

  int countPage = 1;
  List<MessageResult> messagesListLocally = [];

  @override
  void initState() {
    super.initState();

    /// Add listener to focus node
    focusNode.addListener(() => setState(() => isFieldFocused = focusNode.hasFocus));

    /// To Refresh Messages
    OffersOrdersCubit.get(context).getAllMessagesFunction(
        orderId: widget.data['orderId'].toString(), page: countPage, perPage: 10);

    setState(() {
      countPage++;
    });

    _getDir();
    _initialiseControllers();
    scrollController.addListener(() {
      if (scrollController.offset >= scrollController.position.maxScrollExtent &&
          !scrollController.position.outOfRange) {

        if(OffersOrdersCubit.get(context).getAllMessagesModel.result!.isEmpty || OffersOrdersCubit.get(context).getAllMessagesModel.result == []) {

        } else {

          OffersOrdersCubit.get(context).getAllMessagesFunction(
              orderId: widget.data['orderId'].toString(), page: countPage, perPage: 10);

          setState(() {
            countPage++;
          });
        }

        // Reached the bottom
        logSuccess('Reached the bottom');

      }

      if (scrollController.offset <= scrollController.position.minScrollExtent &&
          !scrollController.position.outOfRange) {


        // Reached the top
        logSuccess('Reached the top');
      }
    });
  }

  @override
  void dispose() {
    recorderController.dispose();
    playerController.dispose();
    /// Clean up the focus node and controller when the widget is disposed.
    focusNode.dispose();
    controller.dispose();
    scrollController.dispose();
    super.dispose();
  }

  String formatTime(String dateTimeString) {
    final DateTime dateTime = DateTime.parse(dateTimeString);
    final DateFormat formatter = DateFormat('HH:mm');
    return formatter.format(dateTime);
  }


  void _initialiseControllers() {
    recorderController = RecorderController()
      ..androidEncoder = AndroidEncoder.aac
      ..androidOutputFormat = AndroidOutputFormat.mpeg4
      ..iosEncoder = IosEncoder.kAudioFormatMPEG4AAC
      ..sampleRate = 44100;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<OffersOrdersCubit, OffersOrdersState>(
        listener: (context, state) {
          if(state is GetAllMessagesSuccessState) {
            messagesListLocally.addAll(OffersOrdersCubit.get(context).getAllMessagesModel.result!);
            print(messagesListLocally);
          }
          if (state is InboxSuccessState) {
            OffersOrdersCubit.get(context).getAllMessagesFunction(
              orderId: widget.data['orderId'].toString(),
              perPage: 10,
              page: countPage,
            );
            // setState(() {
            //   countPage++;
            // });
          }
          else if (state is InboxLoadingState) {
            controller.clear();
          }
        },
        builder: (context, state) {
          var inboxCubit = OffersOrdersCubit.get(context);

          return Stack(
            children: [

              Padding(
                padding: EdgeInsets.only(left: 24.w, right: 24.w, top: 68.h),
                child: Column(
                  children: [

                    /// App Bar
                    AppBarWidget(
                      leading: IconButton(
                          icon: const Icon(Icons.arrow_back), onPressed: () {
                        context.pop();
                        messagesListLocally.clear();
                        inboxCubit.getAllMessagesModel = GetAllMessagesModel();
                      }), title: 'Order number ${widget.data['orderId']}',
                      actions: Container(),
                      widthOfText: 260.w,
                    ),

                    /// Make Space
                    SizedBox(height: 24.h),

                    /// Body in Chat
                    Expanded(
                      child: state is InboxLoadingState ||
                          inboxCubit.getAllMessagesModel.result == null ?
                      LoadingWidget(iconColor: OColors.primaryColor500) :
                      inboxCubit.getAllMessagesModel.result!.isEmpty && messagesListLocally.isEmpty ?
                      const Text('Empty Messages') :
                      ListView.separated(
                        controller: scrollController,
                        shrinkWrap: true,
                        reverse: true,
                        itemCount: messagesListLocally.length,
                        separatorBuilder: (context, index) {
                          return SizedBox(height: 12.h);
                        },
                        itemBuilder: (context, index) {
                          bool isMe = messagesListLocally[index]
                              .isMe!;

                          /// All Messages in Chat
                          return Row(
                            mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
                            children: [
                              Container(
                                constraints: BoxConstraints(
                                    minWidth: ODeviceUtils
                                        .getScreenWidth(context)
                                        .w / 3),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 12.w, vertical: 12.h),
                                decoration: BoxDecoration(
                                  color: isMe ? OColors.primaryColor500 : OColors.blueTransparent,
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(12.r),
                                    bottomLeft: Radius.circular(12.r),
                                    bottomRight: Radius.circular(12.r),
                                  ),
                                ),

                                child: Column(
                                  crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                                  children: [
                                    messagesListLocally[index].content == null && messagesListLocally[index].media!.isNotEmpty ?
                                    messagesListLocally[index].media![0].url!.endsWith('opus') ?
                                    FutureBuilder<File?>(
                                        key: Key("${messagesListLocally[index].id}"),
                                        future: _downloadMedia(
                                          messagesListLocally[index].id!,
                                          messagesListLocally[index].media![0].id!,
                                        ),
                                        builder: (context, snap) {
                                          if (snap.data == null) {
                                            return const SizedBox();
                                          }
                                          return AudioMessageBubble(
                                            audioMessage: snap.data!,
                                            isSender: messagesListLocally[index].isMe!,
                                          );
                                        }) :
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          isSendingImage = false;
                                          isImageShown = true;
                                          imageUrl =
                                          inboxCubit.getAllMessagesModel
                                              .result![index].media![0].url!;
                                        });
                                      },
                                      child: Image.network(
                                        messagesListLocally[index].media![0].url!,
                                        height: 120.h, width: 100.w,),
                                    ) :
                                    Text(messagesListLocally[index].content ?? '',
                                        style: OStyles.bodyLargeRegular
                                            .copyWith(
                                            color: OColors.whiteColor)),
                                    Row(
                                      children: [
                                        // Icon(Icons.check, color: inboxCubit
                                        //     .getAllMessagesModel.result![index]
                                        //     .isRead! ? Colors.blue : OColors
                                        //     .greyScale300, size: 18.sp),
                                        // SizedBox(width: 8.w),
                                        Text(formatTime(messagesListLocally[index].createdAt!), style: OStyles.bodyMediumRegular.copyWith(color: OColors.whiteColor))
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ) ;
                        },
                      ),
                    ),

                    /// Field, Select Image, Send/Recorde Icon
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 12.w, vertical: 10.h),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: isRecording ?
                                    /// Record Design
                                    AudioWaveforms(
                                  enableGesture: true,
                                  size: Size(
                                      MediaQuery.of(context).size.width / 2,
                                      50),
                                  recorderController: recorderController,
                                  waveStyle: const WaveStyle(
                                    waveColor: Colors.white,
                                    extendWaveform: true,
                                    showMiddleLine: false,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12.0),
                                    color: const Color(0xFF1E1B26),
                                  ),
                                  padding: const EdgeInsets.only(left: 18),
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                )

                                    /// Field To Write
                                    : TextFormFieldWidget(
                                  controller: controller,
                                  textInputType: TextInputType.emailAddress,
                                  focusNode: focusNode,
                                  hintText: 'Message',
                                  onChanged: (p0) => setState(() {}),
                                  hintColor: isFieldFocused ? OColors
                                      .primaryColor500 : OColors.greyScale500,
                                  suffixIcon: IconButton(icon: Icon(Icons.image, color: OColors.greyScale300, size: 25.sp), onPressed: sendPhotoOrVideo),
                                  fillColor: isFieldFocused
                                      ? OColors.purpleTransparent.withOpacity(
                                      .08)
                                      : OColors.greyScale50,
                                  borderSide: isFieldFocused
                                      ? BorderSide(
                                      color: OColors.primaryColor500)
                                      : BorderSide.none,
                                  obscureText: false,
                                ),
                              ),
                              SizedBox(width: 16.w),

                              GestureDetector(
                                  onTap: controller.text.isNotEmpty ?
                                      /// When Make Recorde
                                      () {
                                    XFile? file = _selectPhotoOrVideo;
                                    List<String> media = [];
                                    if (file != null) {
                                      media.add(file.path);
                                    }

                                    inboxCubit.inboxFunction(orderId: widget.data['orderId'].toString(), content: controller.text);
                                  } :
                                      () {},
                                  onLongPressStart: (details) {
                                    _startOrStopRecording();
                                  },
                                  onLongPressEnd: (details) {
                                    _startOrStopRecording();
                                  },

                                  /// Send / Recorde Icon
                                  child: Container(
                                    height: 56.h,
                                    width: 56.w,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            50.r),
                                        gradient: AppGradients.purpleGradient
                                    ),
                                    child: Center(
                                      child: Icon(controller.text.isNotEmpty ||
                                          _selectPhotoOrVideo != null ? Icons
                                          .send : Icons.mic,
                                          color: OColors.whiteColor,
                                      ),
                                    ),
                                  )),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
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
                        : Image.network(imageUrl),

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
            ],
          );
        },
      ),
      // ),
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
      print(_selectPhotoOrVideo!.path);
      });
    } else {
      // User canceled the image picking
      print('No image selected');
    }
  }

  /// Start Record
  void _startOrStopRecording() async {
    try {
      if (isRecording) {
        recorderController.reset();

        path = await recorderController.stop(false);

        if (path != null) {
          isRecordingCompleted = true;
          Future.delayed(Duration.zero).then((value) async {
            await OffersOrdersCubit.get(context).inboxFunction(
                orderId: widget.data['orderId']
                    .toString(),
                content: controller.text,
                mediaList: [path!]);
          });
          debugPrint(path);
          debugPrint("Recorded file size: ${File(path!).lengthSync()}");
        }
      } else {
        await recorderController.record(path: path);
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setState(() {
        isRecording = !isRecording;
      });
    }
  }

  void _refreshWave() {
    if (isRecording) recorderController.refresh();
  }

  /// Record Directory
  Future<void> _getDir() async {
    appDirectory = Directory(
      "${(await getApplicationDocumentsDirectory()).path}/Seda/Records",
    );
    if (appDirectory.existsSync() == false) {
      await appDirectory.create(recursive: true);
    }
    path = "${appDirectory.path}/recording.opus";
    setState(() {});
  }

  void _requestRecordPermissions() async {
    _recordAllowed = ((await Permission.storage.request()) ==
        PermissionStatus.granted) &&
        ((await Permission.microphone.request()) == PermissionStatus.granted);
    setState(() {});

    if ((await Permission.microphone.status) != PermissionStatus.granted) {
      // showToast(context.micPermissionError, ToastState.warning);
    }
    if ((await Permission.storage.status) != PermissionStatus.granted) {
      // showToast(context.storagePermissionError, ToastState.warning);
    }

    if (_recordAllowed) {
      await _getDir();
    }
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