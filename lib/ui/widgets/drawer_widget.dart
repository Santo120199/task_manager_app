import 'package:flutter/material.dart';
import 'package:task_manager_app/ui/common/drawer_item.dart';
import 'package:task_manager_app/ui/common/drawer_item_data.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({ Key? key, required this.onSelectedItem }) : super(key: key);

  final ValueChanged<DrawerItem> onSelectedItem;

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: [0.0,1.0],
              colors: [Colors.blue.withOpacity(0.6),Colors.blue[200]!.withOpacity(1)]
            )
          ),
          child: Column(
            children: DrawerItems.all.map((item)=>ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 24,vertical: 8),
              leading: Icon(item.icon,color:Colors.black),
              title: Text(item.title,style: TextStyle(color:Colors.white,fontSize: 20)),
            )).toList(),
          ),
        )
      );
  }

  Widget buildDrawerItems(BuildContext context)=> Column(
    children: DrawerItems.all.map((item)=>ListTile(
      leading: Icon(item.icon,color: Colors.white),
      title: Text(item.title,style: TextStyle(color:Colors.white, fontSize: 18)),
      onTap: ()=>onSelectedItem(item),
    )).toList(),
  );
}