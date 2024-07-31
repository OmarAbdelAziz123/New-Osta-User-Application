import 'dart:async';

import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:osta_user_app/features/offer/managers/offers_orders_cubit.dart';
import 'package:osta_user_app/features/offer/managers/socket_cubit/socket_cubit.dart';
import 'package:osta_user_app/features/offer/models/inbox/get_all_messages_model.dart';
import 'package:osta_user_app/features/offer/presentation/widgets/inbox/audio_player_widget.dart';
import 'package:osta_user_app/features/profile/managers/profile_cubit.dart';
import 'package:osta_user_app/features/profile/models/help_center/get_tickets_customer_services_model.dart';
import 'package:osta_user_app/utils/constants/exports.dart';
import 'package:osta_user_app/utils/constants/log_util.dart';
import 'package:osta_user_app/utils/dio/dio_helper.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';

class CustomerServicesScreen extends StatefulWidget {
  const CustomerServicesScreen({super.key, required this.data});
  final Map data;

  @override
  State<CustomerServicesScreen> createState() => _CustomerServicesScreenState();
}

class _CustomerServicesScreenState extends State<CustomerServicesScreen> {
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
  List<Messages> messagesListLocally = [];


  FlutterSoundRecorder? _recorder;
  bool _isRecording = false;
  String _filePath = 'audio_example';

  Future<void> requestPermissions() async {
    await Permission.microphone.request();
    await Permission.storage.request();
  }

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
    setState(() {
      _isRecording = true;
    });
  }
  Timer? _timer;

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

  Future<void> stopRecording() async {
    await _recorder!.stopRecorder();
    setState(() {
      _isRecording = false;
    });
    await OffersOrdersCubit.get(context).inboxFunction(
        conversationId: widget.data['title']
            .toString(),
        content: controller.text,
        mediaList: [_filePath]);
  }

  @override
  void initState() {
    super.initState();

    /// Add listener to focus node
    focusNode.addListener(() => setState(() => isFieldFocused = focusNode.hasFocus));

    /// To Refresh Messages
    OffersOrdersCubit.get(context).getAllMessagesFunction(
        conversationId: widget.data['title'].toString(), page: countPage, perPage: 10);

    setState(() {
      countPage++;
    });

    _getDir();
    _initialiseControllers();
    scrollController.addListener(() {
      if (scrollController.offset >= scrollController.position.maxScrollExtent &&
          !scrollController.position.outOfRange) {

        if(OffersOrdersCubit.get(context).getAllMessagesModel.result!.messages!.isEmpty || OffersOrdersCubit.get(context).getAllMessagesModel.result!.messages == []) {

        } else {


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
    _recorder = FlutterSoundRecorder();
    // _recorder!.openAudioSession();
    openAudioSession();
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
    // player.dispose();
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
  String _formatDuration(int seconds) {
    final minutes = (seconds / 60).floor();
    final remainingSeconds = seconds % 60;
    return '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
  }
  int _recordingDuration = 0;
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
            '${AppLocalizations.of(context)!.translate('invite')!} ${_formatDuration(_recordingDuration)}',
            style: const TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: OColors.greyScale50,
      body: BlocConsumer<OffersOrdersCubit, OffersOrdersState>(
        listener: (context, state) {
          if(state is GetAllMessagesSuccessState) {
            if(context.mounted) {
              if(OCacheHelper.getString(key: CacheKeys.userId) != null) {
                logSuccess('In Navigation Menu');
                SocketCubit.get(context).socketFunc(
                  conversationId: OffersOrdersCubit.get(context).getAllMessagesModel.result!.conversation!.id!,
                  userId: int.parse(OCacheHelper.getString(key: CacheKeys.userId)!),
                );
              }
            }

            messagesListLocally.addAll(OffersOrdersCubit.get(context).getAllMessagesModel.result!.messages!);
            logSuccess(messagesListLocally.toString());
            setState(() {});
          }
          if (state is InboxSuccessState) {
            setState(() {
              // controller.text.isEmpty
              //     ? messagesListLocally.insert(0, MessageResult(media: [Media(url: localImagePath!)], isMe: true, createdAt: DateTime.now().toString()))
              //     :
              controller.clear();
              messagesListLocally.insert(0, OffersOrdersCubit.get(context).sendMessageResponse.data!);

              messagesListLocally = List<Messages>.from(messagesListLocally);

            });

            // setState(() {
            //   countPage++;
            // });
          }
        },
        builder: (context, state) {
          var inboxCubit = OffersOrdersCubit.get(context);

          return BlocListener<SocketCubit, SocketState>(
            listener: (context, state) {
              if(state is SocketInboxListenState) {
                setState(() {
                  // messagesListLocally.value.add(MessageResult(content: controller.text.trim(), isMe: true, createdAt: DateTime.now().toString()));
                  messagesListLocally.insert(0, SocketCubit.get(context).socketResponseModel.data!);

                  messagesListLocally = List<Messages>.from(messagesListLocally);

                  controller.clear();
                });
              }
            },
            child: Stack(
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
                        }), title: '${AppLocalizations.of(context)!.translate('ticketNumber')!} ${widget.data['title']}',
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
                        inboxCubit.getAllMessagesModel.result!.messages!.isEmpty && messagesListLocally.isEmpty ?
                        Text(AppLocalizations.of(context)!.translate('noMessages')!) :
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
                                      messagesListLocally[index].media![0].url!.endsWith('opus') || messagesListLocally[index].media![0].url!.endsWith('aac') ?
                                      AudioPlayerWidget(url: messagesListLocally[index].media![0].url!) :
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            isSendingImage = false;
                                            isImageShown = true;
                                            imageUrl = messagesListLocally[index].media![0].url!;
                                          });
                                        },
                                        child: messagesListLocally[index].id == null
                                            ? Image.file(File(localImagePath!), height: 120.h, width: 100.w,)
                                            : Image.network(messagesListLocally[index].media![0].url!, height: 120.h, width: 100.w,),
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
                                    textInputType: TextInputType.emailAddress,
                                    focusNode: focusNode,
                                    hintText: AppLocalizations.of(context)!.translate('message')!,
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

                                      inboxCubit.inboxFunction(conversationId: widget.data['title'].toString(), content: controller.text);
                                    } :
                                        () {},
                                    onLongPressStart: (details) {
                                      // _recordAllowed
                                      //     ? _startOrStopRecording(context)
                                      // _startOrStopRecording(context);
                                      startRecording();
                                      //     : _requestRecordPermissions(context);
                                    },
                                    onLongPressEnd: (details) {
                                      // _startOrStopRecording(context);
                                      stopRecording();
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
                                conversationId: widget.data['title'].toString(),
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
            ),
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
        isSendingImage = true;
        /// todo : Remove
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
      if(_recordAllowed) {
        if (isRecording) {
          recorderController.reset();

          path = await recorderController.stop(false);

          if (path != null) {
            isRecordingCompleted = true;
            Future.delayed(Duration.zero).then((value) async {

              /// TODO: ----------------------------------------------
              await OffersOrdersCubit.get(context).inboxFunction(
                  conversationId: widget.data['title']
                      .toString(),
                  content: controller.text,
                  mediaList: [path!]);
            });
            debugPrint(path);
            debugPrint("Recorded file size: ${File(path!).lengthSync()}");
          }
        }
        else {
          path = "${appDirectory.path}/recording.opus";
          await recorderController.record(path: path);
        }
      }
      else {
        _requestRecordPermissions(context);
        // ScaffoldMessenger.of(context).showSnackBar(
        //     SnackBar(
        //       duration: const Duration(seconds: 3),
        //       content: Text('You want be enable to record audio allow permission first', style: OStyles.bodyLargeRegular.copyWith(color: OColors.whiteColor)),
        //       backgroundColor: OColors.alertsAndStatusError,
        //       action: SnackBarAction(
        //         label: 'Enable permission',
        //         onPressed: () async {
        //           await Permission.microphone.request();
        //           _requestRecordPermissions();
        //         },
        //         backgroundColor: OColors.primaryColor500,
        //       ),
        //     ),
        // );
        // ODeviceUtils.showSnackBar(context: context, message: 'You want be enable to record audio allow permission first', textStyle: OStyles.bodyLargeRegular, textColor: OColors.whiteColor, bgColor: OColors.warning);
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

  void _requestRecordPermissions(BuildContext context) async {
    PermissionStatus storageStatus = await Permission.storage.status;
    PermissionStatus microphoneStatus = await Permission.microphone.status;

    if (microphoneStatus.isDenied || microphoneStatus.isRestricted || microphoneStatus.isLimited) {
      // Request microphone permission
      microphoneStatus = await Permission.microphone.request();
    }

    if (storageStatus.isDenied || storageStatus.isRestricted || storageStatus.isLimited) {
      // Request storage permission
      storageStatus = await Permission.storage.request();
    }

    // Handle the cases when the user has permanently denied the permissions
    if (microphoneStatus.isPermanentlyDenied) {
      // Show a dialog guiding the user to app settings
      _showPermissionDialog(context, 'Microphone Permission', 'This app needs microphone access to record audio. Please enable microphone access in the app settings.');
    }

    if (storageStatus.isPermanentlyDenied) {
      // Show a dialog guiding the user to app settings
      _showPermissionDialog(context, 'Storage Permission', 'This app needs storage access to save recordings. Please enable storage access in the app settings.');
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

  void _showPermissionDialog(BuildContext context, String title, String message) {
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
  Future<File?> _downloadMedia(int conversationId, int mediaId) async {
    try {
      if (appDirectory == null) return null;
      final file = File('${appDirectory?.path}/$conversationId/$mediaId.opus');
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
