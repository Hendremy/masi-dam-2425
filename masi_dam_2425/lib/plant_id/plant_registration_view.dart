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

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PlantRegistrationCubit(
        api: context.read<UserApiServices>().plantsApi),
      child: BlocBuilder<PlantRegistrationCubit, PlantRegistrationState>(
        builder: (context, state) {
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
            floatingActionButton: FloatingActionButton(
              child: const Icon(Icons.check),
              backgroundColor:
                  _isPlantNameValid ? theme.primaryColor : Colors.grey,
              onPressed: () {
                if (_isPlantNameValid && state is PlantRegistrationInitial) {
                  context.read<PlantRegistrationCubit>().savePlant(
                      'plant', File(widget.imagePath));
                }
                ;
              },
            ),
          );
        },
      ),
    );
  }
}
