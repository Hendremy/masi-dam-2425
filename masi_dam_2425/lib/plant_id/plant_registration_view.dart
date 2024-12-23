
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:masi_dam_2425/theme.dart';

class PlantRegistrationScreen extends StatefulWidget {
  final String imagePath;

  const PlantRegistrationScreen({Key? key, required this.imagePath})
      : super(key: key);

  @override
  State<PlantRegistrationScreen> createState() => _DisplayPictureScreenState();
}

class _DisplayPictureScreenState extends State<PlantRegistrationScreen> {
  bool _isPlantNameValid = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('New plant')),
      resizeToAvoidBottomInset: false,
      body: SizedBox(
        child: Column(
          children: [
            Container(
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Plant name',
                ),
                onChanged: (text) => {
                  setState(() {
                    _isPlantNameValid = text.isNotEmpty;
                  })
                }
                ,
              ),
              padding: const EdgeInsets.all(10),
            ),
            Container(
              child: Image.file(File(widget.imagePath), height: 500,),
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.check),
        backgroundColor: _isPlantNameValid ? theme.primaryColor : Colors.grey,
        onPressed: () {
          // You can add logic here to save the image or do something with it
          if(_isPlantNameValid){
            Navigator.pop(context);
          };
        },
      ),
    );
  }
}
