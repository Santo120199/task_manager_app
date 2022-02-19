
import 'dart:convert';

import 'package:task_manager_app/models/api_response.dart';
import 'package:task_manager_app/models/team.dart';
import "package:http/http.dart" as http;

class TeamsService {

  static const API = 'http://192.168.1.59/API_Task_Manager/api/team';

  Future<APIResponse<bool>> createTeam(Team team){
    return http.post(Uri.parse(API+'/createTeam.php'),body:json.encode(team.toJson())).then((data){
      if(data.statusCode == 200){
        return APIResponse<bool>(data:true);
      }
      return APIResponse<bool>(data:true,errorMessage:'An error occurred' );

    }).catchError((_)=>APIResponse<bool>(error: true,errorMessage:'An error occurred'));
  }


}