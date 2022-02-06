
import 'dart:convert';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:task_manager_app/models/api_response.dart';
import 'package:task_manager_app/models/task.dart';
import "package:http/http.dart" as http;

class TasksService {

  static const API = 'http://192.168.56.1/API_Task_Manager/api/task';

  Future<APIResponse<List<Task>>> getTasksList(){
    return http.get(Uri.parse(API + '/read.php')).then((data){
      if(data.statusCode == 200){
        final jsonData = json.decode(data.body);
        final jsonD = jsonData['data'];
        final tasks = <Task>[];
        print(jsonD);

        for(var item in jsonD){
          
          tasks.add(Task.fromJson(item));
        }
        return APIResponse<List<Task>>(data: tasks.obs);
      }
      return APIResponse<List<Task>>(error: true, errorMessage: "An error occurred");
    }).catchError((_)=>APIResponse<List<Task>>(error:true,errorMessage: 'An error occurred shit'));
  }

  Future<APIResponse<bool>> createTask(Task item){
    return http.post(Uri.parse(API + '/create.php'),body:json.encode(item.toJson())).then((data){
      if(data.statusCode == 201){
        return APIResponse<bool>(data:true);
      }
      return APIResponse<bool>(data: true,errorMessage: 'An error occurred');
    }).catchError((_)=>APIResponse<bool>(error: true,errorMessage: 'An error occurred'));
  }

  Future<APIResponse<bool>> deleteTask(String id){
    final Map<String,dynamic> taskId = new Map<String,dynamic>();
    taskId['id'] = id;
    return http.delete(Uri.parse(API + '/delete.php'),body: json.encode(taskId)).then((data){
      if(data.statusCode == 204){
        return APIResponse<bool>(data: true);
      }
      return APIResponse<bool>(data: true,errorMessage: 'An error occurred');
    }).catchError((_)=>APIResponse<bool>(error: true, errorMessage: 'An error occurred'));
  }

  Future<APIResponse<bool>> completeTask(String id, String complete){
    final Map<String,dynamic> taskComplete = new Map<String,dynamic>();
    taskComplete['id'] = id;
    taskComplete['isCompleted'] = complete;
    return http.put(Uri.parse(API + '/complete.php'),body: json.encode(taskComplete)).then((data){
      if(data.statusCode == 204){
        return APIResponse<bool>(data: true);
      }
      return APIResponse<bool>(error: true,errorMessage: 'An error occurred');
    }).catchError((_)=>APIResponse<bool>(error: true,errorMessage: 'An error occurred'));
  }

  
}