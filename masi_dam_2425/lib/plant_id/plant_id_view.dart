import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masi_dam_2425/plant_id/plant_id_bloc.dart';
import 'package:masi_dam_2425/theme.dart';

class PlantIdView extends StatefulWidget {
  PlantIdView({Key? key}) : super(key: key) {}

  @override
  _PlantIdViewState createState() => _PlantIdViewState();
}

class _PlantIdViewState extends State<PlantIdView> {
  late CameraController _controller;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Take a Picture')),
      body: BlocProvider(
        create: (context) => PlantIdBloc(),
        child: BlocBuilder<PlantIdBloc, PlantIdState>(
          builder: (context, state) {
            if (state is PlantIdReadyState) {
              _controller = state.controller;
                return CameraPreview(state.controller);
            }else if(state is PlantIdNotReadyState){
              context.read<PlantIdBloc>().add(LoadCameraEvent());
            }else if(state is PlantIdErrorState){
              return Center(child: Text(state.message));
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.camera_alt),
        onPressed: () async {
          try {
            final image = await _controller.takePicture();

            // If picture is taken successfully, navigate to a preview screen
            if (!mounted) return;
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    DisplayPictureScreen(imagePath: image.path),
              ),
            );
          } catch (e) {
            print(e);
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class DisplayPictureScreen extends StatefulWidget {
  final String imagePath;

  const DisplayPictureScreen({Key? key, required this.imagePath})
      : super(key: key);

  @override
  State<DisplayPictureScreen> createState() => _DisplayPictureScreenState();
}

class _DisplayPictureScreenState extends State<DisplayPictureScreen> {
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
