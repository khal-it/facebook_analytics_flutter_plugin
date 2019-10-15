import 'package:flutter/material.dart';
import 'package:facebook_analytics_plugin/facebook_analytics_plugin.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              loggerButton(
                buttonText: "log custom event",
                onButtonPressed: _onCustomEventButtonPressed
              ),
              loggerButton(buttonText: "log achieved level", onButtonPressed: _onAchievedLevelButtonPressed,)

            ],
          ),
        ),
      ),
    );
  }

  void _onAchievedLevelButtonPressed()async{
              await FacebookAnalyticsPlugin.logAchievedLevel(level: "level bla");
            }

  Widget loggerButton({@required String buttonText , @required Function onButtonPressed}) {
    return FlatButton(
      color: Colors.blue,
      child: Text(buttonText),
      onPressed: onButtonPressed,
    );
  }

  void _onCustomEventButtonPressed() async{
      await FacebookAnalyticsPlugin.logCustomEvent(
          name: "test_event",
          parameters: {"button pressed": "like button"});

  }
}
