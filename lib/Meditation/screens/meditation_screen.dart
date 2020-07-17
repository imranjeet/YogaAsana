import 'package:YogaAsana/Meditation/screens/meditaion_details_screen.dart';
import 'package:YogaAsana/widgets/header_widget.dart';
import 'package:YogaAsana/Meditation/widgets/meditation_track.dart';
import 'package:flutter/material.dart';

import '../../util/constant.dart';

class MeditationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Stack(
      children: <Widget>[
        Container(
          height: size.height * .50,
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
        SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: size.height * .02,
              ),
              Container(
                height: size.height * .35,
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(left: 20.0),
                                child: Text(
                                  "Meditation",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: size.height * 0.01,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 20.0),
                                child: Text(
                                  "3-10 Min Course",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(height: size.height * 0.01),
                              SizedBox(
                                width: size.width *
                                    .6, // it just take 60% of total width
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 20.0),
                                  child: Text(
                                    "Live happier and healthier by learning the fundamentals of meditation and mindfulness",
                                  ),
                                ),
                              ),
                            ]),
                        Container(
                          height: size.height * 0.15,
                          width: size.width * 0.3,
                          child: Image.asset("assets/images/1.png"),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: size.height * .02,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: MusicItem(),
                    ),
                  ],
                ),
              ),
              Container(
                height: size.height * .498,
                child: Scrollbar(
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: size.height * .02,
                        ),
                        Text(
                          "Meditation",
                          style: kHeadingTextStyle,
                        ),
                        MeditationItem(
                          title: "Mindfulness Meditation",
                          subtitle:
                              "Mindfulness is the basic human ability to be fully present,",
                          imgSrc: "assets/images/1.png",
                          details:
                              "aware of where we are and what we’re doing, and not overly reactive or overwhelmed by what’s going on around us.\n\nBrushing your teeth: Feel your feet on the floor, the brush in your hand, and your arm moving up and down.\n\nDriving: Turn off the radio—or put on something soothing, like classical music—imagine your spine growing tall, find the half-way point between relaxing your hands and gripping the wheel too tightly, and whenever you notice your mind wandering, bring your attention back to where you and your car are in space.\n\nDoing dishes: Savor the feeling of the warm water on your hands, the look of the bubbles, and the sounds of the pans clunking on the bottom of the sink.\n\nDoing laundry: Pay attention to the smell of the clean clothes and feel of the fabric. Add a focus element and count your breaths as you fold laundry.\n\nExercising: Instead of watching television while on the treadmill, try focusing on your breathing and where your feet are in space as you move.\n\nGetting kids ready for bed: Get down to the same level as your kids, look in their eyes, listen more than you talk, and savor any snuggles. When you relax, they will too.",
                        ),
                        MeditationItem(
                          title: "Spiritual Meditation",
                          subtitle:
                              "Spiritual meditation is an experience that takes you to the depths of who you are.",
                          imgSrc: "assets/images/9.png",
                          details:
                              "You, as your real self, stripped of all the perceptions you had about yourself until that point in your life. In the process, you experience joy and peace. A feeling of love and light warms up your being.\n Spiritual meditation makes you realize the eternal truth and let go of all that had happened and will happen. The present is where you want to be and find solace in. The need to practice spiritual meditation comes from an innate longing to see and think beyond the chaotic world surrounding you.\n\nThe Spiritual Meditation Technique\n1. Choose A Comfortable Position\n 2. Experience The Process\n3. Acknowledge The Thoughts\n4. Utter A Prayer\n5. Reflect On Yourself",
                        ),
                        MeditationItem(
                          title: "Focused Meditation",
                          subtitle:
                              "Focused meditation involves focusing on something intently as a way of staying in the present moment and slowing down the inner dialogue.",
                          imgSrc: "assets/images/8.png",
                          details:
                              "Unlike classic meditation — where you focus on nothing to quiet your mind — with focused meditation, you still remain in the present, but focus wholly on one thing, typically sensory stimulus like sounds, visual items, tactile sensations, tastes, smells, and even your own breathing — much like mindfulness meditation.\n\n\n Steps to Focused Meditation\n\n 1. Choose a target for your focus: Focusing on your breath is a good choice since it is usually the entry point to any meditation practice.\n\n 2. Get into a comfortable position: Sit upright. If you are sitting on a chair, sit right on the edge of it, relaxing into your pelvic bones with your feet on the floor. \n\n 3. Turn your attention to your chosen target: Zero in on the sensations including the sound, smell, sight, and details of your focal point.\n\n 4. Calm your inner voice: If your internal monologue starts to analyze your target or begins to rehash stressful situations of the day, worry about the future, make a list for grocery shopping, or anything else, gently turn your attention back to your chosen target and the sensation it provides. You may be focusing on something, but the goal is to maintain a quiet mind. \n\n 5. Don't worry about failure.",
                        ),
                        MeditationItem(
                          title: "Movement Meditation",
                          subtitle:
                              "Movement meditation (just as seated meditation) boils down to presence.",
                          imgSrc: "assets/images/7.png",
                          details:
                              "The key is to hone into the moment with awareness, which you can practice anywhere and anytime. Here are some tips on how you can get started: \n\n1. Use the breath to guide the movement: If you’re practicing yoga – allow the inhale to take you into the pose, and on the exhale, let your body settle deeper. If you keep the breath slow and steady, the mind will follow. \n\n 2. Use the movement to bring your mind into the present.\n\n 3. Choose activities that you know: You can meditate in any activity, but there needs to be some level of competence. (The mind may have a tough time quieting when you’re trying to stand up on a surf board for the first time.) Stick with your tried and true movement practices so your mind can relax into the flow.",
                        ),
                        // MeditationItem(
                        //   title: "Basic 4",
                        //   subtitle: "Start your deepen you practice",
                        //   imgSrc: "asstes/images/7.png",
                        //   details:
                        //       "Live happier and healthier by learning the fundamentals of meditation and mindfulness",
                        // ),
                        // MeditationItem(
                        //   title: "Basic 4",
                        //   subtitle: "Start your deepen you practice",
                        //   imgSrc: "asstes/images/7.png",
                        //   details:
                        //       "Live happier and healthier by learning the fundamentals of meditation and mindfulness",
                        // ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class MeditationItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imgSrc;
  final String details;

  const MeditationItem({
    Key key,
    this.title,
    this.subtitle,
    this.imgSrc,
    this.details,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MeditationDetailScreen(
                    title: title,
                    subtitle: subtitle,
                    imgSrc: imgSrc,
                    details: details,
                  ))),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        padding: EdgeInsets.all(10),
        // height: size.height * .10,
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
        child: Row(
          children: <Widget>[
            Container(
              // height: size.height * .10,
              width: 50,
              child: Image.asset(
                imgSrc,
                // height: 100,
                // width: 100,
              ),
            ),
            SizedBox(width: 20),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    title,
                    style: kTitleTextstyle,
                  ),
                  Text(
                    subtitle,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            // Padding(
            //   padding: EdgeInsets.all(10),
            //   child: Image.asset(
            //     "assets/gif/1.gif",
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
