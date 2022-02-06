import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:task_manager_app/models/api_response.dart';
import 'package:task_manager_app/models/task.dart';
import 'package:task_manager_app/services/tasks_service.dart';
import 'package:task_manager_app/ui/add_task_bar.dart';
import 'package:task_manager_app/ui/theme.dart';
import 'package:task_manager_app/ui/widgets/button.dart';

class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  DateTime _selectedDate = DateTime.now(); 

  TasksService get service => GetIt.I<TasksService>();

  late APIResponse<List<Task>> _apiResponse;
  bool _isLoading = false;


  @override
  void initState() {
    // TODO: implement initState
    _fetchTasks();
    super.initState();
  }

  _fetchTasks()async{
    setState(() {
      _isLoading = true;
    });
    _apiResponse = await service.getTasksList();
    print(_apiResponse.data);
    setState(() {
      _isLoading = false;
    });

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: Column(
        children: [
          _addTaskBar(),
          _addDateBar(),
          _showTasks1(),
        ],
      )
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
            child: ListView.separated(
                shrinkWrap: true,
                separatorBuilder: (_, __) =>
                    Divider(height: 1, color: Colors.green),
                itemBuilder: (_, index) {
                  return Dismissible(
                    key: ValueKey(_apiResponse.data![index].id),
                    direction: DismissDirection.startToEnd,
                    onDismissed: (direction) {},
                    background: Container(
                      color: Colors.red,
                      padding: EdgeInsets.only(left: 16),
                      child: Align(
                        child: Icon(Icons.delete, color: Colors.white),
                        alignment: Alignment.centerLeft,
                      ),
                    ),
                    child: ListTile(
                      title: Text(
                       "ciao",
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      ),
                      subtitle: Text(
                          'Last edited on',
                    ),
                  ),
                  );
                },
                itemCount: _apiResponse.data!.length,
              ),
          );
        },
      );
  }


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
          _selectedDate = date;
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

  _appBar(){
    return AppBar(
      leading: GestureDetector(
        onTap:(){
          print("tapped");
        },
        child: Icon(Icons.nightlight_round,size:20),
      ),
      actions: [
          Icon(Icons.person,size:20),
          SizedBox(width: 20,)
        ],
    );
  }

  _showTasks1(){
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
                  itemBuilder: (_,context){
                    print(_apiResponse.data!.length);
                    return Container(
                      width: 100,
                      height: 50,
                      color: Colors.green,
                      margin: const EdgeInsets.only(bottom: 10),
                    );
                  });
              }),
            );
          },
        );
    }








}