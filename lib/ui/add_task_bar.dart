// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:task_manager_app/models/task.dart';
import 'package:task_manager_app/services/tasks_service.dart';
import 'package:task_manager_app/ui/theme.dart';
import 'package:task_manager_app/ui/widgets/button.dart';
import 'package:task_manager_app/ui/widgets/input_field.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({ Key? key }) : super(key: key);

  @override
  _AddTaskPageState createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  TasksService get service => GetIt.I<TasksService>();

  DateTime _selectedDate = DateTime.now();
  String _startTime = DateFormat("hh:mm a").format(DateTime.now()).toString();
  String _endTime = "9:30 PM";
  int _selectedRemind = 5;
  List<int> remindList=[
    5,10,15,20,
  ];
  String _selectedRepeat = "None";
  List<String> repeatList=[
    "None",
    "Daily",
    "Weekly",
    "Monthly",
  ];
  int _selectedColor = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: Container(
        padding: const EdgeInsets.only(left: 20,right:20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Add Task',
                style: headingStyle,
              ),
              MyInputField(title: "Title", hint: "Enter your title",controller: _titleController,),
              MyInputField(title: "Note", hint: "Enter your note",controller: _noteController,),
              MyInputField(title: "Date", hint: DateFormat.yMd().format(_selectedDate),
              widget: IconButton(
                // ignore: prefer_const_constructors
                icon: Icon(Icons.calendar_today_outlined,
                  color: Colors.grey,
                ),
                onPressed: (){
                  _getDateFromUser();
                },
              ),),
              Row(
                children: [
                  Expanded(
                    child: MyInputField(
                      title: "Start Date", 
                      hint:  _startTime,
                      widget: IconButton(
                        onPressed: (){
                          _getTimeFromUser(isStartTime: true);
                        },
                        icon: Icon(Icons.access_time_rounded, color: Colors.grey)
                      )
                      ),
                  ),
                  SizedBox(width:12),
                  Expanded(
                      child: MyInputField(
                        title: "End Date", 
                        hint:  _endTime,
                        widget: IconButton(
                          onPressed: (){
                            _getTimeFromUser(isStartTime: false);
                          },
                          icon: Icon(Icons.access_time_rounded, color: Colors.grey)
                        )
                        ),
                    )
                
                ],
              ),
              MyInputField(title: "Remind", hint: "$_selectedRemind minutes early",
                widget: DropdownButton(
                  icon: Icon(Icons.keyboard_arrow_down,
                    color: Colors.grey,
                  ),
                  iconSize: 32,
                  elevation: 4,
                  style: subTitleStyle,
                  underline: Container(height: 0,),
                  items: remindList.map<DropdownMenuItem<String>>((int value){
                    return DropdownMenuItem<String>(
                      value: value.toString(),
                      child: Text(value.toString()),
                    );
                  }).toList(), 
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedRemind = int.parse(newValue!);
                    });
                  },
                ),
              ),
              MyInputField(title: "Repeat", hint: "$_selectedRepeat",
                  widget: DropdownButton(
                    icon: Icon(Icons.keyboard_arrow_down,
                      color: Colors.grey,
                    ),
                    iconSize: 32,
                    elevation: 4,
                    style: subTitleStyle,
                    underline: Container(height: 0,),
                    items:repeatList.map<DropdownMenuItem<String>>((String? value){
                      return DropdownMenuItem<String>(
                        value: value.toString(),
                        child: Text(value!,style: TextStyle(color:Colors.grey),),
                      );
                    }).toList(), 
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedRepeat = newValue!;
                      });
                    },
                  ),
                ),
              SizedBox(height: 18,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                 _colorPalette(),
                 MyButton(label: "Create Task", onTap: ()=>_validateData())
                ],
              )
            ],
          ),
        ),
      ),

    );
  }


  _appBar(){
    return AppBar(
      leading: GestureDetector(
        onTap:(){
          Get.back();
        },
        child: Icon(Icons.arrow_back,size:20),
      ),
      actions: [
          Icon(Icons.person,size:20),
          SizedBox(width: 20,)
        ],
    );
  }

  _getDateFromUser()async{
    DateTime? _pickerDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(), 
      firstDate: DateTime(2015), 
      lastDate: DateTime(2030)
      );

      if(_pickerDate!= null){
        setState(() {
          _selectedDate = _pickerDate;
          print(_selectedDate);
        });
      }else {
        print("Something goes wrong");
      }

  }

  _getTimeFromUser({required bool isStartTime}) async{
    var pickedTime = await _showTimePicker();
    String _formattedTime = pickedTime.format(context);
    if(pickedTime == null){
      print("Time canceld");
    }else if(isStartTime == true){
      setState(() {
        _startTime = _formattedTime;
      });
    }else if(isStartTime == false){
      setState(() {
        _endTime = _formattedTime;
      });
    }
  }

  _showTimePicker(){
    return showTimePicker(
      initialEntryMode: TimePickerEntryMode.input,
      context: context, 
      initialTime: TimeOfDay(
        //_startTime --> 10:30 AM
        hour: int.parse(_startTime.split(":")[0]), 
        minute: int.parse(_startTime.split(":")[1].split(" ")[0]),
      )
    );
  }

  _colorPalette() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Color',
          style: titleStyle,
        ),
        SizedBox(height: 8.0),
        Wrap(
          children: List<Widget>.generate(3, (int index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedColor = index;
                });
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: CircleAvatar(
                  radius: 14,
                  backgroundColor: index == 0
                      ? Colors.blue
                      : index == 1
                          ? Colors.pink
                          : Colors.yellow,
                  child: _selectedColor == index
                      ? Icon(
                          Icons.done,
                          color: Colors.white,
                          size: 16,
                        )
                      : Container(),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }

  _validateData(){
    if(_titleController.text.isNotEmpty && _noteController.text.isNotEmpty){
      _addTask();
      Get.back();
    }else if(_titleController.text.isEmpty || _noteController.text.isEmpty){
      Get.snackbar("Required", "All fields are required !",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.white,
        colorText: Colors.red,
        icon: Icon(Icons.warning_amber_rounded)
      );

    }
  }

  _addTask()async{
   final task =  Task(
      note: _noteController.text,
      title: _titleController.text,
      date: DateFormat.yMd().format(_selectedDate),
      startTime: _startTime,
      endTime: _endTime,
      remind: _selectedRemind
    );
    final result = await service.createTask(task);
    print("added");
  
  }
}