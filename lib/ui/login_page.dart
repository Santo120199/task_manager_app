import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager_app/services/users_service.dart';
import 'package:task_manager_app/ui/common/theme_helper.dart';
import 'package:task_manager_app/ui/forgot_password_page.dart';
import 'package:task_manager_app/ui/home_page.dart';
import 'package:task_manager_app/ui/profile_page.dart';
import 'package:task_manager_app/ui/registration_page.dart';
import 'package:task_manager_app/ui/widgets/header_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({ Key? key }) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  double _headerHeight = 250;
  Key _formKey = GlobalKey<FormState>();

  UsersService get userService => GetIt.I<UsersService>(); 

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

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
                            controller: _emailController,
                          ),
                          SizedBox(height: 30.0,),
                          TextField(
                            obscureText: true,
                            decoration: ThemeHelper().textInputDecoration("Password", "Enter your password"),
                            controller: _passController,
                          ),
                          SizedBox(height: 15.0,),
                          Container(
                            margin: const EdgeInsets.fromLTRB(10, 0, 10, 20),
                            alignment: Alignment.topRight,
                            child: Text.rich(
                              TextSpan(text: "Forgot your Password?",
                                recognizer: TapGestureRecognizer()..onTap =(){
                                  Get.to(()=>ForgotPassword());
                                }
                              )
                            ),
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
                                _validateData();
                              },
                            )
                          ),
                          Container(
                            margin: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                            //child: Text("Don\'t have an account? Create"),
                            child: Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(text: "Don\'t have an account? "),
                                  TextSpan(
                                    text: "Create",
                                    recognizer: TapGestureRecognizer()..onTap = (){
                                      Get.to(()=>RegistrationPage());  
                                    },
                                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue)
                                  ),
                                ] 
                              )
                            ),
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

  _validateData()async{
    if(_emailController.text.isNotEmpty && _passController.text.isNotEmpty){
      _login();
    }else if(_emailController.text.isEmpty || _passController.text.isEmpty){
      Get.snackbar("Required", "All fields are required!",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.white,
      colorText: Colors.red,
      icon: Icon(Icons.warning_amber_rounded)
      );
    }
  }

  _login()async{
    String email = _emailController.text;
    String pass = _passController.text;

    final result = await userService.login(email,pass);
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    print(result.data?['username']);
    if(result.data?['status'] == 401){
      Get.snackbar("Danger", "Invalid Credentials",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.white,
      colorText: Colors.red,
      icon: Icon(Icons.password_outlined)
      );
    }else {
      sharedPreferences.setString('id',result.data?['id']);
      sharedPreferences.setString('username',result.data?['username']);
      sharedPreferences.setString('email', result.data?['email']);
      Get.to(()=>HomePage());
    }

  }
}