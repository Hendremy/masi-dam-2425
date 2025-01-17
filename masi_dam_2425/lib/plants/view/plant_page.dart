import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masi_dam_2425/api/api_services.dart';
import 'package:masi_dam_2425/model/plant.dart';
import 'package:masi_dam_2425/plants/plant_cubit.dart';
import 'package:masi_dam_2425/plants/widgets/hp_bar.dart';
import 'package:masi_dam_2425/plants/widgets/xp_bar.dart';

class PlantDetailPage extends StatelessWidget {
  final Plant plant;

  PlantDetailPage({Key? key, required this.plant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Image plantImg = Image.network(plant.imgUrl);
    Image mood = Image.asset(plant.moodImgPath, width: 100, height: 100);
    return Scaffold(
      appBar: AppBar(
        title: Text(plant.name),
      ),
      body: BlocProvider(
        create: (context) =>
            PlantCubit(plant, context.read<UserApiServices>().plantsApi),
        child: BlocConsumer<PlantCubit, PlantState>(
          listener: (context, state) {
            if (state is PlantGainedXP) {
              String message;
              if (state.xp_gain > 0){
                message = '${plant.name} gained ${state.xp_gain} XP';
              }else{
                message = '${plant.name} is not thirsty anymore';
              }
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(message),
              ));
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [
                    Stack(children: [
                      AspectRatio(
                        aspectRatio: 3 / 4,
                        child: Container(
                            decoration: BoxDecoration(
                          color: Colors.green,
                          image: DecorationImage(
                              image: plantImg.image, fit: BoxFit.fill),
                          // borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              spreadRadius: 1,
                              blurRadius: 1,
                              offset: const Offset(0, 1.5),
                            ),
                          ],
                        )),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              SizedBox(height: 300),
                              Container(
                                  decoration: BoxDecoration(
                                    color:
                                        const Color.fromARGB(85, 255, 255, 255),
                                    borderRadius: BorderRadius.circular(50),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 1,
                                        blurRadius: 1,
                                        offset: const Offset(0, 1.5),
                                      ),
                                    ],
                                  ),
                                  child: mood),
                              SizedBox(height: 10),
                              Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 1,
                                        blurRadius: 1,
                                        offset: const Offset(0, 1.5),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    children: [
                                      Text('Lv${plant.level} ${plant.species}'),
                                      Container(
                                          width: 250,
                                          child: HPBar(
                                              currentHP: plant.hp.round(),
                                              maxHP: 100)),
                                      Container(
                                          width: 250,
                                          child: XPBar(
                                              currentXP: plant.remainingXP.round(),
                                              maxXP: 100)),
                                    ],
                                  ))
                            ],
                          ),
                        ],
                      ),
                    ]),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 1,
                                      blurRadius: 1,
                                      offset: const Offset(0, 1.5),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    Text(
                                        "To Do on ${plant.nextWatering.toString().substring(0, 10)}"),
                                    TextButton.icon(
                                      style: TextButton.styleFrom(
                                        foregroundColor: Colors.white,
                                        backgroundColor: Colors.blue,
                                      ),
                                      onPressed: () {
                                        context.read<PlantCubit>().waterPlant();
                                      },
                                      label: const Text('Water'),
                                      icon: const Icon(Icons.water_drop),
                                    ),
                                    Text(
                                      'Last: ${plant.lastWatered.toString().substring(0, 10)}',
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.black54),
                                    ),
                                  ],
                                ),
                              ),
                            ), // Fertilize not done for now as it requires more explanation
                            // Expanded(
                            //   child: Container(
                            //     padding: const EdgeInsets.all(8),
                            //     decoration: BoxDecoration(
                            //     color: Colors.white,
                            //     borderRadius: BorderRadius.circular(10),
                            //     boxShadow: [
                            //       BoxShadow(
                            //         color: Colors.grey.withOpacity(0.5),
                            //         spreadRadius: 1,
                            //         blurRadius: 1,
                            //         offset: const Offset(0, 1.5),
                            //       ),
                            //     ],
                            //   ),
                            //     child: Column(
                            //       children: [
                            //         Text("To Do on ${DateTime.now().toString().substring(0, 10)}"),
                            //         TextButton.icon(
                            //           style: TextButton.styleFrom(
                            //             foregroundColor: Colors.white,
                            //             backgroundColor: Colors.green,
                            //           ),
                            //           onPressed:
                            //             () {
                            //               // TODO : Gain BIG XP (+ bonus if done on time)
                            //             },
                            //           label: const Text('Fertilize'),
                            //           icon: const Icon(Icons.volunteer_activism),
                            //         ),
                            //         Text(
                            //           'Last: 01/01/2024',
                            //           style: TextStyle(
                            //             fontSize: 12,
                            //             color: Colors.black54
                            //           ),
                            //         ),
                            //       ],
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
