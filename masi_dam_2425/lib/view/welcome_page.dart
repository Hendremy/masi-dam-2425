import 'package:flutter/material.dart';
import 'package:masi_dam_2425/view/components/experience_bar.dart';

class WelcomePage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Center(child: Text('Greenmon')),
        ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            _userRow(context),
            _levelRow(context),
            _shopRow(context),
            _plantsColumn(context)
          ],
        ),
      )
    );
  }

  Widget _userRow(context){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset('assets/warrior.jpg', height: 150,),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Text('SuperUser'),
              IconButton(onPressed: (){
              Navigator.pushNamed(context, '/settings');
            },
            icon: Icon(Icons.settings))
              ],
            ),
            Text('Guardian of the Plants'),
            //ExperienceBar(currentXp: 50, maxXp: 100)
          ],
        )
      ],
    );
  }

  Widget _levelRow(context){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Lvl 50'),
        Expanded(child: ExperienceBar(currentXp: 50, maxXp: 100))
      ],
    );
  }

  Widget _shopRow(context){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton.icon(
          onPressed: (){
            Navigator.pushNamed(context, '/shop');
          },
          icon: Icon(Icons.currency_exchange),
          label: const Text("1500")),
        TextButton.icon(
          onPressed: (){
            Navigator.pushNamed(context, '/inventory');
          }, 
          icon: Icon(Icons.backpack),
          label: const Text("Inventory")),
      ],
    );
  }

  Widget _plantsColumn(context){
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          TextButton(onPressed: (){
          Navigator.pushNamed(context, '/plants');
          }, 
          child: Text('Plants')),
        IconButton(
          onPressed: (){
          Navigator.pushNamed(context, '/calendar');
          }, 
          icon: Icon(Icons.calendar_month))
        ],),
        ListTile(),
        ListTile(),
        ListTile(),
      ],
    );
  }

}