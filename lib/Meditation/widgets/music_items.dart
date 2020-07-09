import 'dart:io';
import 'dart:typed_data';

import 'package:YogaAsana/widgets/ProgressWidget.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';

import '../../constant.dart';

class AudioItem extends StatefulWidget {
  @override
  _AudioItemState createState() => _AudioItemState();
}

class _AudioItemState extends State<AudioItem> {
  AudioPlayerState state = AudioPlayerState.STOPPED;
  static String url = 'http://yoga.infous.xyz/public/1.mp3';
  AudioPlayer audioPlayer = new AudioPlayer();
  AudioProvider audioProvider = new AudioProvider(url);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Audio Players"),
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            state == AudioPlayerState.STOPPED
                ? Container(
                    height: 42,
                    width: 43,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(color: kPrimaryColor),
                    ),
                    child: InkWell(
                        onTap: play, child: Icon(Icons.play_arrow, size: 28.0)))
                : Container(
                    height: 42.0,
                    width: 43.0,
                    decoration: BoxDecoration(
                      color: Colors.red[800],
                      shape: BoxShape.circle,
                      border: Border.all(color: kPrimaryColor),
                    ),
                    child: InkWell(
                        onTap: pause,
                        child:
                            Icon(Icons.pause, color: Colors.white, size: 28.0)))
          ],
        ),
      ),
    );
  }

  play() async {
    String localUrl = await audioProvider.load();
    audioPlayer.play(localUrl, isLocal: true);
    
    setState(() {
      state = AudioPlayerState.PLAYING;
    });
  }

  pause() async {
    audioPlayer.pause();
    setState(() {
      state = AudioPlayerState.STOPPED;
    });
  }
}

typedef void OnError(Exception exception);

class AudioProvider {
  String url;

  AudioProvider(String url) {
    this.url = url;
  }

  Future<Uint8List> _loadFileBytes(String url, {OnError onError}) async {
    Uint8List bytes;
    try {
      bytes = await readBytes(url);
    } on ClientException {
      rethrow;
    }
    return bytes;
  }

  Future<String> load() async {
    final bytes = await _loadFileBytes(url,
        onError: (Exception exception) =>
            print('audio_provider.load => exception ${exception}'));

    final dir = await getApplicationDocumentsDirectory();
    final file = new File('${dir.path}/audio.mp3');

    await file.writeAsBytes(bytes);
    if (await file.exists()) {
      return file.path;
    }
    return circularProgress();
  }
}
