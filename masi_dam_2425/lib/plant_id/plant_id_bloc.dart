import 'package:bloc/bloc.dart';
import 'package:camera/camera.dart';

class PlantIdBloc extends Bloc<PlantIdEvent, PlantIdState> {
  PlantIdBloc() : super(PlantIdNotReadyState()){

    on<LoadCameraEvent>((event, emit) async {
      emit(PlantIdLoadingState());
      final cameras = await availableCameras();
      emit(PlantIdReadyState(cameras.first));
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
  final CameraDescription camera;

  PlantIdReadyState(this.camera);
}