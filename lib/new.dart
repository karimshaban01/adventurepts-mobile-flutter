import 'package:flutter/material.dart';

class NewItem extends StatefulWidget{
  const NewItem({super.key});

  @override
  State<NewItem> createState() => NewItemState();
}

class NewItemState extends State<NewItem>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('This is a new widget'),
    );
  }
  
}