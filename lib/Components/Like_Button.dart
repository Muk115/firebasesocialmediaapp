import 'package:flutter/material.dart';

class LikedButton extends StatelessWidget {
  final bool isLiked;
  final Function()? onTap;
  const LikedButton({Key? key,required this.onTap, required this.isLiked} ) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Icon(
        isLiked? Icons.favorite : Icons.favorite_border,
        color: isLiked? Colors.red: Colors.grey,
      ),

    );

  }
}
