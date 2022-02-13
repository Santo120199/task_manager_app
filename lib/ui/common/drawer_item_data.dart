import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:task_manager_app/ui/common/drawer_item.dart';

class DrawerItems {
  static const home = DrawerItem(title: 'Home', icon: FontAwesomeIcons.home);
  static const user = DrawerItem(title: 'Profile', icon: FontAwesomeIcons.solidUser);


  static final List<DrawerItem> all = [
    home,
    user,
  ];
  
}