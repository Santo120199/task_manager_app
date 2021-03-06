import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:task_manager_app/services/tasks_service.dart';
import 'package:task_manager_app/services/teams_service.dart';
import 'package:task_manager_app/services/users_service.dart';
import 'package:task_manager_app/ui/common/drawer_item.dart';
import 'package:task_manager_app/ui/common/drawer_item_data.dart';
import 'package:task_manager_app/ui/home_page.dart';
import 'package:task_manager_app/ui/widgets/drawer_widget.dart';
import 'package:task_manager_app/ui/widgets/splash_screen.dart';


void setupLocator(){
  GetIt.I.registerLazySingleton(() => TasksService());
  GetIt.I.registerLazySingleton(() => UsersService());
  GetIt.I.registerLazySingleton(() => TeamsService());
}

void main() {
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(title:'ua gas'),
    );
  }
}

