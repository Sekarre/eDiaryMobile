import 'package:e_diary_mobile/classManagement/class_management_service.dart';
import 'package:e_diary_mobile/home/home.dart';
import 'package:e_diary_mobile/model/school_class.dart';
import 'package:e_diary_mobile/model/teacher.dart';
import 'package:e_diary_mobile/shared/components/app_common.dart';
import 'package:e_diary_mobile/shared/components/error_popup.dart';
import 'package:e_diary_mobile/shared/components/no_data.dart';
import 'package:e_diary_mobile/shared/error_messages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../class_management_service.dart';
import 'change_teacher.dart';
import 'class_view.dart';

class ClassesWidget extends StatelessWidget {

  const ClassesWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getSchoolClasses(),
        builder: (context, AsyncSnapshot<List<SchoolClass>> snapshot) {
          if (snapshot.hasData) {
            return classesListView(context, snapshot.requireData);
          } else {
            return NoDataWidget(NO_CLASSES);
          }
        });
  }

  Future<bool> deleteClass(SchoolClass schoolClass) async {
    var result = await deleteSchoolClass(schoolClass);
    return result;
  }

  Container classesListView(BuildContext context, List<SchoolClass> schoolClass) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: buildBoxDecoration(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        appBar: buildAppBar("Manage Class"),
        body: ListView.separated(
          itemCount: schoolClass.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: const Icon(Icons.group,color: Colors.white, size: 30.0),
              trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(icon: Icon(Icons.close), color: Colors.red, onPressed: () async {
                      var result = await deleteClass(schoolClass[index]);
                      if (result == true) {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ClassesWidget()
                            )
                        );
                      } else if (result == false) {
                        openPopup(context, 'Error while deleting class', 'Try later');
                      }},),
                    IconButton(icon: Icon(Icons.compare_arrows), color: Colors.green, onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ChangeTeacherWidget(schoolClassId: schoolClass[index].id)
                          )
                      );
                      },),
                  ]
              ),
              title: _name('${schoolClass[index].name}',
                  const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.white)),
              subtitle: _Content('${schoolClass[index].teacherName}',
                  '${schoolClass[index].students!.length}'),
              dense: true,
              onTap: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  ClassViewWidget(schoolClassId: schoolClass[index].id!)),
                ),
              },
            );
          },
          separatorBuilder: (context, index) {
            return const Divider(color: Color(0xFF2E7D32), thickness: 2, indent: 10, endIndent: 10,);
          },
        ),
      ),
    );
  }

  Widget _name(String name, TextStyle style) {
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 5.0, 0, 5.0),
      child: Text(
        name,
        style: style,
      ),
    );
  }

  Widget _Content(String formTutor, String students) {
    var textStyle = TextStyle(fontSize: 15.0, fontStyle: FontStyle.italic, letterSpacing: 1, color: Colors.white);

    return Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget> [
            Text('Form Tutor: ' + formTutor,
              style: textStyle,
            ),
            Text('Number of students: ' + students,
              style: textStyle,
            ),
          ],
        )
    );
  }

}