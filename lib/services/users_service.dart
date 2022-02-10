
import 'package:task_manager_app/models/api_response.dart';
import 'dart:convert';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:task_manager_app/models/api_response.dart';
import 'package:task_manager_app/models/task.dart';
import "package:http/http.dart" as http;
import 'package:task_manager_app/models/user.dart';
import 'package:task_manager_app/models/user.dart';

class UsersService {
  static const API = 'http://192.168.56.1/API_Task_Manager/api/user';

  Future<APIResponse<Map>>  login(String email, String password){
    final Map<String,dynamic> loginUser = new Map<String,dynamic>();
    loginUser['email'] = email;
    loginUser['password'] = password;
    return http.post(Uri.parse(API + '/login.php'),body: json.encode(loginUser)).then((data){
      if(data.statusCode == 200){
        final jsonData = json.decode(data.body);
        Map<String,dynamic> user = new Map<String,dynamic>();
        print(jsonData);
        return APIResponse<Map>(data:user);
      }
      return APIResponse<Map>(error:true,errorMessage: 'An error occurred');
    }).catchError((_)=>APIResponse<bool>(error: true,errorMessage: 'An error occurred'));
  }
}