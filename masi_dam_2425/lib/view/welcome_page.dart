import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            _userRow(context),
            _shopRow(context),
            _plantsColumn(context)
          ],
        ),
      )
    );
  }

  Widget _userRow(context){
    return Row(
      children: [
        Text("Avatar"),
        TextButton(onPressed: (){
          Navigator.pushNamed(context, '/settings');
        }, child: const Text('Options'))
      ],
    );
  }

  Widget _shopRow(context){
    return Row(
      children: [
        TextButton(
          onPressed: (){
            Navigator.pushNamed(context, '/shop');
          }, 
          child: const Text("Shop")),
        TextButton(
          onPressed: (){
            Navigator.pushNamed(context, '/inventory');
          }, 
          child: const Text("Inventory")),
      ],
    );
  }

  Widget _plantsColumn(context){
    return Column(
      children: [
        TextButton(onPressed: (){
          Navigator.pushNamed(context, '/plants');
          }, 
          child: Text('Plants')),
        TextButton(onPressed: (){
          Navigator.pushNamed(context, '/calendar');
          }, 
          child: Text('Watering Calendar')),
        ListTile(),
        ListTile(),
        ListTile(),
      ],
    );
  }

}