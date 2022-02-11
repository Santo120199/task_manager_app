import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:get_it/get_it.dart';
import 'package:task_manager_app/models/user.dart';
import 'package:task_manager_app/services/users_service.dart';
import 'package:task_manager_app/ui/common/theme_helper.dart';
import 'package:task_manager_app/ui/login_page.dart';
import 'package:task_manager_app/ui/widgets/header_widget.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({ Key? key }) : super(key: key);

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {

  final Key _formKey = GlobalKey<FormState>();

  TextEditingController _usernameContronller = TextEditingController();
  TextEditingController _emailContronller = TextEditingController();
  TextEditingController _passwordContronller = TextEditingController();

  UsersService get service => GetIt.I<UsersService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: 150,
              child: HeaderWidget(height: 150, icon: Icons.person_add_alt_1_rounded, showIcon: false),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(25, 50, 25, 10),
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              alignment: Alignment.center,
              child: Column(
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        GestureDetector(
                          child: Stack(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  border: Border.all(
                                    width: 5, color: Colors.white
                                  ),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 20,
                                      offset: Offset(5,5),
                                    ),
                                  ],
                                ),
                                child: Icon(
                                  Icons.person,
                                  color: Colors.grey.shade200,
                                  size: 80.0,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.fromLTRB(80, 80, 0, 0),
                                child: Icon(
                                  Icons.add_circle,
                                  color: Colors.grey.shade700,
                                  size: 25.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 30,),
                        Container(
                          child: TextFormField(
                            decoration: ThemeHelper().textInputDecoration('Username','Enter your Username'),
                            controller: _usernameContronller,
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShadow(),
                          
                        ),
                        SizedBox(height: 30,),
                        Container(
                          child: TextFormField(
                            decoration: ThemeHelper().textInputDecoration('Email','Enter your Email'),
                            controller: _emailContronller,
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShadow(),
                        ),
                        SizedBox(height: 30,),
                        Container(
                          child: TextFormField(
                            obscureText: true,
                            decoration: ThemeHelper().textInputDecoration('Password','Enter your Password'),
                            controller: _passwordContronller,
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShadow(),
                        ),
                        SizedBox(height: 20,),
                        Container(
                          decoration: ThemeHelper().buttonBoxDecoration(context),
                          child: ElevatedButton(
                            style: ThemeHelper().buttonStyle(),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
                              child: Text(
                                'Register'.toUpperCase(),
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white, 
                                )
                              ),
                            ),
                            onPressed: (){
                              _validate();
                            },
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      )
    );
  }

  _validate(){
    if(_emailContronller.text.isNotEmpty && _usernameContronller.text.isNotEmpty && _passwordContronller.text.isNotEmpty){
      _register();
      Get.to(()=>LoginPage());
    }else if(_emailContronller.text.isEmpty || _usernameContronller.text.isEmpty || _passwordContronller.text.isEmpty){
      Get.snackbar("Required", "All fields are required!",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.white,
      colorText: Colors.red,
      icon: Icon(Icons.warning_amber_rounded)
      );
    }
  }

  _register()async{
    final user = User(
      username: _usernameContronller.text,
      email: _emailContronller.text,
      password: _passwordContronller.text
    );
    final result = await service.register(user);
  
  }
}