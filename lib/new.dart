import 'package:flutter/material.dart';

class NewItem extends StatefulWidget{
  const NewItem({super.key});

  @override
  State<NewItem> createState() => NewItemState();
}

class NewItemState extends State<NewItem>{
  // ignore: non_constant_identifier_names
  TextEditingController email_controller=TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
      body: Form(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'enter your email',
              ),
            ),
            Text(email_controller.text),
            ElevatedButton(
              onPressed: (){
                
              }, 
              child: Text('print')
              ),
              
          ],
        )
        ),
    );
  }
  
}