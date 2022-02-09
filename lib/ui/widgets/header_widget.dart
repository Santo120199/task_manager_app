import 'dart:ui';

import 'package:flutter/material.dart';

class HeaderWidget extends StatefulWidget {
  

  final double height;
  final bool showIcon;
  final IconData icon;

  const HeaderWidget({ Key? key, required this.height,required this.icon,required this.showIcon }) : super(key: key);

  @override
  _HeaderWidgetState createState() => _HeaderWidgetState(height,icon,showIcon);
}

class _HeaderWidgetState extends State<HeaderWidget> {

  late double height;
  late bool showIcon;
  late IconData icon;

  _HeaderWidgetState(this.height,this.icon,this.showIcon);


  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;

    return Container(
      child: Stack(
        children: [
          ClipPath(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.blue.withOpacity(0.4),Colors.blue[200]!.withOpacity(0.4)
                  ],
                  begin: const FractionalOffset(0.0,0.0),
                  end: const FractionalOffset(1.0, 0.0),
                  stops: [0.0,1.0],
                  tileMode: TileMode.clamp
                ),
              ),
            ),
            clipper: ShapeClipper(
              [
                Offset(width/5, height),
                Offset(width/10, height-60),
                Offset(width/5, height+20),
                Offset(width, height-10)
              ]
            ),
          ),
          ClipPath(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue.withOpacity(0.4),Colors.blue[200]!.withOpacity(0.4)],
                  begin: FractionalOffset(0.0,0.0),
                  end: FractionalOffset(1.0,0.0),
                  stops: [0.0,1.0],
                  tileMode: TileMode.clamp
                ),
              ),
            ),
            clipper: ShapeClipper(
              [
                Offset(width/5,height),
                Offset(width/10*5,height-60),
                Offset(width/5*4, height+20),
                Offset(width,height-18)
              ]
            ),
          ),
          ClipPath(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue.withOpacity(0.4),Colors.blue[200]!.withOpacity(0.4)],
                  begin: FractionalOffset(0.0,0.0),
                  end: FractionalOffset(1.0,0.0),
                  stops: [0.0,1.0],
                  tileMode: TileMode.clamp
                ),
              ),
            ),
            clipper: ShapeClipper(
              [
                Offset(width/3,height+20),
                Offset(width/10*8,height-60),
                Offset(width/5*4,height-60),
                Offset(width,height-20)
              ]
            ),
          ),
          ClipPath(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue,Colors.blue[200]!],
                  begin: FractionalOffset(0.0,0.0),
                  end: FractionalOffset(1.0,0.0),
                  stops: [0.0,1.0],
                  tileMode: TileMode.clamp
                ),
              ),
            ),
            clipper: ShapeClipper(
              [
                Offset(width/5,height),
                Offset(width/2,height-40),
                Offset(width/5*4,height-80),
                Offset(width,height-20)
              ]
            ),
          ),
          Visibility(
            visible: showIcon,
            child: Container(
              height: height-40,
              child: Center(
                child: Container(
                  margin: const EdgeInsets.all(20),
                  padding: const EdgeInsets.only(
                    left: 5.0,
                    top: 20.0,
                    right: 5.0,
                    bottom: 20.0
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(100),
                      topRight: Radius.circular(100),
                      bottomLeft: Radius.circular(60),
                      bottomRight: Radius.circular(60)
                    ),
                    border: Border.all(width: 5,color: Colors.white),
                  ),
                  child: Icon(
                    icon,
                    color: Colors.white,
                    size: 40.0,
                  ),
                ),
              ),
            ),
          ),
          
        ],
      ),
      
    );
  }
}

class ShapeClipper extends CustomClipper<Path>{
  List<Offset> _offsets = [];
  ShapeClipper(this._offsets);

  @override
  Path getClip(Size size){
    var path = Path();

    path.lineTo(0.0, size.height-20);

    path.quadraticBezierTo(_offsets[0].dx, _offsets[0].dy, _offsets[1].dx, _offsets[1].dy);
    path.quadraticBezierTo(_offsets[2].dx, _offsets[2].dy, _offsets[3].dx, _offsets[3].dy);

    path.lineTo(size.width, 0.0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper)=> false;


}