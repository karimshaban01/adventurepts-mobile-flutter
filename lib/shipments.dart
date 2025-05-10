import 'package:flutter/material.dart';

class Shipments extends StatefulWidget{
  const Shipments({super.key});

  @override
  State<Shipments> createState() => ShipmentsState();
}

class ShipmentsState extends State<Shipments> {
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Text('This is a shipments page'),
    );
  }
}