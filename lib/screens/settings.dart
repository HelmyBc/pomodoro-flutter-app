import 'package:cupertino_setting_control/cupertino_setting_control.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:promodoroapp/models/classes.dart';
import 'package:promodoroapp/screens/pomodoro_screen.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool _titleOnTop = false;

  @override
  Widget build(BuildContext context) {
    bool _titleOnTop = false;
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        // backgroundColor: Colors.transparent,
        middle: const Text(
          "Settings",
          style: TextStyle(fontSize: 25.0),
        ),
        trailing: GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const Pomodoro()),
          ),
          child: const Text(
            "Save",
            style: TextStyle(color: Colors.blue),
          ),
        ),
      ),
      child: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(vertical: 30.0),
          children: <Widget>[
            // const Padding(
            //     padding: EdgeInsets.fromLTRB(25.0, 5.0, 25.0, 5.0),
            //     child: Text('Legal',
            //         style: TextStyle(
            //           color: CupertinoColors.systemBlue,
            //           fontWeight: FontWeight.bold,
            //           fontSize: 15.0,
            //         ))),
            // SettingRow(
            //   rowData: SettingsSliderFromToConfig(
            //     title: 'Weight',
            //     from: 40,
            //     to: 120,
            //     initialFrom: 50,
            //     initialTo: 80,
            //     justIntValues: true,
            //     unit: 'kg',
            //   ),
            //   onSettingDataRowChange: (List<double> resultVals) {},
            //   config: const SettingsRowConfiguration(
            //       showAsTextField: false,
            //       showTitleLeft: true,
            //       showTopTitle: false,
            //       showAsSingleSetting: false),
            // ),

            SettingRow(
              rowData:
                  SettingsYesNoConfig(initialValue: true, title: 'Dark Mode'),
              onSettingDataRowChange: (result) {},
            ),
            SettingRow(
                config: SettingsRowConfiguration(
                    showTitleLeft: !_titleOnTop, showTopTitle: _titleOnTop),
                rowData: SettingsURLConfig(
                    title: 'Privacy', url: 'https://yourprivacystuff.de')),
            SizedBox(height: _titleOnTop ? 10.0 : 0.0),
            SettingRow(
                config: SettingsRowConfiguration(
                    showTitleLeft: !_titleOnTop, showTopTitle: _titleOnTop),
                rowData: SettingsButtonConfig(
                    title: 'Licenses',
                    tick: true,
                    functionToCall: () => showLicensePage(
                        context: context,
                        applicationName: 'example',
                        applicationVersion: 'v1.1',
                        useRootNavigator: true))),
            SizedBox(height: 20.0),
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
            SettingRow(
              rowData: SettingsSliderConfig(
                title: 'Short break duration',
                from: 2,
                to: 20,
                initialValue: 5,
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
            SettingRow(
              rowData: SettingsSliderConfig(
                title: 'Long break duration',
                from: 5,
                to: 60,
                initialValue: 15,
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
            SettingRow(
                config: SettingsRowConfiguration(
                    showTitleLeft: !_titleOnTop, showTopTitle: _titleOnTop),
                rowData: SettingsButtonConfig(
                    title: 'Cycles number before long break',
                    tick: true,
                    functionToCall: () => showPicker())),

            // SettingRow(
            //     rowData: SettingsTextFieldConfig(
            //       title: 'Name',
            //       initialValue: 'Helmy',
            //     ),
            //     config: SettingsRowConfiguration(),
            //     style: SettingsRowStyle(),
            //     onSettingDataRowChange: (resultVal) {}),
            // SettingRow(
            //     rowData: SettingsURLConfig(
            //         title: 'Privacy',
            //         url: 'https://yourprivacystuff.notexistant')),

            // SettingRow(
            //     config: SettingsRowConfiguration(
            //         showTitleLeft: !_titleOnTop, showTopTitle: _titleOnTop),
            //     rowData: SettingsURLConfig(
            //         title: 'Privacy', url: 'https://yourprivacystuff.de')),
            // SizedBox(height: _titleOnTop ? 10.0 : 0.0),
            // SettingRow(
            //     config: SettingsRowConfiguration(
            //         showTitleLeft: !_titleOnTop, showTopTitle: _titleOnTop),
            //     rowData: SettingsButtonConfig(
            //         title: 'Licenses',
            //         tick: true,
            //         functionToCall: () => showLicensePage(
            //             context: context,
            //             applicationName: 'example',
            //             applicationVersion: 'v1.1',
            //             useRootNavigator: true))),
          ],
        ),
      ),
    );
  }

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
