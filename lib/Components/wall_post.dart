import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'Like_Button.dart';
class WallPost extends StatefulWidget {
  final String message;
  final String user;
  final String postId;
  final List<String> likes;

  const WallPost({Key? key, required this.message, required this.user, required this.postId, required this.likes,}) : super(key: key);

  @override
  State<WallPost> createState() => _WallPostState();
}

class _WallPostState extends State<WallPost> {
  final currentUser = FirebaseAuth.instance.currentUser!;
  bool isLiked = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isLiked = widget.likes.contains(currentUser.email);
  }
  void toggleState (){
    setState(() {
      // toggle between state
      isLiked = !isLiked;
    });
    // Acces documents in fireBase
    DocumentReference postRef =
        FirebaseFirestore.instance.collection('User posts').doc(widget.postId);
    if (isLiked){
      // if this post is liked adds user's to the likes field
      postRef.update({'likes': FieldValue.arrayUnion([currentUser.email])});
    } else{
      postRef.update({'likes': FieldValue.arrayRemove([currentUser.email])});

    }

  }
  @override
  Widget build(BuildContext context) {
    return Container(
      // container design
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8)
      ),
      margin: EdgeInsets.only(top: 25,left: 25,right: 25),
      padding: EdgeInsets.all(25),
      child: Row(
        children: [
          Column(
            children: [
              // Liked Button
              LikedButton(onTap: toggleState, isLiked: isLiked,),
              SizedBox(height: 5,),
              Text(widget.likes.length.toString(),style: TextStyle(color: Colors.grey),
              ),

              // Liked counter
            ],
          ),
          SizedBox(width: 20,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // display user email
              Text(widget.user, style: TextStyle(
                color: Colors.grey[400]
              ),),
              SizedBox(height: 10,),
              // display message
              Text(widget.message),
            ],
          ),
        ],
      ),
    );
  }
}
