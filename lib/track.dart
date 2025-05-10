import 'package:flutter/material.dart';

class Track extends StatefulWidget{
  const Track({super.key});

  @override
  State<Track> createState() => TrackState();
}

class TrackState extends State<Track> {
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Text('This is a Tracking page'),
    );
  }
}