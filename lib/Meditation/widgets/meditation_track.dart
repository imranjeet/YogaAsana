import 'dart:async';
import 'package:flutter/material.dart';
import 'package:audio/audio.dart';

import '../../util/constant.dart';

class MusicItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: <Widget>[
        TrackPlayer(
          url:
              "https://firebasestorage.googleapis.com/v0/b/hindi-stories-8860b.appspot.com/o/11%20(mp3cut.net)%20(1)%20(1).mp3?alt=media&token=f30e6617-c56a-49a9-b895-f84e9812a912",
        ),
        TrackPlayer(
          url:
              "https://firebasestorage.googleapis.com/v0/b/hindi-stories-8860b.appspot.com/o/1.mp3?alt=media&token=f9c6e598-3515-4bc7-b767-084319840bd8",
        ),
        TrackPlayer(
            url:
                "https://firebasestorage.googleapis.com/v0/b/hindi-stories-8860b.appspot.com/o/10%20(mp3cut.net)%20(1).mp3?alt=media&token=0588cb20-f8ee-40a3-9305-fc976363de02"),
        TrackPlayer(
          url:
              "https://firebasestorage.googleapis.com/v0/b/hindi-stories-8860b.appspot.com/o/9%20(mp3cut.net).mp3?alt=media&token=7d602ccd-d101-4d17-b16d-8f23c49c4d94",
        ),
        // TrackPlayer(
        //   url:
        //       "https://firebasestorage.googleapis.com/v0/b/hindi-stories-8860b.appspot.com/o/2.mp3?alt=media&token=b9db08f9-f2a3-4d5e-a110-65f432cdaada",
        // ),
        // TrackPlayer(
        //   url:
        //       "https://firebasestorage.googleapis.com/v0/b/hindi-stories-8860b.appspot.com/o/8%20(mp3cut.net).mp3?alt=media&token=0c68a77e-0d6d-4c23-b4f1-d38a368cf070",
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
          height: MediaQuery.of(context).size.height * .08,
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
