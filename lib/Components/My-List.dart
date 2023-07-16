import 'package:flutter/material.dart';
class MyListTile extends StatelessWidget {
  final IconData icon;
  final String text;
  final void Function()? onTap;
  const MyListTile({Key? key, required this.icon, required this.text, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GestureDetector(
        onTap: onTap ,
        child: ListTile(
          leading: Icon(icon, color: Colors.white, ),
          title: Text(text, style: const TextStyle(color: Colors.white),),

        ),
      ),
    );
  }
}
