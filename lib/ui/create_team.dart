import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager_app/models/team.dart';
import 'package:task_manager_app/services/teams_service.dart';
import 'package:task_manager_app/ui/common/drawer_item.dart';
import 'package:task_manager_app/ui/common/drawer_item_data.dart';
import 'package:task_manager_app/ui/team_page.dart';
import 'package:task_manager_app/ui/theme.dart';
import 'package:task_manager_app/ui/widgets/button.dart';
import 'package:task_manager_app/ui/widgets/drawer_widget.dart';
import 'package:task_manager_app/ui/widgets/header_widget.dart';
import 'package:task_manager_app/ui/widgets/input_field.dart';

class CreateTeam extends StatefulWidget {
  const CreateTeam({Key? key}) : super(key: key);

  @override
  _CreateTeamState createState() => _CreateTeamState();
}

class _CreateTeamState extends State<CreateTeam> {
  var _scaffoldKey = GlobalKey<ScaffoldState>();
  DrawerItem item = DrawerItems.home;

  TeamsService get service => GetIt.I<TeamsService>();

  TextEditingController teamNameController = TextEditingController();
  String userId ="";

  Future user()async{
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var id = sharedPreferences.getString('id');

    setState(() {
      userId = id!;
      print(userId);
    });
  }

  @override
  void initState() {
    user();

    super.initState();
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
           Container(
             margin: const EdgeInsets.only(left: 20,right: 20),
             child: SingleChildScrollView(
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 
                 children: [
                   MyInputField(title: "Team Name", hint: "Enter the team name",controller: teamNameController,),
                 ],
               ),
             ),
           ),
           SizedBox(height: 20,),
           MyButton(label: "Create Team", onTap: (){
             _validateData();
           })
          ],
        ));
  }

  _appBar(BuildContext context) {
    return AppBar(
      leading: GestureDetector(
        onTap: () {
          _scaffoldKey.currentState?.openDrawer();
        },
        child: Icon(FontAwesomeIcons.bars, size: 20),
      ),
    );
  }

  Widget buildDrawer() => SafeArea(child: DrawerWidget(
        onSelectedItem: (item) {
          setState(() {
            this.item = item;
            print(item);
          });
        },
      ));


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
            margin: const EdgeInsets.only(top:30),
            alignment: Alignment.center,
            child: Text("Create New Team",style: headingStyle,),
          ),
       ],
    );
  }

  _validateData(){
    if(teamNameController.text.isNotEmpty){
      _addTeam();
      
    }else if(teamNameController.text.isEmpty){
      Get.snackbar("Required", "All fields are required !",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.white,
          colorText: Colors.red,
          icon: Icon(Icons.warning_amber_rounded));
    }
    }
  

  _addTeam()async{
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var id = sharedPreferences.get('id');

    final team = Team(
      name: teamNameController.text,
      createdBy: int.parse(id.toString())
    );

    final result = await service.createTeam(team);
    print("data");
    

  }

}
      

 


class Int {
}
