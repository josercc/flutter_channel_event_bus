import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_channel_event_bus/flutter_channel_event_bus.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with FlutterChannelEventBusMixin {
  @override
  void initState() {
    super.initState();
    register("setValue", (response) async {
      print("111111111111");
      print(response.mapData);
    });
    register("getVale", (response) async {
      print("3333333");
      print(response.mapData);
    });
  }

  @override
  void dispose() {
    super.dispose();
    freeRegisters();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: MaterialButton(
            onPressed: () async {
              var value = await send("getValue", '{"data":"data"}');
              print(value.toString());
            },
            child: Text("Button"),
          ),
        ),
      ),
    );
  }
}
