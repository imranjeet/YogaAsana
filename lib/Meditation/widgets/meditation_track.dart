import 'dart:async';
import 'package:flutter/material.dart';
import 'package:audio/audio.dart';

import '../../constant.dart';

class MusicItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: <Widget>[
        TrackPlayer(
          url: "https://firebasestorage.googleapis.com/v0/b/concise-decker-268806.appspot.com/o/1.mp3?alt=media&token=6ab57b31-bb76-4161-9391-e4948ab5f66d",
        ),
        TrackPlayer(
          url:
              "https://firebasestorage.googleapis.com/v0/b/concise-decker-268806.appspot.com/o/11.mp3?alt=media&token=e7d46a52-4851-40ec-ad99-56a0897cc7fe",
        ),
        TrackPlayer(
            url:
                "https://firebasestorage.googleapis.com/v0/b/concise-decker-268806.appspot.com/o/9.mp3?alt=media&token=5716cd97-8917-4004-9b8f-5de6ec7cc2f9"),
        TrackPlayer(
            url:
                "https://firebasestorage.googleapis.com/v0/b/concise-decker-268806.appspot.com/o/10.mp3?alt=media&token=4d8fa43f-4a96-4bd5-ace5-cf2e363ff7bd"),
        
        TrackPlayer(
          url:
              "https://firebasestorage.googleapis.com/v0/b/concise-decker-268806.appspot.com/o/8.mp3?alt=media&token=1b7d88c1-f326-45fc-8e3a-5e836aac142a",
        ),
        
        TrackPlayer(
          url: "https://firebasestorage.googleapis.com/v0/b/concise-decker-268806.appspot.com/o/2.mp3?alt=media&token=a8e6e154-15a8-42ab-b8ed-0ce4acaa2ad7",
        ),
        TrackPlayer(
          url: "https://firebasestorage.googleapis.com/v0/b/concise-decker-268806.appspot.com/o/3.mp3?alt=media&token=014116f8-122a-4bd9-891c-2ee045646b80",
        ),
        TrackPlayer(
          url: "https://firebasestorage.googleapis.com/v0/b/concise-decker-268806.appspot.com/o/7.mp3?alt=media&token=0e45cfec-8dfa-4552-875f-0425365c3ade",
        ),
        // TrackPlayer(
        //   url: "https://firebasestorage.googleapis.com/v0/b/yogaasana-d3ff6.appspot.com/o/7.mp3?alt=media&token=cbd38fea-ceb3-4312-99e5-56c8b5e98add",
        // ),
        // TrackPlayer(
        //   url: "https://firebasestorage.googleapis.com/v0/b/yogaasana-d3ff6.appspot.com/o/1.mp3?alt=media&token=9db2afd8-3c55-4f68-8456-af085886077e",
        // ),
      ],
    );
  }
}

// class AudioApp extends StatefulWidget {
//   @override
//   _AudioAppState createState() => _AudioAppState();
// }

// class _AudioAppState extends State<AudioApp> {
//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text("Audio"),
//         ),
//         body: ListView(
//           children: <Widget>[
//             //AudioPlayerDemo("https://firebasestorage.googleapis.com/v0/b/openso"), // Test the error handling
//             // TrackPlayer(
//             //     "https://firebasestorage.googleapis.com/v0/b/opensource-11ed5.appspot.com/o/flutter_audio_plugin%2FSampleAudio_0.4mb.mp3?alt=media&token=a6334d66-dc48-4562-b126-ed7004b18e5c"),
//             // TrackPlayer(
//             //     "https://firebasestorage.googleapis.com/v0/b/opensource-11ed5.appspot.com/o/flutter_audio_plugin%2F456235__greek555__loop-mix-128-bpm.mp3?alt=media&token=3d4f4357-a143-46bd-89c1-0b3fbaa9a9e9"),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class AudioRecorder extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() => AudioRecorderState();
// }

// class AudioRecorderState extends State<AudioRecorder> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(vertical: 32.0, horizontal: 16.0),
//       child: Column(
//         children: <Widget>[Text("Audio Recorder")],
//       ),
//     );
//   }
// }

// @immutable
class TrackPlayer extends StatefulWidget {
  final String url;

  TrackPlayer({this.url});

  @override
  State<StatefulWidget> createState() => TrackPlayerState();
}

class TrackPlayerState extends State<TrackPlayer> {
  Audio audioPlayer = new Audio(single: true);
  AudioPlayerState state = AudioPlayerState.STOPPED;
  double position = 0;
  int buffering = 0;
  StreamSubscription<AudioPlayerState> _playerStateSubscription;
  StreamSubscription<double> _playerPositionController;
  StreamSubscription<int> _playerBufferingSubscription;
  StreamSubscription<AudioPlayerError> _playerErrorSubscription;

  @override
  void initState() {
    _playerStateSubscription =
        audioPlayer.onPlayerStateChanged.listen((AudioPlayerState state) {
      print("onPlayerStateChanged: ${audioPlayer.uid} $state");

      if (mounted) setState(() => this.state = state);
    });

    _playerPositionController =
        audioPlayer.onPlayerPositionChanged.listen((double position) {
      print(
          "onPlayerPositionChanged: ${audioPlayer.uid} $position ${audioPlayer.duration}");

      if (mounted) setState(() => this.position = position);
    });

    _playerBufferingSubscription =
        audioPlayer.onPlayerBufferingChanged.listen((int percent) {
      print("onPlayerBufferingChanged: ${audioPlayer.uid} $percent");

      if (mounted && buffering != percent) setState(() => buffering = percent);
    });

    _playerErrorSubscription =
        audioPlayer.onPlayerError.listen((AudioPlayerError error) {
      throw ("onPlayerError: ${error.code} ${error.message}");
    });

    audioPlayer.preload(widget.url);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget status = Container();

    print(
        "[build] uid=${audioPlayer.uid} duration=${audioPlayer.duration} state=$state");

    switch (state) {
      case AudioPlayerState.LOADING:
        {
          status = Container(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                width: 24.0,
                height: 24.0,
                child: Center(
                    child: Stack(
                  alignment: AlignmentDirectional.center,
                  children: <Widget>[
                    CircularProgressIndicator(strokeWidth: 2.0),
                    Text("$buffering%",
                        style: TextStyle(fontSize: 8.0),
                        textAlign: TextAlign.center)
                  ],
                )),
              ));
          break;
        }

      case AudioPlayerState.PLAYING:
        {
          status = status = Container(
              height: 42.0,
              width: 43.0,
              decoration: BoxDecoration(
                color: Colors.red[800],
                shape: BoxShape.circle,
                border: Border.all(color: kPrimaryColor),
              ),
              child: InkWell(
                  onTap: () => onPause(),
                  child: Icon(Icons.pause, color: Colors.white, size: 28.0)));
          break;
        }

      case AudioPlayerState.READY:
      case AudioPlayerState.PAUSED:
      case AudioPlayerState.STOPPED:
        {
          status = Container(
              height: 42,
              width: 43,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(color: kPrimaryColor),
              ),
              child: InkWell(
                  onTap: () => onPlay(),
                  child: Icon(Icons.play_arrow, size: 28.0)));

          if (state == AudioPlayerState.STOPPED) audioPlayer.seek(0.0);

          break;
        }
    }

    return LayoutBuilder(builder: (context, constraint) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(13),
        child: Container(
          width: constraint.maxWidth / 2 - 5,
          // constraint.maxWidth provide us the available with for this widget
          // padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(13),
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 17),
                blurRadius: 23,
                spreadRadius: -13,
                color: kShadowColor,
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: Row(
                children: <Widget>[
                  status,
                  Container(
                    width: MediaQuery.of(context).size.width * .28,
                    child: Slider(
                      max: audioPlayer.duration.toDouble(),
                      value: position.toDouble(),
                      activeColor: Colors.amber[200],
                      onChanged: onSeek,
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.only(left: 15.0),
                  //   child: Image.asset(
                  //     "assets/icons/5.png",
                  //     height: 50,
                  //   ),
                  // ),
                  // Text("${audioPlayer.duration.toDouble()} ms")
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  @override
  void dispose() {
    _playerStateSubscription.cancel();
    _playerPositionController.cancel();
    _playerBufferingSubscription.cancel();
    _playerErrorSubscription.cancel();
    audioPlayer.release();
    super.dispose();
  }

  onPlay() {
    audioPlayer.play(widget.url);
  }

  onPause() {
    audioPlayer.pause();
  }

  onSeek(double value) {
    // Note: We can only seek if the audio is ready
    audioPlayer.seek(value);
  }
}
