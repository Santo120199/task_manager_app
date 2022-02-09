import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_app/ui/common/theme_helper.dart';
import 'package:task_manager_app/ui/profile_page.dart';
import 'package:task_manager_app/ui/widgets/header_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({ Key? key }) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  double _headerHeight = 250;
  Key _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: _headerHeight,
              child: HeaderWidget(height: _headerHeight,showIcon: true,icon: Icons.login_rounded),
            ),
            SafeArea(
              child: Container(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                 child: Column(
                   children: [
                     Text('Hello',style: TextStyle(fontSize: 60,fontWeight: FontWeight.bold),),
                     Text('Sign In into your account',style: TextStyle(color: Colors.grey)),
                     SizedBox(height: 30.0,),
                     Form(
                       key: _formKey,
                       child: Column(
                        children: [
                          TextField(
                            decoration: ThemeHelper().textInputDecoration("Email","Enter your email"),
                          ),
                          SizedBox(height: 30.0,),
                          TextField(
                            obscureText: true,
                            decoration: ThemeHelper().textInputDecoration("Password", "Enter your password"),
                          ),
                          SizedBox(height: 15.0,),
                          Container(
                            margin: const EdgeInsets.fromLTRB(10, 0, 10, 20),
                            alignment: Alignment.topRight,
                            child: Text("Forgot your password")
                          ),
                          Container(
                            decoration: ThemeHelper().buttonBoxDecoration(context),
                            child: ElevatedButton(
                              style: ThemeHelper().buttonStyle(),
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
                                child: Text('Sign In'.toUpperCase(),style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color:Colors.white)),
                              ),
                              onPressed: ()async{
                                await Get.to(()=>ProfilePage());
                              },
                            )
                          ),
                          Container(
                            margin: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                            child: Text("Don\'t have an account? Create"),
                          )

                        ],

                       ),
                     )

                   ],
                 )
              ),
            )
          ],
        ),
      )
    );
  }
}