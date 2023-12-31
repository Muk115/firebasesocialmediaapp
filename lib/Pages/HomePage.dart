import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasesocialmediaapp/Components/Drawer.dart';
import 'package:firebasesocialmediaapp/Components/wall_post.dart';
import 'package:firebasesocialmediaapp/Pages/Profile_page.dart';
import 'package:firebasesocialmediaapp/helper_method/helper.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final messageController = TextEditingController();
  final currentUser = FirebaseAuth.instance.currentUser!;
  void signOut () async {
    await FirebaseAuth.instance.signOut();
  }
  void postMessage (){
    // only post if there is something in the Textfield
    if (messageController.text.isNotEmpty) {
      FirebaseFirestore.instance.collection('User posts').add({
        'UserEmail': currentUser.email,
        'Message': messageController.text,
        'TimeStamp': Timestamp.now(),
        'likes':[],

      });
    }
    setState(() {
      messageController.clear();
    });

  }
  void goToProfilePage(){
    // pop the drawer
    Navigator.pop(context);
    // goto profilepage
    Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage()));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        title: Center(child: Text('The Wall')),
      ),
      drawer: MyDrawer(onProfile: goToProfilePage, onSignOut: signOut,),
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          children: [
            // wall
            Expanded(child: StreamBuilder(
              stream: FirebaseFirestore.instance.collection('User posts').orderBy('TimeStamp', descending: false).snapshots(),
              builder: (context, snapshots){
                if (snapshots.hasData){
                  return ListView.builder(
                    itemCount: snapshots.data!.docs.length,
                      itemBuilder: (context, index){
                    final post = snapshots.data!.docs[index];
                    return WallPost(message: post['Message'],
                        user: post['UserEmail'], postId: post.id, likes: List<String>.from(post['likes']??[]), time: formattedDate(post['TimeStamp']),
                    );

                  });
                } else if (snapshots.hasError){
                  return Center(child: Text('Error: ${snapshots.hasError}'),);
                }
                return const Center( child: CircularProgressIndicator());
              }
            )
            ),
            // message
            Row(children: [
              Expanded(child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextField(
                  controller: messageController,
                  obscureText: false,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(

                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Theme.of(context).colorScheme.primary)


                    ),
                    hintText: 'Write something on the wall',
                    hintStyle: TextStyle(color: Theme.of(context).colorScheme.secondary),
                    filled: true,
                    fillColor: Theme.of(context).colorScheme.background

                  ),

                ),
              )),
              GestureDetector(
                onTap: postMessage,
                  child: Icon(Icons.arrow_circle_down)
              ),

            ],),
            //logged in as
            Text('Logged in as ${currentUser.email}'),

          ],
        ),
      ),

    );
  }
}
