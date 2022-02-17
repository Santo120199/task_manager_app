import 'package:flutter/material.dart';

class DialogWidget extends StatelessWidget {
  const DialogWidget({ Key? key, required BuildContext context }) : super(key: key);

  

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        children: [
          SizedBox(height: 12,),
          Text("This is a custom dialog")
        ],
      ),
      
    );
  }
}