
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasesocialmediaapp/Components/Text_box.dart';
import 'package:flutter/material.dart';
class ProfilePage extends StatefulWidget {

  const ProfilePage({Key? key, }) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final currentUser = FirebaseAuth.instance.currentUser!;
  final userCollections = FirebaseFirestore.instance.collection('Users');
  Future<void> editDetails (String field) async {
    String newValue = '';
    await  showDialog(context: context, builder: (context){
      return AlertDialog(
        backgroundColor: Colors.grey[900],
        title: Text ('Edit this ${field}',
          style: TextStyle(color: Colors.grey[300]),),
        content: TextField(
          autofocus: true,
          style: TextStyle(
            color: Colors.grey[300]
          ),
          decoration: InputDecoration(
            hintText: 'Enter a new $field',
            hintStyle: TextStyle(color: Colors.grey)
          ),
          onChanged: (value){
            newValue = value;
          },
        ),
        actions: [
          // cancel button and save button
          TextButton(onPressed: () => Navigator.pop(context), child: Text('Cancel', style: TextStyle(color: Colors.grey[300]),)),
          TextButton(onPressed: ()=> Navigator.of(context).pop(newValue), child: Text('Save', style: TextStyle(color: Colors.grey[300]),)),
        ],

      );

    });

    if (newValue.trim().length > 0){
      // only upfate the firestore textfield

      await userCollections.doc(currentUser.email!).update({field:newValue});

      
    }

  }
  Future<void> EditBio (String Bio) async {

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        title: Center(child: Text('Profile Page')),
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance.collection('Users').
        doc(currentUser.email).snapshots(),
        builder: (context, snapshot){
          if (snapshot.hasData){
            // get user data
            final UserData = snapshot.data!.data() as Map <String, dynamic>;
            return ListView(
              children: [
                const SizedBox(height: 50,),

                Icon(Icons.person, color: Colors.grey,size: 72,),
                const SizedBox(height: 10),
                // Profile Icon or Image
                // user email
                Text(currentUser.email!, style: TextStyle(color: Colors.grey[700]),
                    textAlign: TextAlign.center),
                const SizedBox(height: 50,),
                // user details
                Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: Text('My Details', style: TextStyle(color: Colors.grey[600]),),
                ),
                Textbox(membername:'username' , Userdetails: UserData['username'],
                  onTap: ()=> editDetails('username')),
                Textbox(membername: 'bio', Userdetails: UserData['bio'],
                  onTap: ()=> editDetails('bio'),),
                const SizedBox(height: 25,),
                Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: Text('My posts', style: TextStyle(color: Colors.grey[600]),),
                ),




                //username
                // bio

                // user post
              ],
            );

          } else if (snapshot.hasError){
            return Center(child: Text('Error: ${snapshot.hasError.toString()}'),);
          } else {
            return Center(child: CircularProgressIndicator(),);
          }
        },
      )
    );
  }
}
