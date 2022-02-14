
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager_app/ui/common/drawer_item.dart';
import 'package:task_manager_app/ui/common/drawer_item_data.dart';
import 'package:task_manager_app/ui/login_page.dart';
import 'package:task_manager_app/ui/widgets/drawer_widget.dart';
import 'package:task_manager_app/ui/widgets/header_widget.dart';
import 'package:task_manager_app/ui/widgets/splash_screen.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({ Key? key }) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  double _drawerIconSize= 24;
  String email = "";
  String username = "";

  DrawerItem item = DrawerItems.home;


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
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profile Page",
          style: TextStyle(color:Colors.white,fontWeight: FontWeight.bold)
        ),
        elevation: 0.5,
        iconTheme: IconThemeData(color: Colors.white),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[Colors.blue,Colors.blue[200]!]
            )
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(top: 16,right:16),
            child: Stack(
              children: <Widget>[
                Icon(Icons.notifications),
                Positioned(
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(1),
                    decoration: BoxDecoration(color: Colors.red,borderRadius: BorderRadius.circular(6)),
                    constraints: BoxConstraints(minWidth: 12,minHeight: 12),
                    child: Text('5',style: TextStyle(color: Colors.white,fontSize: 8),textAlign: TextAlign.center,),
                  )
                )
              ],
            ),
          )
        ],
      ),
      drawer: buildDrawer(),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: 100,
              child: HeaderWidget(height: 100,showIcon: false, icon: Icons.house_rounded,),
            ),
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.fromLTRB(25, 10, 25, 10),
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(width: 5, color:Colors.white),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(color: Colors.black12,blurRadius: 20,offset: Offset(5,5))
                      ]
                    ),
                    child: Icon(Icons.person, size: 80, color:Colors.grey.shade400),
                  ),
                  SizedBox(height: 20,),
                  Text('Mr.'+username.toUpperCase(), style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold)),
                  SizedBox(height: 20,),
                  Text('Former President', style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                  SizedBox(height: 20,),
                ],
              )
            )
          ]
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
  Widget buildDrawer()=> SafeArea(
    child: DrawerWidget(
      onSelectedItem: (item){
        setState(() {
          this.item = item;
          print(item);
        });
      },
    ));
 
}

/* drawer: Drawer(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: [0.0,1.0],
              colors: [Colors.blue.withOpacity(0.2),Colors.blue[200]!.withOpacity(0.5)]
            )
          ),
          child: ListView(
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: [0.0,1.0],
                    colors: [Colors.blue,Colors.blue[200]!]
                  )
                ),
                child: Container(
                  alignment: Alignment.bottomLeft,
                  child: Text(username.toUpperCase(),style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color:Colors.white),),
                ),
              ),
              ListTile(
                leading: Icon(Icons.screen_lock_landscape_rounded,size: _drawerIconSize,color: Colors.blue[200]!,),
                title: Text("Splash Screen", style: TextStyle(fontSize: 17,color:Colors.blue[200]!)),
                onTap: ()async{
                  await Get.to(()=>SplashScreen(title: "Splash Screen"));
                }
              ),
              ListTile(
                leading: Icon(Icons.logout_rounded,size: _drawerIconSize,color: Colors.blue[200]!,),
                title: Text("Logout", style: TextStyle(fontSize: 17,color:Colors.blue[200]!)),
                onTap: ()async{
                  _logout();
                }
              )
            ],
          )
        )
      ), */