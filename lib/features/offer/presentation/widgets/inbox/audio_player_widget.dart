import 'package:audioplayers/audioplayers.dart';
import 'package:osta_user_app/utils/constants/exports.dart';
import 'package:osta_user_app/utils/constants/log_util.dart';

class AudioPlayerWidget extends StatefulWidget {
  const AudioPlayerWidget({super.key, required this.url});

  final String url;

  @override
  State<AudioPlayerWidget> createState() => _AudioPlayerWidgetState();
}

class _AudioPlayerWidgetState extends State<AudioPlayerWidget> {
  AudioPlayer player = AudioPlayer();
  Duration? _duration;
  Duration? _position;

  bool isPlaying = false;

  @override
  void initState() {
    /// Create the audio player.
    player = AudioPlayer();
    /// Set the release mode to keep the source after playback has completed.
    player.setReleaseMode(ReleaseMode.stop);

    // /// Start the player as soon as the app is displayed.
    // WidgetsBinding.instance.addPostFrameCallback((_) async {
    //   await player.setSource(UrlSource(widget.url));
    //   await player.resume();
    // });

    player.onPlayerStateChanged.listen((event) {
      if(event == PlayerState.playing) {
        setState(() {
          isPlaying = true;
        });
      }
      else if(event == PlayerState.completed) {
        setState(() {
          isPlaying = false;
          _position = Duration.zero;
        });
      }
    });

    player.onPositionChanged.listen((event) async {
      _position = await player.getCurrentPosition();
      setState(() {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(onPressed: () {
          setState(() {
            isPlaying ? player.pause() :
            player.play(UrlSource(widget.url));
          });
        }, icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow, color: OColors.whiteColor)),

        Slider(

          onChanged: (value) {
            final duration = _duration;
            if (duration == null) {
              return;
            }
            final position = value * duration.inMilliseconds;
            player.seek(Duration(milliseconds: position.round()));
          },
          value: _position?.inSeconds.toDouble() ?? 0,
        ),

      ],
    );
  }
}
