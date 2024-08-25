import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:osta/utils/constants/colors.dart';
import 'package:osta/utils/constants/exports.dart';
import 'package:osta/utils/constants/log_util.dart';
import 'package:osta/utils/constants/text_styles.dart';
import '../../../../../utils/constants/styles.dart';

class AudioPlayerWidget extends StatefulWidget {
  const AudioPlayerWidget(
      {super.key,
      required this.url,
      this.sendingTime,
      this.isMe,
      required this.isInbox});

  final String url;
  final String? sendingTime;
  final bool? isMe;
  final bool isInbox;

  @override
  State<AudioPlayerWidget> createState() => _AudioPlayerWidgetState();
}

class _AudioPlayerWidgetState extends State<AudioPlayerWidget> {
  AudioPlayer player = AudioPlayer();
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;

  bool isPlaying = false;

  @override
  void initState() {
    player = AudioPlayer();
    player.setReleaseMode(ReleaseMode.stop);

    player.onPlayerStateChanged.listen((event) {
      if (event == PlayerState.playing) {
        setState(() {
          isPlaying = true;
        });
      } else if (event == PlayerState.completed) {
        setState(() {
          isPlaying = false;
          _position = Duration.zero;
        });
      } else {
        setState(() {
          isPlaying = false;
        });
      }
    });

    player.onDurationChanged.listen((duration) {
      setState(() {
        _duration = duration;
      });
    });

    player.onPositionChanged.listen((position) {
      setState(() {
        _position = position;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    logWarning(widget.url);

    return Container(
      constraints:
          BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.68),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (!widget.isInbox)
                  Padding(
                    padding: EdgeInsets.fromLTRB(20.w,10.h,20.w,0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _formatDuration(_position),
                          style: AppTextStyles.regularStyle.copyWith(
                              color: OColors.darkGrey, fontSize: 9),
                        ),
                        Text(_formatDuration(_duration),
                          style: AppTextStyles.regularStyle.copyWith(
                              color: OColors.darkGrey, fontSize: 9),),
                      ],
                    ),
                  ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          isPlaying
                              ? player.pause()
                              : widget.url.startsWith('http')
                                  ? player.play(UrlSource(widget.url))
                                  : player.play(DeviceFileSource(widget.url));
                        });
                      },
                      icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow,
                          color: isPlaying
                              ? OColors.grey2
                              : OColors.primary),
                      iconSize: 30,
                      splashRadius: 20,
                    ),
                    Expanded(
                      child: Slider(
                        onChanged: (value) {
                          if (_duration == Duration.zero) return;
                          final newPosition = Duration(
                              milliseconds:
                                  (value * _duration.inMilliseconds).round());
                          player.seek(newPosition);
                        },
                        value: _calculateSliderValue(),
                        activeColor: widget.isMe!
                            ? Colors.grey.shade300
                            : OColors.primary,
                        thumbColor: OColors.white,
                        inactiveColor: widget.isMe! ? Colors.grey : Colors.grey,
                      ),
                    ),
                  ],
                ),
                if ((widget.isInbox ?? true))
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _formatDuration(_position),
                        style: TextStyle(
                            color: OColors.greyScale400, fontSize: 12),
                      ),
                      Text(widget.sendingTime ?? '',
                          style: OStyles.bodyMediumRegular
                              .copyWith(color: OColors.greyScale400)),
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  double _calculateSliderValue() {
    if (_duration.inMilliseconds == 0) {
      return 0.0;
    }
    final position = _position.inMilliseconds.toDouble();
    final duration = _duration.inMilliseconds.toDouble();
    return position / duration;
  }

  String _formatDuration(Duration? duration) {
    if (duration == null) {
      return "0:00";
    } else {
      String twoDigits(int n) => n.toString().padLeft(2, "0");
      String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
      String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
      return "$twoDigitMinutes:$twoDigitSeconds";
    }
  }
}
