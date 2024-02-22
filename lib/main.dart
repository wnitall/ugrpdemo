import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

//stless + tap 누르면 기본 세팅
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp( //MaterialApp은 구글 스타일(각종 기능, 디자인 지원) ios 스타일은 cupertino~~
      home : Scaffold(
        appBar: AppBar(
          title: Text("앱임"),
          backgroundColor: Colors.blue,
        ),
        body: Align(
          alignment: Alignment.bottomLeft,
          child: Container(
            width: 200, height: 100,
            margin: EdgeInsets.all(20),
            padding: EdgeInsets.all(20),
            child: Text("dedede"),
            decoration: BoxDecoration(
              color: Colors.blue,
              border: Border.all(color: Colors.black)
            ),
          ),
        )
      )
    );
  }
}
