import 'package:flutter/material.dart';

class Support extends StatefulWidget{
  const Support({super.key});

  @override
  State<Support> createState() => SupportState();
}

class SupportState extends State<Support> {
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Text('This is a Support page'),
    );
  }
}