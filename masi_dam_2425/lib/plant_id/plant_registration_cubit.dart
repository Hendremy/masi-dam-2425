import 'package:flutter_bloc/flutter_bloc.dart';

class PlantRegistrationState{
  final bool isLoading;
  final String? errorMessage;

  PlantRegistrationState({
    this.isLoading = false,
    this.errorMessage,
  });

  PlantRegistrationState copyWith({
    bool? isLoading,
    String? errorMessage,
  }){
    return PlantRegistrationState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }
}

class PlantRegistrationCubit extends Cubit<PlantRegistrationState>{
  PlantRegistrationCubit(super.initialState);
}