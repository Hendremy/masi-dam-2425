import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masi_dam_2425/api/api_services.dart';
import 'package:masi_dam_2425/plant_id/plant_registration_cubit.dart';
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
  String _plantName = '';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PlantRegistrationCubit(
          api: context.read<UserApiServices>().plantsApi),
      child: BlocBuilder<PlantRegistrationCubit, PlantRegistrationState>(
        builder: (context, state) {
          return BlocListener<PlantRegistrationCubit, PlantRegistrationState>(
            listener: (context, state) {
              if (state is PlantRegistrationSaved) {
                Navigator.pop(context);
                Navigator.pop(context);// Pop two times to remove saving screen & camera screen
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Plant saved"),
                  ),
                );
              } else if (state is PlantRegistrationError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                  ),
                );
              }
            },
            child: Scaffold(
              appBar: AppBar(title: Text('New plant')),
              resizeToAvoidBottomInset: false,
              body: Stack(
                children: [
                  SizedBox(
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
                                _plantName = text;
                              })
                            },
                          ),
                          padding: const EdgeInsets.all(10),
                        ),
                        Container(
                          child: Image.file(
                            File(widget.imagePath),
                            height: 500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (state is PlantRegistriationSaving)
                    Container(
                      color: Colors.black.withOpacity(0.5),
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                ],
              ),
              floatingActionButton: FloatingActionButton(
                child: const Icon(Icons.check),
                backgroundColor:
                    _isPlantNameValid ? theme.primaryColor : Colors.grey,
                onPressed: () {
                  if (_isPlantNameValid && state is PlantRegistrationInitial ||
                      state is PlantRegistrationError) {
                    context
                        .read<PlantRegistrationCubit>()
                        .savePlant(_plantName, File(widget.imagePath));
                  }
                  ;
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
