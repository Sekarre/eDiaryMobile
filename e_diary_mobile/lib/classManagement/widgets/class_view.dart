import 'package:e_diary_mobile/model/message.dart';
import 'package:e_diary_mobile/model/school_class.dart';
import 'package:e_diary_mobile/model/student.dart';
import 'package:e_diary_mobile/shared/components/app_common.dart';
import 'package:e_diary_mobile/shared/components/error_popup.dart';
import 'package:e_diary_mobile/shared/components/no_data.dart';
import 'package:e_diary_mobile/shared/error_messages.dart';
import 'package:flutter/material.dart';

import '../class_management_service.dart';
import 'add_student.dart';
import 'classes_home.dart';

class ClassViewWidget extends StatelessWidget {

  final int schoolClassId;

  ClassViewWidget({Key? key, required this.schoolClassId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getClassView(schoolClassId),
        builder: (context, AsyncSnapshot<SchoolClass> snapshot) {
          if (snapshot.hasData) {
            return studentsListView(context, snapshot.requireData);
          } else {
            return NoDataWidget(NO_DATA_FOUND);
          }
        });
  }

  Future<bool> deleteStudent(Student student, int schoolClassId) async {

    var result = await deleteStudentFromClass(student, schoolClassId);

    return result;
  }

  Container studentsListView(BuildContext context, SchoolClass schoolClass) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: buildBoxDecoration(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        appBar: buildAppBar(schoolClass.name),
        body: ListView.separated(
          itemCount: schoolClass.students!.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: const Icon(Icons.person,color: Colors.white, size: 30.0),
              trailing:
                    IconButton(icon: Icon(Icons.close), color: Colors.red, onPressed: () async {
                      var result = await deleteStudent(schoolClass.students![index], schoolClass.id!);
                      if (result == true) {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ClassViewWidget(schoolClassId: schoolClass.id!)
                            )
                        );
                      } else if (result == false) {
                        openPopup(context, 'Error while deleting student', 'Try later');
                      }},),
              title: _name('${schoolClass.students![index].userName}',
                  const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.white)),
              dense: true,
              onTap: () => null,
            );
          },
          separatorBuilder: (context, index) {
            return const Divider(color: Color(0xFF2E7D32), thickness: 1, indent: 10, endIndent: 10,);
          },
        ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerTop,
          floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
          floatingActionButton: FloatingActionButton(
            mini: true,
            child: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddStudentWidget(schoolClassId: schoolClass.id)
                  )
              );
            },
            backgroundColor: const Color(0xFF2E7D32), hoverElevation: 1.5, elevation: 1.5,
            shape: StadiumBorder(
                side: BorderSide(
                    color: Color(0xFF212121), width: 5)),
          )
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


}

