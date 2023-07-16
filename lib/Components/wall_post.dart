import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasesocialmediaapp/Components/Comments.dart';
import 'package:flutter/material.dart';

import '../helper_method/helper.dart';
import 'CommentsButton.dart';
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
  final commentController = TextEditingController();
  final currentUser = FirebaseAuth.instance.currentUser!;
  bool isLiked = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isLiked = widget.likes.contains(currentUser.email);
  }
  // to change between likes and dislike
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
  // add a comment

  void addComment (String commentText){
    // write the comments to store firestore under the comment collection for this post
    FirebaseFirestore.instance.collection('User posts').
    doc(widget.postId).collection('Comments').add({
      'CommentText': commentText,
      'CommentBy': currentUser.email,
      'CommentTime': Timestamp.now()
    });
  }

  // show a dialog for adding the comment
  void showComments (){
    showDialog(context: context, builder: (context){
      return AlertDialog(
        title: const Text('Add Comment'),
        content: TextField(
          controller: commentController,
          decoration: InputDecoration(
            hintText: 'Write a comment'
          ),

        ),
        actions: [
          // cancel
          TextButton(onPressed: ()=>Navigator.pop(context),
              child: Text('Cancel')),
          // save
          TextButton(onPressed: (){
            addComment(commentController.text);
            Navigator.pop(context);
            commentController.clear();


          }, child: Text('Post'),

          ),
        ],
      );
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      // container design
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8)
      ),
      margin: const EdgeInsets.only(top: 25,left: 25,right: 25),
      padding: const EdgeInsets.all(25),
      child: Column(
        children: [
          const SizedBox(width: 20,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10,),
              // display message
              Text(widget.message),
              const SizedBox(height: 5,),
              // display user email
              Text(widget.user, style: TextStyle(
                color: Colors.grey[500]
              ),),
              const SizedBox(height: 20,),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      // Liked Button
                      LikedButton(onTap: toggleState, isLiked: isLiked,),
                      const SizedBox(height: 5,),
                      Text(widget.likes.length.toString(),style: const TextStyle(color: Colors.grey),
                      ),


                      // Liked counter
                    ],
                  ),
                  const SizedBox(width: 10,),
                  Column(
                    children: [
                      // Liked Button
                      CommentButton(comment: showComments,),
                      const SizedBox(height: 5,),
                      Text('0',style: const TextStyle(color: Colors.grey),
                      ),
                      // Liked counter
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20,),
              // display comments
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('User posts').
                doc(widget.postId).collection('Comments').
                orderBy('CommentTime', descending: true).snapshots(),
                  builder: (context, snapshots){
                  // no data
                    if (!snapshots.hasData){
                      return const Center(child: CircularProgressIndicator());
                    }
                    return ListView(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children:
                        snapshots.data!.docs.map((doc) {
                          // get comments
                          final CommentData = doc.data() as Map<String, dynamic>;
                          // return the comment
                          return Comments(
                            text: CommentData['CommentText'],
                            user: CommentData['CommentBy'],
                            time: formattedDate(CommentData['CommentTime']),
                          );

                        }).toList(),

                    );

              })
            ],
          ),
        ],
      ),
    );
  }
}
