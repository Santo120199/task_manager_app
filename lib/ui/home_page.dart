import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager_app/models/api_response.dart';
import 'package:task_manager_app/models/task.dart';
import 'package:task_manager_app/services/tasks_service.dart';
import 'package:task_manager_app/ui/add_task_bar.dart';
import 'package:task_manager_app/ui/profile_page.dart';
import 'package:task_manager_app/ui/theme.dart';
import 'package:task_manager_app/ui/widgets/button.dart';
import 'package:task_manager_app/ui/widgets/drawer_widget.dart';
import 'package:task_manager_app/ui/widgets/task_tile.dart';

import 'common/drawer_item.dart';
import 'common/drawer_item_data.dart';

class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  DateTime _selectedDate = DateTime.now();
 
 
  var _scaffoldKey = GlobalKey<ScaffoldState>();

  DrawerItem item = DrawerItems.home;



  TasksService get service => GetIt.I<TasksService>();

  late APIResponse<List<Task>> _apiResponse;
  bool _isLoading = false;


  @override
  void initState() {
    // TODO: implement initState
    _fetchTasks();
    _showTasks();
    super.initState();
  }

  _fetchTasks()async{
    setState(() {
      _isLoading = true;
    });
      
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var userId = sharedPreferences.getString('id');
    _apiResponse = await service.getTasksList(userId!);
    print(_apiResponse.data);
    print(DateFormat.yMd().format(_selectedDate));
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
      body: RefreshIndicator(
        onRefresh: ()async{
          await _fetchTasks();

        },
        child: Column(
          children: [
            _addTaskBar(),
            _addDateBar(),
            SizedBox(height: 10,),
            _showTasks(),
          ],
        ),
      )
    );
  }

  Widget buildDrawer()=> SafeArea(
    child: DrawerWidget(
      onSelectedItem: (item){
        setState(() {
          this.item = item;
          
        });
      },
    
    ));

  _addDateBar(){
    return Container(
      margin: const EdgeInsets.only(top: 20, left: 20),
      child: DatePicker(
        DateTime.now(),
        height: 100,
        width: 80,
        initialSelectedDate: DateTime.now(),
        selectionColor: Colors.blue,
        selectedTextColor: Colors.white,
        dateTextStyle: GoogleFonts.lato(
          textStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.grey,
          ),
        ),
        dayTextStyle: GoogleFonts.lato(
          textStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.grey,
          ),
        ),
        monthTextStyle: GoogleFonts.lato(
          textStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.grey,
          ),
        ),
        onDateChange: (date) {

          setState(() {
            _selectedDate = date;
          });
        },
      ),
    );
  }


  _addTaskBar(){
    return Container(
            margin: const EdgeInsets.only(left: 20,right: 20,top:10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                     Text(DateFormat.yMMMMd().format(DateTime.now()),
                      style: subHeadingStyle
                     ),
                     Text("Today",
                      style: headingStyle,
                     )
                    ],
                  ),
                ),
                MyButton(label: "+ Add Task", onTap:()async{
                    await Get.to(()=>AddTaskPage());
                    _fetchTasks();
                  },
                )
              ],
            ),
          );
  }

  _appBar(BuildContext context){
    return AppBar(
      leading: GestureDetector(
        onTap:(){
          _scaffoldKey.currentState?.openDrawer();
        },
        child: Icon(Icons.person,size:20),
      ),
      
    );
  }

  _showTasks(){
      return Builder(
          builder: (_){
            if(_isLoading){
              return CircularProgressIndicator();
            }
            if(_apiResponse.error){
              return Center(child: Text(_apiResponse.errorMessage.toString()));
            }
            
            return Expanded(
              child: Obx((){
                return ListView.builder(
                itemCount: _apiResponse.data!.length,
                itemBuilder: (_, index) {
                  print(_apiResponse.data!.length);
                  Task task = _apiResponse.data![index];
                  if(task.date == DateFormat.yMd().format(_selectedDate)){        //DATE FORMAT: 2/15/2022
                    return AnimationConfiguration.staggeredList(
                    position: index, 
                    child: SlideAnimation(
                      child: FadeInAnimation(
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: ()async{
                                _showBottomSheet(context, task);
                              },
                              child: TaskTile(task)
                            )
                          ],
                        )
                      ),
                    )
                  );
                } else {
                  return Container();
                 /* return AnimationConfiguration.staggeredList(
                    position: index, 
                    child: SlideAnimation(
                      child: FadeInAnimation(
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: ()async{
                                _showBottomSheet(context, task);
                              },
                              child: TaskTile(task)
                            )
                          ],
                        )
                      ),
                    )
                  ); */
                }
                
                });
              }),
            );
          },
        );
    }

  _showBottomSheet(BuildContext context, Task task) {
    Get.bottomSheet(
      Container(
          padding: const EdgeInsets.only(top: 4),
          height: task.isCompleted == 1
              ? MediaQuery.of(context).size.height * 0.24
              : MediaQuery.of(context).size.height * 0.32,
          color: Colors.white,
          child: Column(
            children: [
              Container(
                height: 6,
                width: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[300],
                ),
              ),
              Spacer(),
              task.isCompleted == 1?
              Container():
              _bottomSheetButton(
                label: "Task Completed", 
                onTap: ()async{
                  
                  final result = await service.completeTask(task.id.toString(), 1.toString());
                  _fetchTasks();
                  Get.back();
                }, 
                clr: Colors.blue,
                context: context
              ),
              _bottomSheetButton(
                label: "Delete Task", 
                onTap: ()async{
                  final result = await service.deleteTask(task.id.toString());
                  _fetchTasks();
                  Get.back();
                }, 
                clr: Colors.red[300]!,
                context: context
              ),
              SizedBox(height: 20,),
              _bottomSheetButton(
                label: "Close", 
                onTap: (){
                  Get.back();
                }, 
                clr: Colors.white,
                isClose : true,
                context: context
              ),
              SizedBox(height: 10,),
            ],
          )),
    );
  }

  _bottomSheetButton({
    required String label,
    required Function()? onTap,
    required Color clr,
    bool isClose = false,
    required BuildContext context
  }){
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        height: 55,
        width: MediaQuery.of(context).size.width*0.9,
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: isClose == true ? Colors.grey[300]!:clr,
          ),
          borderRadius: BorderRadius.circular(20),
          color: isClose == true ? Colors.transparent:clr,
        ),
        child: Center(
          child: Text(
            label,
            style: isClose ? titleStyle.copyWith(color: Colors.black) : titleStyle.copyWith(color: Colors.white)
          ),
        )
      ),
    );
  }
  
}