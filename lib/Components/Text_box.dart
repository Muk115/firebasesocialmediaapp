import 'package:flutter/material.dart';
class Textbox extends StatelessWidget {
  final void Function()? onTap;
  final String membername;
  final String Userdetails;
  const Textbox({Key? key, required this.membername, required this.Userdetails, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8)
      ),
      padding: EdgeInsets.only(left: 15, bottom: 15, right: 15, top: 15),
      margin: EdgeInsets.only(left: 20, right: 20,top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(membername, style: TextStyle(color: Colors.grey[500]),),
              GestureDetector(
                onTap: onTap,
                  child: Icon(Icons.settings, color: Colors.grey[400],),
              )
            ],
          ),
          Text(Userdetails)
        ],
      ),
    );
  }
}
