import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager_app/models/api_response.dart';
import 'package:task_manager_app/models/task.dart';
import 'package:task_manager_app/models/user.dart';
import 'package:task_manager_app/services/tasks_service.dart';
import 'package:task_manager_app/ui/common/drawer_item.dart';
import 'package:task_manager_app/ui/common/drawer_item_data.dart';
import 'package:task_manager_app/ui/create_team.dart';
import 'package:task_manager_app/ui/theme.dart';
import 'package:task_manager_app/ui/widgets/drawer_widget.dart';
import 'package:task_manager_app/ui/widgets/header_widget.dart';
import 'package:task_manager_app/ui/widgets/user_widget.dart';

class TeamPage extends StatefulWidget {
  const TeamPage({ Key? key }) : super(key: key);

  @override
  _TeamPageState createState() => _TeamPageState();
}

class _TeamPageState extends State<TeamPage> {

  var _scaffoldKey = GlobalKey<ScaffoldState>();

   DrawerItem item = DrawerItems.home;

  TasksService get service => GetIt.I<TasksService>();

  late APIResponse<List<Task>> _apiResponse;
  bool _isLoading = false;

  @override
  void initState(){
    _fetchTasks();
  }


  _fetchTasks()async{
    setState(() {
      _isLoading = true;
    });
      
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var userId = sharedPreferences.getString('id');
    _apiResponse = await service.getTasksList(userId!);
    print(_apiResponse.data);
    
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: _appBar(context),
      drawer: buildDrawer(),
      body: Column(
        children: [

          _header(),
          _headerPage(),
          SizedBox(height: 30,),
          _showUser(),
      ]
      )
    );
  }

   _appBar(BuildContext context){
    return AppBar(
      leading: GestureDetector(
        onTap:(){
          _scaffoldKey.currentState?.openDrawer();
        },
        child: Icon(FontAwesomeIcons.bars,size:20),
      ),
    );
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

  _headerPage(){
    return Container(
          margin: const EdgeInsets.only(top: 20),
          alignment: Alignment.topCenter,
          child: Text('Team Member',style: headingStyle),
    );
  }

  _header() {
    return Stack(
      children: [
        Container(
            height: 100,
            child: HeaderWidget(
              height: 100,
              showIcon: false,
              icon: Icons.house_rounded,
            )),
        Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.fromLTRB(25, 20, 25, 10),
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Column(
            children: [
              Column(
                children: [
                  Stack(children: [
                    Container(
                      padding: const EdgeInsets.only(
                          top: 10, bottom: 10, left: 8, right: 20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(width: 5, color: Colors.white),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black12,
                                blurRadius: 20,
                                offset: Offset(5, 5))
                          ]),
                      child: Icon(
                        FontAwesomeIcons.users,
                        size: 70,
                        color: Colors.blue.shade800,
                      ),
                    
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(70, 70, 0, 0),
                        child: Tooltip(
                          message: "Create New Team",
                          waitDuration: Duration(milliseconds: 500),
                          child: IconButton(onPressed: (){
                            Get.to(()=>CreateTeam());
                          }, icon: Icon(Icons.add_circle,
                              color: Colors.grey.shade700, size: 30.0),),
                        ),
                      )
                  ]),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }



  _showUser(){
    return Expanded(
      child:  Obx((){
        return ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: _apiResponse.data!.length,
          itemBuilder: (_,index){
            print(_apiResponse.data!.length);
            return Container(
              child: UserWidget(),
            );
          }
        );
      })
    );
  }

}