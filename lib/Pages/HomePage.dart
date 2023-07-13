import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasesocialmediaapp/Components/Drawer.dart';
import 'package:firebasesocialmediaapp/Components/wall_post.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        actions: [

          GestureDetector(
            onTap: signOut,
              child: Icon(Icons.logout)
          )
        ],
        title: Center(child: Text('The Wall')),
      ),
      drawer: MyDrawer(),
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
                        user: post['UserEmail'], postId: post.id, likes: List<String>.from(post['likes']??[]),
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


                    ),
                    hintText: 'Write something on the wall',
                    filled: true,
                    fillColor: Colors.white

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
