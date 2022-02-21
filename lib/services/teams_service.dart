
import 'dart:convert';

import 'package:get/get_rx/src/rx_types/rx_types.dart';
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

  Future<APIResponse<List<Team>>> getTeamList(String userId){
    final Map<String,dynamic> id = Map<String,dynamic>();
    id['createdBy'] = userId;
    print(id);
    return http.post(Uri.parse(API + '/readTeam.php'),body: json.encode(id)).then((data){
      print(data.statusCode);
      if(data.statusCode == 200){
        
        final jsonData = json.decode(data.body);
        print(jsonData);
        final jsonD = jsonData['data'];
        final teams = <Team>[];
        print(jsonD);

        for(var item in jsonD){
          teams.add(Team.fromJson(item));
        }
        print(teams);
        return APIResponse<List<Team>>(data:teams.obs);
      }
      return APIResponse<List<Team>>(error: true,errorMessage: 'An error occurred');
    }).catchError((_)=>APIResponse<List<Team>>(error: true,errorMessage: 'An error occurred shit'));

  }




}