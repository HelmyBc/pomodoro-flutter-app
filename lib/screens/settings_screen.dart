import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:promodoroapp/screens/screens.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          iconSize: 30.0,
          color: Colors.black,
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
        ),
        title: const Text(
          "Settings",
          style: TextStyle(fontSize: 30.0),
        ),
        actions: [
          MaterialButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const Pomodoro()),
            ),
            child: const Text(
              "Save",
              style: TextStyle(color: Colors.blue, fontSize: 20.0),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(
              height: 20.0,
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Study Duration',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 25.0,
                ),
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 10.0),
              padding: const EdgeInsets.all(8.0),
              //decoration: BoxDecoration(
              //   color: Colors.grey,
              //   borderRadius: BorderRadius.circular(20.0),
              // ),
              color: Colors.white,
              child: const TextField(
                keyboardType: TextInputType.numberWithOptions(),
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(top: 10.0),
                    // hintText: "Study duration in minutes",
                    // hintStyle: TextStyle(fontSize: 20.0),
                    labelText: "study duration in minutes",
                    // border: InputBorder.none,
                    prefixIcon: Icon(
                      Icons.timer_rounded,
                      color: Colors.black,
                    )),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Short Break Duration',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 25.0,
                ),
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 10.0),
              padding: const EdgeInsets.all(8.0),
              //decoration: BoxDecoration(
              //   color: Colors.grey,
              //   borderRadius: BorderRadius.circular(20.0),
              // ),
              color: Colors.white,
              child: const TextField(
                keyboardType: TextInputType.numberWithOptions(),
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(top: 10.0),
                    // hintText: "Study duration in minutes",
                    // hintStyle: TextStyle(fontSize: 20.0),
                    labelText: "Short break duration in minutes",
                    // border: InputBorder.none,
                    prefixIcon: Icon(
                      Icons.coffee_rounded,
                      color: Colors.black,
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
