import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:promodoroapp/config/palette.dart';
import 'package:promodoroapp/screens/screens.dart';

class Pomodoro extends StatefulWidget {
  const Pomodoro({Key? key}) : super(key: key);

  @override
  _PomodoroState createState() => _PomodoroState();
}

class _PomodoroState extends State<Pomodoro> {
  static int nb = 1;
  static int studyTimer = durationProvider(nb);
  static int shortBreak = sb.duration;
  static int longBreak = lb.duration;
  static int nbCycles = c.nbc;
  bool _isButtonDisabled = false;
  bool _cancelled = false;
  double percent = 0.00;
  Color percentIndicator = Colors.black;
  static int pm = durationProvider(nb);
  int ips = pm * 60;
  late Timer timer;
  _startTimer() async {
    _isButtonDisabled = true;
    _cancelled = false;
    // ignore: avoid_print
    print("start btn clicked!");

    percent = 0.00;
    pm = durationProvider(nb);
    int ps = pm * 60;
    double secPercent = (ps / 100);

    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      print("$ps");
      print("$percent");

      setState(() {
        if (ps > 0 && percent < 0.999 && _cancelled == false) {
          ps--;
          if (ps % 60 == 0 && pm > 0) {
            //a minute has passed
            pm--;
          }
          if (pm <= 1) {
            percentIndicator = Colors.red;
          }
          if (ps % secPercent == 0) {
            if (percent < 0.99) {
              percent += 0.01;
            } else {
              percent = 1.00;
            }
          }
        } else {
          percent = 0.00;
          nb++;
          pm = durationProvider(nb);
          percentIndicator = Colors.black;
          _isButtonDisabled = false;
          timer.cancel();
        }
      }); // setState
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        scrollDirection: Axis.vertical,
        slivers: <Widget>[
          SliverAppBar(
            toolbarHeight: 100.0,
            // backgroundColor: Colors.red,
            backgroundColor: Palette.scaffold,
            title: const Text(
              "Pomodoro\nTimer",
              style: TextStyle(
                // color: Palette.facebookBlue,
                color: Colors.black,
                fontSize: 40.0,
                fontWeight: FontWeight.bold,
                letterSpacing: -1.2,
              ),
            ),
            centerTitle: false,
            floating: true,
            pinned: false,
            stretch: false,
            actions: [
              Container(
                margin: const EdgeInsets.fromLTRB(6.0, 6.0, 10.0, 6.0),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const SettingsScreen())),
                  icon: const Icon(Icons.settings),
                  iconSize: 40.0,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          // circular percent indicator
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 5.0),
            sliver: SliverToBoxAdapter(
              child: CircularPercentIndicator(
                //filled progress indicator is now rounded
                circularStrokeCap: CircularStrokeCap.round,
                //percent is the only input
                percent: 1 - percent,
                animation: true,
                animateFromLastPercent: true,
                radius: 250.0,
                lineWidth: 20.0,
                progressColor: percentIndicator,
                center: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "$pm",
                      style: TextStyle(
                        color: percentIndicator,
                        fontSize: 80.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    //red button

                    if (_isButtonDisabled)
                      Padding(
                        padding: const EdgeInsets.only(
                            bottom: 8.0, right: 8.0, left: 8.0),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          width: 80.0,
                          height: 30.0,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: InkWell(
                            onTap: () => {_cancelled = true},
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: const <Widget>[
                                Icon(
                                  Icons.cancel,
                                  size: 20.0,
                                  color: Colors.white,
                                ),
                                Text(
                                  "Cancel",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    // else
                    //   const Text(
                    //     "Focus and do your best",
                    //     style: TextStyle(fontSize: 15.0),
                    //   ),
                  ],
                ),
              ),
            ),
          ),

          //first container with start button
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 5.0),
            sliver: SliverToBoxAdapter(
              child: Container(
                margin: const EdgeInsets.all(15.0),
                padding: const EdgeInsets.all(8.0),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(30.0)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0.0, 2.0),
                      blurRadius: 15.0,
                    ),
                  ],
                ),
                child: Container(
                  margin:
                      const EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            children: const <Widget>[
                              Text(
                                "Study Time",
                                style: TextStyle(
                                  fontSize: 25.0,
                                ),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                "25",
                                style: TextStyle(
                                  fontSize: 70.0,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 20.0,
                          ),
                          Column(
                            children: const <Widget>[
                              Text(
                                "Pause Time",
                                style: TextStyle(
                                  fontSize: 25.0,
                                ),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                "5",
                                style: TextStyle(
                                  fontSize: 70.0,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      // START BUTTON
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: RaisedButton(
                          disabledColor: Colors.grey,
                          onPressed: _isButtonDisabled ? null : _startTimer,
                          color: percent == 0.00 ? Colors.blue : Colors.grey,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(20.0),
                            child: Text(
                              "Start Studying",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22.0,
                              ),
                            ),
                          ),
                        ),
                      ),

                      // last start button
                      // CupertinoButton(
                      //   padding: const EdgeInsets.symmetric(
                      //     vertical: 20.0,
                      //     horizontal: 30.0,
                      //   ),
                      //   borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      //   color: percent == 0.00 ? Colors.blue : Colors.grey,
                      //   disabledColor: Colors.grey,
                      //   pressedOpacity: 0.6,
                      //   child: const Text(
                      //     "Start Studying",
                      //     style: TextStyle(
                      //       color: Colors.white,
                      //       fontSize: 22.0,
                      //     ),
                      //   ),
                      //   onPressed: _isButtonDisabled ? null : _startTimer,
                      // ),

                      // NEWWWWWW START BUTTONNNNNNN
                      // Padding(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: Container(
                      //     // padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      //     width: 200.0,
                      //     height: 65.0,
                      //     decoration: BoxDecoration(
                      //       color: percent == 0.00 ? Colors.blue : Colors.grey,
                      //       borderRadius: BorderRadius.circular(20.0),
                      //     ),
                      //     child: InkWell(
                      //       onTap: () =>
                      //           {_isButtonDisabled ? null : _startTimer()},
                      //       child: Row(
                      //         mainAxisAlignment: MainAxisAlignment.center,
                      //         crossAxisAlignment: CrossAxisAlignment.center,
                      //         children: const <Widget>[
                      //           Text(
                      //             "Start Studying",
                      //             style: TextStyle(
                      //               color: Colors.white,
                      //               fontSize: 22.0,
                      //               fontWeight: FontWeight.w400,
                      //             ),
                      //           ),
                      //         ],
                      //       ),
                      //     ),
                      //   ),
                      // )
                    ],
                  ),
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 5.0),
            sliver: SliverToBoxAdapter(
              child: Container(
                margin: const EdgeInsets.all(15.0),
                padding: const EdgeInsets.all(8.0),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(30.0)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0.0, 2.0),
                      blurRadius: 15.0,
                    ),
                  ],
                ),
                child: Container(
                  padding: const EdgeInsets.all(20.0),
                  margin:
                      const EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Data settings",
                            style:
                                TextStyle(fontSize: 25.0, color: Colors.black),
                          ),
                          GestureDetector(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const SettingsScreen())),
                            child: Text(
                              "Edit",
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: 1.0),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        "Study duration: $pm minutes",
                        style: const TextStyle(
                            fontSize: 18.0, color: Colors.black54),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        "Short break duration: $shortBreak minutes",
                        style: const TextStyle(
                            fontSize: 18.0, color: Colors.black54),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        "Long break duration: $longBreak minutes",
                        style: const TextStyle(
                            fontSize: 18.0, color: Colors.black54),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        "Cycle numbers before long break: $nbCycles",
                        style: const TextStyle(
                            fontSize: 18.0, color: Colors.black54),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Study {
  int duration = 25;
  int nbs = 0;
  bool isActive = false;
  Study({
    required this.duration,
    required this.nbs,
    required this.isActive,
  });
}

class ShortBreak {
  int duration = 5;
  int nbsb = 0;
  bool isActive = false;
  ShortBreak({
    required this.duration,
    required this.nbsb,
    required this.isActive,
  });
}

class LongBreak {
  int duration = 15;
  int nblb = 0;
  bool isActive = false;
  LongBreak({
    required this.duration,
    required this.nblb,
    required this.isActive,
  });
}

class Cycle {
  int nbc = 4;
  int currentCycle = 0;
  Cycle({
    required this.nbc,
    required this.currentCycle,
  });
}

var s = Study(duration: 2, nbs: 0, isActive: false);
var sb = ShortBreak(duration: 1, nbsb: 0, isActive: false);
var lb = LongBreak(duration: 3, nblb: 0, isActive: false);
var c = Cycle(nbc: 3, currentCycle: 0);
durationProvider(int nb) {
  int duration = s.duration;
  if (nb == c.nbc * 2) {
    lb.nblb++;
    duration = lb.duration;
    sb.nbsb++;
    c.currentCycle++;
    nb = 0;
  } else {
    if (nb % 2 == 0) {
      duration = sb.duration;
      sb.nbsb++;
      c.currentCycle++;
    } else {
      duration = s.duration;
      s.nbs++;
    }
  }
  return duration;
}
