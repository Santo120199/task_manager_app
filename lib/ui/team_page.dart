import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:task_manager_app/ui/common/drawer_item.dart';
import 'package:task_manager_app/ui/common/drawer_item_data.dart';
import 'package:task_manager_app/ui/theme.dart';
import 'package:task_manager_app/ui/widgets/drawer_widget.dart';

class TeamPage extends StatefulWidget {
  const TeamPage({ Key? key }) : super(key: key);

  @override
  _TeamPageState createState() => _TeamPageState();
}

class _TeamPageState extends State<TeamPage> {

  var _scaffoldKey = GlobalKey<ScaffoldState>();

   DrawerItem item = DrawerItems.home;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: _appBar(context),
      drawer: buildDrawer(),
      body: Container(
        margin: const EdgeInsets.only(top: 20),
        alignment: Alignment.topCenter,
        child: Text('Team Member',style: headingStyle),
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

}