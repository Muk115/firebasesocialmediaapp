import 'package:firebasesocialmediaapp/Components/My-List.dart';
import 'package:flutter/material.dart';
class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.grey[900],
      child: const Column(
        children: [
          // header
          DrawerHeader(child: Icon(Icons.person,
            color: Colors.white,
            size: 64,)),
          // home
          MyListTile(icon: Icons.home, text: 'H O M E'),
          // profile
          MyListTile(icon: Icons.account_circle, text: 'P R O F I L E'),
          // logout
          MyListTile(icon: Icons.logout, text: 'L O G O U T')

        ],
      ),
    );
  }
}
