import 'package:flutter/material.dart';

class Logout extends StatefulWidget {
    const Logout({super.key});

    @override
    State<Logout> createState() => LogoutState();
}

class LogoutState extends State<Logout> {
    @override
    Widget build(BuildContext context){
        return Scaffold(
            body: Text('You logged out'),
        );
    }
}