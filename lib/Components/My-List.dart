import 'package:flutter/material.dart';
class MyListTile extends StatelessWidget {
  final IconData icon;
  final String text;
  const MyListTile({Key? key, required this.icon, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ListTile(
        leading: Icon(icon, color: Colors.white, ),
        title: Text(text, style: TextStyle(color: Colors.white),),

      ),
    );
  }
}
