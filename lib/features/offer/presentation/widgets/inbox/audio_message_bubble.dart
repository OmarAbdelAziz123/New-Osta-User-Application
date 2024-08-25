import 'dart:async';
import 'dart:io';

import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/material.dart';
import 'package:osta/utils/constants/exports.dart';

class AudioMessageBubble extends StatefulWidget {
  final bool isSender;
  final File audioMessage;
  final double? width;

  const AudioMessageBubble({
    Key? key,
    this.width,
    this.isSender = false,
    required this.audioMessage,
  }) : super(key: key);

  @override
  State<AudioMessageBubble> createState() => _AudioMessageBubbleState();
}

class _AudioMessageBubbleState extends State<AudioMessageBubble> {
  File? file;

  late PlayerController controller;
  late StreamSubscription<PlayerState> playerStateSubscription;

  final playerWaveStyle = PlayerWaveStyle(
    fixedWaveColor: OColors.greyScale50,
    liveWaveColor: OColors.blackColor,
  );

  @override
  void initState() {
    super.initState();
    controller = PlayerController();
    _preparePlayer();
    playerStateSubscription = controller.onPlayerStateChanged.listen((_) {
      setState(() {});
    });
  }

  void _preparePlayer() async {
    controller.preparePlayer(
      path: widget.audioMessage.path,
      shouldExtractWaveform: true,
      noOfSamples: playerWaveStyle.getSamplesForWidth(widget.width ?? 180),
    );
    controller
        .extractWaveformData(
      path: widget.audioMessage.path,
    )
        .then((waveformData) => debugPrint(waveformData.toString()));
  }

  @override
  void dispose() {
    playerStateSubscription.cancel();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: widget.isSender ? Alignment.centerRight : Alignment.centerLeft,
      child: Row(
        mainAxisAlignment:
        widget.isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          // widget.isLast
          //     ? SizedBox(
          //   height: 5.h,
          //   width: 5.h,
          //   child: Container(
          //     width: 13.h,
          //     height: 13.h,
          //     decoration: BoxDecoration(
          //       shape: BoxShape.circle,
          //       color: OColors.greyScale200.withOpacity(0.7),
          //     ),
          //     clipBehavior: Clip.antiAliasWithSaveLayer,
          //     child: widget.userImage.isNotEmpty
          //         ? Image.network(widget.userImage)
          //         : Padding(
          //       padding: EdgeInsets.all(15),
          //       child: FittedBox(
          //         child: Icon(
          //           Icons.person,
          //           color: OColors.whiteColor,
          //           size: 65,
          //         ),
          //       ),
          //     ),
          //   ),
          // )
          //     : SizedBox(
          //   width: 10.w,
          // ),
          SizedBox(
            width: 2.h,
          ),
          Directionality(
            textDirection:
            widget.isSender ? TextDirection.rtl : TextDirection.ltr,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 5),
              margin: EdgeInsets.only(bottom: 1.h),
              decoration: BoxDecoration(
                color: widget.isSender
                    ? OColors.greyScale500.withOpacity(0.1)
                    : OColors.greyScale50,
                borderRadius: widget.isSender
                    ? const BorderRadius.only(
                    topLeft: Radius.circular(100),
                    topRight: Radius.circular(100),
                    bottomLeft: Radius.circular(100))
                    : const BorderRadius.only(
                    topLeft: Radius.circular(100),
                    topRight: Radius.circular(100),
                    bottomRight: Radius.circular(100)),
              ),
              child: Row(
                children: [
                  if (!controller.playerState.isStopped)
                    Container(
                      padding: const EdgeInsets.all(8),
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        color: OColors.whiteColor,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: InkWell(
                        onTap: () async {
                          controller.playerState.isPlaying
                              ? await controller.pausePlayer()
                              : await controller.startPlayer(
                            finishMode: FinishMode.pause,
                          );
                        },
                        child: Icon(
                          controller.playerState.isPlaying
                              ? Icons.stop
                              : Icons.play_arrow,
                        ),
                      ),
                    ),
                  Padding(
                    padding: EdgeInsets.only(
                      right: !widget.isSender ? 8.0 : 0,
                      left: widget.isSender ? 8.0 : 0,
                    ),
                    child: AudioFileWaveforms(
                      size: Size(
                        MediaQuery.of(context).size.width / 2,
                        2.h,
                      ),
                      enableSeekGesture: true,
                      playerController: controller,
                      waveformType: WaveformType.fitWidth,
                      playerWaveStyle: playerWaveStyle,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
