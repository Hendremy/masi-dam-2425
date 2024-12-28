import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masi_dam_2425/home/bloc/plants_bloc.dart';
import 'package:masi_dam_2425/plant_id/plant_camera_bloc.dart';
import 'package:masi_dam_2425/plant_id/plant_registration_view.dart';

class PlantCameraView extends StatefulWidget {
  final PlantsBloc plantBloc;

  PlantCameraView({Key? key, required PlantsBloc this.plantBloc}) : super(key: key) {}

  @override
  _PlantCameraViewState createState() => _PlantCameraViewState();
}

class _PlantCameraViewState extends State<PlantCameraView> {
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
  Widget build(BuildContext mainContext) {
    return Scaffold(
      appBar: AppBar(title: const Text('Take a Picture')),
      body: BlocProvider(
        create: (context) => PlantPhoto(),
        child: BlocBuilder<PlantPhoto, PlantIdState>(
          builder: (context, state) {
            if (state is PlantCameraReadyState) {
              _controller = state.controller;
              return CameraPreview(state.controller);
            } else if (state is PlantCameraNotReadyState) {
              context.read<PlantPhoto>().add(LoadCameraEvent());
            } else if (state is PlantCameraErrorState) {
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
              mainContext,
              MaterialPageRoute(
                builder: (context) => PlantRegistrationScreen(imagePath: image.path, plantsBloc: widget.plantBloc),
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
