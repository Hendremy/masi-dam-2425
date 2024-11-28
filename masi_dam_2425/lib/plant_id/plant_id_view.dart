import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masi_dam_2425/plant_id/plant_id_bloc.dart';

class CameraApp extends StatefulWidget {
  late CameraDescription camera;

  CameraApp({Key? key}) : super(key: key) {}

  @override
  _CameraAppState createState() => _CameraAppState();
}

class _CameraAppState extends State<CameraApp> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();

    // Create a CameraController
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.medium,
    );

    // Initialize the controller
    _initializeControllerFuture = _controller.initialize();
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
              widget.camera = state.camera;
              return FutureBuilder<void>(
                future: _initializeControllerFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    // If the Future is complete, display the preview
                    return CameraPreview(_controller);
                  } else {
                    // Otherwise, display a loading indicator
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              );
            }else{
              context.read<PlantIdBloc>().add(LoadCameraEvent());
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.camera_alt),
        onPressed: () async {
          try {
            // Ensure that the camera is initialized
            await _initializeControllerFuture;

            // Attempt to take a picture
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

class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  const DisplayPictureScreen({Key? key, required this.imagePath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Picture Preview')),
      body: Center(
        child: Image.file(File(imagePath)),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.check),
        onPressed: () {
          // You can add logic here to save the image or do something with it
          Navigator.pop(context);
        },
      ),
    );
  }
}
