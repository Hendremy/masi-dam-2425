import 'package:bloc/bloc.dart';
import 'package:camera/camera.dart';

class PlantPhoto extends Bloc<PlantCameraEvent, PlantIdState> {
  PlantPhoto() : super(PlantCameraNotReadyState()){

    on<LoadCameraEvent>((event, emit) async {
      emit(PlantCameraLoadingState());
      try{
        final cameras = await availableCameras();
        final camera = cameras.first;
        final controller = CameraController(
          camera,
          ResolutionPreset.veryHigh,
        );
        await controller.initialize();
        emit(PlantCameraReadyState(controller));
      }catch(e){
        emit(PlantCameraErrorState(e.toString()));
      }
    });
  }
}

abstract class PlantCameraEvent {}

class LoadCameraEvent extends PlantCameraEvent {

}

abstract class PlantIdState {}

class PlantCameraNotReadyState extends PlantIdState {}

class PlantCameraLoadingState extends PlantIdState {}

class PlantCameraReadyState extends PlantIdState {
  final CameraController controller;

  PlantCameraReadyState(this.controller);
}

class PlantCameraErrorState extends PlantIdState {
  final String message;

  PlantCameraErrorState(this.message);
}