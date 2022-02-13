import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_app/ui/common/theme_helper.dart';
import 'package:task_manager_app/ui/login_page.dart';
import 'package:task_manager_app/ui/widgets/header_widget.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({ Key? key }) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {


  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double _headerHeight = 300;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: _headerHeight,
              child: HeaderWidget(height: _headerHeight,icon: Icons.password_rounded,showIcon: true),
            ),
            SafeArea(
              child: Container(
                margin: const EdgeInsets.fromLTRB(25, 10, 25, 10),
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Forgot Password?',style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold, color: Colors.black54)),
                          SizedBox(height: 10,),
                          Text('Enter the email address associated with your account.',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color:Colors.black54)),
                          SizedBox(height: 10,),
                          Text('We will email you a verification code to check your authenticity',style: TextStyle(color:Colors.black54),)
                        ],
                      ),
                    ),
                    SizedBox(height: 40.0,),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          Container(
                            child: TextFormField(
                              decoration: ThemeHelper().textInputDecoration("Email","Enter your email"),
                              validator: (val){
                                if(val!.isEmpty){
                                  return "Email can't be empty";
                                }else if(!RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$").hasMatch(val)){
                                  return "Enter a valid email address";
                                }
                                return null;
                              },
                            ),
                            decoration: ThemeHelper().inputBoxDecorationShadow(),
                          ),
                          SizedBox(height: 40.0,),
                          Container(
                            decoration: ThemeHelper().buttonBoxDecoration(context),
                            child: ElevatedButton(
                              style: ThemeHelper().buttonStyle(),
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
                                child: Text(
                                  "Send".toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white
                                  )
                                )
                              ),
                              onPressed: (){
                                if(_formKey.currentState!.validate()){

                                }
                              },
                            )
                          ),
                          SizedBox(height: 30.0,),
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(text: "Remember your password?"),
                                TextSpan(
                                  text: "Login",
                                  recognizer: TapGestureRecognizer()..onTap = (){
                                    Get.to(()=>LoginPage());
                                  },
                                  style: TextStyle(fontWeight: FontWeight.bold)
                                )
                              ]
                            )
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ) 
            ),
          ],
        ),
      )

    );
  }
}