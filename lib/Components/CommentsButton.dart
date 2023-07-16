import 'package:flutter/material.dart';
class CommentButton extends StatelessWidget {
  final void Function()? comment;
  const CommentButton({Key? key, required this.comment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: comment,
      child: Icon(Icons.comment, color: Colors.grey  ,)

    );
  }
}
