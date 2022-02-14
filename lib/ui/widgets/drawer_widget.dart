import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager_app/ui/common/drawer_item.dart';
import 'package:task_manager_app/ui/common/drawer_item_data.dart';
import 'package:task_manager_app/ui/home_page.dart';
import 'package:task_manager_app/ui/login_page.dart';
import 'package:task_manager_app/ui/profile_page.dart';
import 'package:task_manager_app/ui/team_page.dart';

class DrawerWidget extends StatefulWidget {


  const DrawerWidget({ Key? key, required this.onSelectedItem }) : super(key: key);

  final ValueChanged<DrawerItem> onSelectedItem;

 
  
  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {

  String email = "";
  String username = "";

  
  

 Future user()async{
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var userEmail = sharedPreferences.getString('email');
    var userUsername = sharedPreferences.getString('username');
    setState(() {
      email = userEmail!;
      username = userUsername!;
      print(username); 
    });
  }

  @override
  void initState() {
    user();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: [0.0,1.0],
              colors: [Colors.blue.withOpacity(0.6),Colors.blue[200]!.withOpacity(1)]
            )
          ),
         child: ListView(
           children: [
             Container(
               height: 200,
               child: DrawerHeader(
                 child: Column(
                   children: [
                     Container(
                       child: Padding(
                         padding: const EdgeInsets.only(top: 20.0),
                         child: Column(
                           mainAxisAlignment: MainAxisAlignment.center,
                           crossAxisAlignment: CrossAxisAlignment.center,
                           children: [
                             CircleAvatar(
                               radius: 50.0,
                             ),
                             SizedBox(height: 5.0,),
                             Text(username.capitalize!,style:TextStyle(fontSize: 22,fontWeight: FontWeight.w800))
                           ],
                         )
                       ),
                     )
                   ],
                 )
               ),
             ),
             ListTile(
               leading: Icon(FontAwesomeIcons.home),
               title: Text("Home",style: TextStyle(fontSize: 20,color: Colors.white),),
               onTap: (){
                 Navigator.push(context,MaterialPageRoute(builder: (context)=>const HomePage()));
                 
               },
             ),
             ListTile(
               leading: Icon(FontAwesomeIcons.solidUser),
               title: Text("Profile",style: TextStyle(fontSize: 20,color: Colors.white)),
               onTap: (){
                 Navigator.push(context,MaterialPageRoute(builder: (context)=>const ProfilePage()));
               },
             ),
             ListTile(
               leading: Icon(FontAwesomeIcons.users),
               title: Text("Team",style: TextStyle(fontSize: 20,color: Colors.white)),
               onTap: (){
                 Navigator.push(context,MaterialPageRoute(builder: (context)=>const TeamPage()));
               },
             ),
             Align(
               alignment: FractionalOffset.bottomCenter,
               child: Container(
                 margin: const EdgeInsets.only(top: 30),
                 child: ListTile(
                   leading: Icon(FontAwesomeIcons.signOutAlt),
                   title: Text('Logout',style: TextStyle(fontSize: 20,color:Colors.white)),
                   onTap: (){
                     _logout();
                   }
                 ),
               ),
             )
           ],
         )
        )
      );
      
  }

   _logout()async{
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove('username');
    sharedPreferences.remove('email');
    Get.to(()=>LoginPage());
  }

 
}