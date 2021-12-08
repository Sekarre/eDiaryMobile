import 'package:e_diary_mobile/model/report_request.dart';
import 'package:e_diary_mobile/model/teacher.dart';
import 'package:e_diary_mobile/reports/report_service.dart';
import 'package:e_diary_mobile/shared/components/app_common.dart';
import 'package:e_diary_mobile/shared/components/error_popup.dart';
import 'package:e_diary_mobile/shared/components/no_data.dart';
import 'package:e_diary_mobile/shared/error_messages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';

class TeacherReportWidget extends StatefulWidget {

  TeacherReportWidget({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TeacherReportWidget();
}

class _TeacherReportWidget extends State<TeacherReportWidget> {

  _TeacherReportWidget();

  final TextEditingController _startTimeController = TextEditingController();
  final TextEditingController _endTimeController = TextEditingController();
  final TextEditingController _teachersController = TextEditingController();

  final List<int> _teachersId = [];
  List<DropdownMenuItem<Teacher>> _dropdownItems = [];
  List<Teacher> teachers = [];

  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();
  DateFormat formatter = DateFormat('dd/MM/yyyy');

  @override
  void initState() {
    super.initState();
    _loadTeachers();
  }

  void _onSelectNotification(String path) async {
    showDialog(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text('Success'),
        content: Text('Report downloaded'),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            child: Text('Open'),
            onPressed: () async {
              OpenFile.open(path);
              Navigator.of(context, rootNavigator: true).pop();
            },
          )
        ],
      ),
    );
  }

  _loadTeachers() async {
    var result = await getAllTeachers();
    setState(() {
      teachers = result;
      _dropdownItems = _mapTeachersToDropdownItems();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_dropdownItems.isNotEmpty) {
      return newTeacherReport(context);
    } else {
      return NoDataWidget(NEW_MESSAGE_ERROR);
    }
  }

  _selectStartDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: startDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2025),
    );
    if (picked != null) {
      setState(() {
        startDate = picked;
        _startTimeController.text = formatter.format(picked);
      });
    }
  }

  _selectEndDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: endDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2022),
    );
    if (picked != null) {
      setState(() {
        endDate = picked;
        _endTimeController.text = formatter.format(picked);
      });
    }
  }

  Container newTeacherReport(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: buildBoxDecoration(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: buildAppBar("Teacher report"),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 20,
              ),
              ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    SizedBox( child: RaisedButton(
                      elevation: 5.0,
                      onPressed: () => _selectStartDate(context),
                      padding: EdgeInsets.all(10.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      color: Color(0xFF2E7D32),
                      child: Text(
                        'Select start date',
                        style: TextStyle(
                          color: Colors.white,
                          letterSpacing: 1.5,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),),
                    SizedBox( child: RaisedButton(
                      elevation: 5.0,
                      onPressed: () => _selectEndDate(context),
                      padding: EdgeInsets.all(10.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      color: Color(0xFF2E7D32),
                      child: Text(
                        'Select end date',
                        style: TextStyle(
                          color: Colors.white,
                          letterSpacing: 1.5,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),),
                  ],
                ),
              ),


              const SizedBox(
                height: 20,
              ),
              TextField(
                style: TextStyle(color: Colors.white),
                controller: _startTimeController,
                readOnly: true,
                maxLines: null,
                decoration: InputDecoration(
                  disabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF2E7D32), width: 2.0),
                  ),
                  enabled: false,
                  labelText: 'Date from',
                  labelStyle: TextStyle(color: Colors.white),
                  suffixIcon: IconButton(
                    onPressed: () {
                      _resetDropdown();
                    },
                    icon: Icon(Icons.clear,color: Color(0xFF2E7D32),),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                style: TextStyle(color: Colors.white),
                controller: _endTimeController,
                readOnly: true,
                maxLines: null,
                decoration: InputDecoration(
                  disabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF2E7D32), width: 2.0),
                  ),
                  enabled: false,
                  labelText: 'Date to',
                  labelStyle: TextStyle(color: Colors.white),
                  suffixIcon: IconButton(
                    onPressed: () {
                      _resetDropdown();
                    },
                    icon: Icon(Icons.clear,color: Color(0xFF2E7D32),),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: _teachersController,
                readOnly: true,
                maxLines: null,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF2E7D32), width: 2.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF2E7D32), width: 2.0),
                  ),
                  enabled: true,
                  labelText: 'Teachers',
                  labelStyle: TextStyle(color: Colors.white),
                  suffixIcon: IconButton(
                    onPressed: () {
                      _resetDropdown();
                    },
                    icon: Icon(Icons.clear,color: Color(0xFF2E7D32),),
                  ),
                ),
              ),
              DropdownButton<Teacher>(
                hint: Text('From: ', style: TextStyle(color: Colors.white)),
                value: null,
                icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
                iconSize: 24,
                elevation: 16,
                dropdownColor: Color(0xFF424242),
                style: const TextStyle(color: Colors.white, fontSize: 20),
                underline: Container(
                  height: 2,
                  color: Color(0xFF2E7D32),
                ),
                onChanged: (Teacher? teacher) {
                  addTeacher(teacher);
                  removeTeacherFromDropdownList(teachers, teacher!.id);
                },
                items: _dropdownItems,
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical:25.0),
                width: 150,
                child: RaisedButton(
                  elevation: 5.0,
                  onPressed: () async {
                    var path = await createAndGenerateReport();
                    if (path != null) {
                      _onSelectNotification(path);
                    } else {
                      openPopup(context, 'Error while generating report',
                          'Try later');
                    }
                  },
                  padding: EdgeInsets.all(10.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  color: Color(0xFF2E7D32),
                  child: Text(
                    'Generate',
                    style: TextStyle(
                      color: Colors.white,
                      letterSpacing: 1.5,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _resetDropdown() {
    _teachersController.clear();
    _teachersId.clear();
    setState(() {
      _dropdownItems = _mapTeachersToDropdownItems();
    });
  }

  List<DropdownMenuItem<Teacher>> _mapTeachersToDropdownItems() {
    return teachers.map<DropdownMenuItem<Teacher>>((Teacher teacher) {
      return DropdownMenuItem<Teacher>(
        value: teacher,
        child: Text(teacher.name),
      );
    }).toList();
  }

  Future<String?> createAndGenerateReport() async {
    var startTime = _startTimeController.text;
    var endTime = _endTimeController.text;

    ReportRequest request = ReportRequest(startTime, endTime, _teachersId);

    var result = await generateTeachersReport(request);
    _clearText();

    return result;
  }

  addTeacher(Teacher? teacher) {
    _teachersId.add(teacher!.id);
    _teachersController.text = _teachersController.text + teacher.name + ", ";
  }

  removeTeacherFromDropdownList(List<Teacher> teacher, int teacherId) {
    setState(() {
      _dropdownItems.removeWhere((elem) => elem.value!.id == teacherId);
    });
  }

  _clearText() {
    _startTimeController.text = '';
    _endTimeController.text = '';
    _resetDropdown();
  }
}
