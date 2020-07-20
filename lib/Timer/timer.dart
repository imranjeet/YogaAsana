import 'package:YogaAsana/Class/screens/player/video_item.dart';
import 'package:YogaAsana/Meditation/widgets/music_items.dart';
import 'package:YogaAsana/models/yoga_post.dart';
import 'package:YogaAsana/util/constant.dart';
import 'package:YogaAsana/util/pose_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

import 'Bloc/timer_bloc.dart';
import 'ticker.dart';

class PracticeTimer extends StatelessWidget {
  final String imgSrc;
  final YogaPost yogaPost;

  const PracticeTimer({Key key, this.imgSrc, this.yogaPost}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TimerBloc(ticker: Ticker()),
      child: Timer(
        imgSrc: imgSrc,
        yogaPost: yogaPost,
      ),
    );
  }
}

class Timer extends StatelessWidget {
  final String imgSrc;
  final YogaPost yogaPost;

  static const TextStyle timerTextStyle = TextStyle(
    fontSize: 60,
    fontWeight: FontWeight.bold,
  );

  const Timer({Key key, this.imgSrc, this.yogaPost}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      // appBar: AppBar(title: Text('Flutter Timer')),
      body: Stack(
        children: [
          Container(
            height: size.height * .45,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Colors.redAccent,
                    Colors.yellowAccent,
                  ]),
              image: DecorationImage(
                alignment: Alignment.centerLeft,
                image: AssetImage("assets/images/undraw_pilates_gpdb.png"),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 40),
            child: InkWell(
              child: Icon(Icons.arrow_back_ios),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ),
          SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: size.height * .03,
                ),
                Text(
                  yogaPost.title,
                  style: kTopHeadingTextStyle,
                ),
                SizedBox(
                  height: size.height * .02,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Container(
                    alignment: Alignment.topCenter,
                    height: size.height * .43,
                    width: size.width * 1,
                    child: VideoItem(
                      videoPlayerController:
                          VideoPlayerController.network(yogaPost.gifUrl),
                      looping: true,
                    ),

                    // Image.network(imgSrc),
                  ),
                ),
                Container(
                  height: size.height * .15,
                  child: Center(
                    child: BlocBuilder<TimerBloc, TimerState>(
                      builder: (context, state) {
                        final String minutesStr = ((state.duration / 60) % 60)
                            .floor()
                            .toString()
                            .padLeft(2, '0');
                        final String secondsStr = (state.duration % 60)
                            .floor()
                            .toString()
                            .padLeft(2, '0');
                        return Text(
                          '$minutesStr:$secondsStr',
                          style: Timer.timerTextStyle,
                        );
                      },
                    ),
                  ),
                ),
                BlocBuilder<TimerBloc, TimerState>(
                  buildWhen: (previousState, state) =>
                      state.runtimeType != previousState.runtimeType,
                  builder: (context, state) => Actions(),
                ),
                SizedBox(
                  height: size.height * .03,
                ),
                Background(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Actions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: _mapStateToActionButtons(
        timerBloc: BlocProvider.of<TimerBloc>(context),
      ),
    );
  }

  List<Widget> _mapStateToActionButtons({
    TimerBloc timerBloc,
  }) {
    final TimerState currentState = timerBloc.state;
    if (currentState is TimerInitial) {
      return [
        FloatingActionButton(
          child: Icon(Icons.play_arrow),
          onPressed: () =>
              timerBloc.add(TimerStarted(duration: currentState.duration)),
        ),
      ];
    }
    if (currentState is TimerRunInProgress) {
      return [
        FloatingActionButton(
          child: Icon(Icons.pause),
          onPressed: () => timerBloc.add(TimerPaused()),
        ),
        FloatingActionButton(
          child: Icon(Icons.replay),
          onPressed: () => timerBloc.add(TimerReset()),
        ),
      ];
    }
    if (currentState is TimerRunPause) {
      return [
        FloatingActionButton(
          child: Icon(Icons.play_arrow),
          onPressed: () => timerBloc.add(TimerResumed()),
        ),
        FloatingActionButton(
          child: Icon(Icons.replay),
          onPressed: () => timerBloc.add(TimerReset()),
        ),
      ];
    }
    if (currentState is TimerRunComplete) {
      return [
        FloatingActionButton(
          child: Icon(Icons.replay),
          onPressed: () => timerBloc.add(TimerReset()),
        ),
      ];
    }
    return [];
  }
}

class Background extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WaveWidget(
      config: CustomConfig(
        gradients: [
          [
            Color.fromRGBO(72, 74, 126, 1),
            Color.fromRGBO(125, 170, 206, 1),
            Color.fromRGBO(184, 189, 245, 0.7)
          ],
          [
            Color.fromRGBO(72, 74, 126, 1),
            Color.fromRGBO(125, 170, 206, 1),
            Color.fromRGBO(172, 182, 219, 0.7)
          ],
          [
            Color.fromRGBO(72, 73, 126, 1),
            Color.fromRGBO(125, 170, 206, 1),
            Color.fromRGBO(190, 238, 246, 0.7)
          ],
        ],
        durations: [19440, 10800, 6000],
        heightPercentages: [0.03, 0.01, 0.02],
        gradientBegin: Alignment.bottomCenter,
        gradientEnd: Alignment.topCenter,
      ),
      size: Size(double.infinity, MediaQuery.of(context).size.height * .15),
      waveAmplitude: 25,
      backgroundColor: Colors.blue[50],
    );
  }
}
