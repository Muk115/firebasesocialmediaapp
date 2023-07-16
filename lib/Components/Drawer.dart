import 'package:firebasesocialmediaapp/Components/My-List.dart';
import 'package:flutter/material.dart';
class MyDrawer extends StatelessWidget {
  final void Function()? onProfile;
  final void Function()? onSignOut;
  const MyDrawer({Key? key, required this.onProfile, required this.onSignOut}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.grey[900],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              // header
              DrawerHeader(child: Icon(Icons.person,
                color: Colors.white,
                size: 64,)),
              // home
              MyListTile(icon: Icons.home, text: 'H O M E', onTap: ()=> Navigator.pop(context),),
              // profile
              MyListTile(icon: Icons.account_circle, text: 'P R O F I L E', onTap: onProfile,),

            ],
          ),
          // logout
          Padding(
            padding: const EdgeInsets.only(bottom: 25.0),
            child: MyListTile(icon: Icons.logout, text: 'L O G O U T', onTap: onSignOut,),
          )
        ],
      ),
    );
  }
}
