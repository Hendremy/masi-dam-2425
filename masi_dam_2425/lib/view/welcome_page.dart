import 'package:flutter/material.dart';

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
        Text("Avatar"),
        TextButton.icon(onPressed: (){
          Navigator.pushNamed(context, '/settings');
        },
        icon: Icon(Icons.settings), 
        label: const Text('Options'))
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