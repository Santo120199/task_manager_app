import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UserWidget extends StatefulWidget {
  const UserWidget({ Key? key }) : super(key: key);

  @override
  _UserWidgetState createState() => _UserWidgetState();
}

class _UserWidgetState extends State<UserWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      margin: const EdgeInsets.only(left: 15),
      child: Column(
        children: [
          CircleAvatar(
            radius: 40,
          ),
          SizedBox(height: 10,),
          Text("Davide",style: GoogleFonts.lato(
            textStyle: TextStyle(fontSize: 18)
          ),),
        ],
      ),
    );
  }
}