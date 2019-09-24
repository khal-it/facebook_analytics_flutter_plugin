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
          child: FlatButton(
            color: Colors.blue,
            child: Text("Log Event"),
            onPressed: ()async{
              await FacebookAnalyticsPlugin.logEvent(name: "test_event", parameters: {"hello" : 13, "bool ": true, "double ": 123.32});
            },
          ),
        ),
      ),
    );
  }
}
