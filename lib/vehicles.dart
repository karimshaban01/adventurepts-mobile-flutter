import 'package:flutter/material.dart';

class Vehicles extends StatefulWidget{
  const Vehicles({super.key});

  @override
  State<Vehicles> createState() => VehiclesState();
}

class VehiclesState extends State<Vehicles> {
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Text('This is a vehicle page'),
    );
  }
}