import 'package:bloc/bloc.dart';
import 'package:camera/camera.dart';

class PlantIdBloc extends Bloc<PlantIdEvent, PlantIdState> {
  PlantIdBloc() : super(PlantIdNotReadyState()){

    on<LoadCameraEvent>((event, emit) async {
      emit(PlantIdLoadingState());
      try{
        final cameras = await availableCameras();
        final camera = cameras.first;
        final controller = CameraController(
          camera,
          ResolutionPreset.veryHigh,
        );
        await controller.initialize();
        emit(PlantIdReadyState(controller));
      }catch(e){
        emit(PlantIdErrorState(e.toString()));
      }
    });
  }
}

abstract class PlantIdEvent {}

class LoadCameraEvent extends PlantIdEvent {

}

abstract class PlantIdState {}

class PlantIdNotReadyState extends PlantIdState {}

class PlantIdLoadingState extends PlantIdState {}

class PlantIdReadyState extends PlantIdState {
  final CameraController controller;

  PlantIdReadyState(this.controller);
}

class PlantIdErrorState extends PlantIdState {
  final String message;

  PlantIdErrorState(this.message);
}