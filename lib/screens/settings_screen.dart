import 'package:cupertino_setting_control/cupertino_setting_control.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:promodoroapp/models/classes.dart';
import 'package:promodoroapp/screens/screens.dart';

import 'package:flutter/widgets.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() {
    return _SettingsScreenState();
  }
}

class _SettingsScreenState extends State<SettingsScreen> {
  static var mapDurations = {
    "5 Minutes": 5,
    "10 Minutes": 10,
    "15 Minutes": 15,
    "20 Minutes": 20,
    "25 Minutes": 25,
    "30 Minutes": 30,
    "35 Minutes": 35,
    "40 Minutes": 40,
    "45 Minutes": 45,
    "50 Minutes": 50,
    "55 Minutes": 55,
    "60 Minutes": 60,
  };
  var durations = mapDurations.entries.map((entry) {
    return Text(entry.key);
  }).toList();

  static Study s = Study(duration: 2, nbs: 0, isActive: false);
  static ShortBreak sb = ShortBreak(duration: 1, nbsb: 0, isActive: false);
  static LongBreak lb = LongBreak(duration: 3, nblb: 0, isActive: false);
  static Cycle c = Cycle(nbc: 3, currentCycle: 0);
  static String studyDuration = durationTextProvider(s);
  static String shortBreakDuration = durationTextProvider(sb);
  static String longBreakDuration = durationTextProvider(lb);
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        leading: CupertinoNavigationBarBackButton(
          onPressed: () => showCupertinoDialog(
            barrierDismissible: true,
            context: context,
            builder: (_) => CupertinoAlertDialog(
              title: const Text("Save changes?"),
              content: const Text("Do you want to save changes?"),
              actions: [
                CupertinoDialogAction(
                  child: const Text("Discard"),
                  onPressed: () => Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const Pomodoro())),
                ),
                CupertinoDialogAction(
                  child: const Text("Save"),
                  onPressed: () => Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const Pomodoro())),
                ),
              ],
            ),
          ),
          color: CupertinoColors.label,
        ),
        middle: const Text(
          "Settings",
          style: TextStyle(fontSize: 25.0),
        ),
        trailing: MaterialButton(
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const Pomodoro()),
          ),
          child: const Text(
            "Save",
            style: TextStyle(color: Colors.blue, fontSize: 19.0),
          ),
        ),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.all(15.0),
                padding: const EdgeInsets.all(15.0),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(25.0)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0.0, 2.0),
                      blurRadius: 15.0,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Material(
                          child: Text(
                            "Study duration",
                            style: TextStyle(fontSize: 22),
                          ),
                        ),
                        Material(
                          child: Text(
                            studyDuration,
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    SettingRow(
                      rowData: SettingsSliderConfig(
                        title: 'Study duration',
                        from: 5,
                        to: 60,
                        initialValue: 25,
                        justIntValues: true,
                        unit: ' minutes',
                      ),
                      onSettingDataRowChange: (double resultVal) {},
                      config: const SettingsRowConfiguration(
                          showAsTextField: false,
                          showTitleLeft: true,
                          showTopTitle: false,
                          showAsSingleSetting: false),
                    ),
                    ElevatedButton(
                      child: const Text("Set duration"),
                      onPressed: () {
                        showPicker();
                      },
                    ),
                    // Container(
                    //   margin: EdgeInsets.symmetric(vertical: 5.0),
                    //   width: double.infinity,
                    //   // height: MediaQuery.of(context).size.height * 0.50,
                    //   alignment: Alignment.center,
                    //   child: Column(
                    //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //     children: [

                    //     ],
                    //   ),
                    // ),
                  ],
                ),
              ),
              // Container(
              //   margin: const EdgeInsets.all(15.0),
              //   padding: const EdgeInsets.all(15.0),
              //   decoration: const BoxDecoration(
              //     color: Colors.white,
              //     borderRadius: BorderRadius.all(Radius.circular(25.0)),
              //     boxShadow: [
              //       BoxShadow(
              //         color: Colors.black26,
              //         offset: Offset(0.0, 2.0),
              //         blurRadius: 15.0,
              //       ),
              //     ],
              //   ),
              //   child: Column(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: [
              //       Row(
              //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //         children: [
              //           const Material(
              //             child: Text(
              //               "Study duration",
              //               style: TextStyle(fontSize: 22),
              //             ),
              //           ),
              //           Material(
              //             child: Text(
              //               studyDuration,
              //               style: TextStyle(fontSize: 18),
              //             ),
              //           ),
              //         ],
              //       ),
              //       const SizedBox(
              //         height: 20.0,
              //       ),
              //       ElevatedButton(
              //         child: const Text("Set duration"),
              //         onPressed: () {
              //           showPicker();
              //         },
              //       ),
              //       MergeSemantics(
              //         child: ListTile(
              //           title: const Text('Lights'),
              //           trailing: CupertinoSwitch(
              //             value: s.isActive,
              //             onChanged: (bool value) {
              //               setState(() {

              //               });
              //             },
              //           ),
              //           onTap: () {
              //             setState(() {

              //             });
              //           },
              //         ),
              //       )
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  void showPicker() {
    showCupertinoModalPopup(
        context: context,
        builder: (BuildContext builder) {
          return Container(
              height: MediaQuery.of(context).copyWith().size.height * 0.25,
              color: Colors.white,
              child: CupertinoPicker(
                children: durations,
                onSelectedItemChanged: (value) {
                  Text text = durations[value];
                  studyDuration = text.data.toString();
                  setState(() {});
                  s.duration = mapDurations[studyDuration] as int;
                },
                itemExtent: 25,
                diameterRatio: 1,
                useMagnifier: true,
                magnification: 1.3,
                looping: false,
              ));
        });
  }
}
