import 'package:e_diary_mobile/model/message.dart';
import 'package:e_diary_mobile/model/school_class.dart';
import 'package:e_diary_mobile/model/student.dart';
import 'package:e_diary_mobile/model/teacher.dart';
import 'package:e_diary_mobile/shared/components/app_common.dart';
import 'package:e_diary_mobile/shared/components/error_popup.dart';
import 'package:e_diary_mobile/shared/components/no_data.dart';
import 'package:e_diary_mobile/shared/error_messages.dart';
import 'package:flutter/material.dart';

import '../class_management_service.dart';
import 'class_view.dart';
import 'classes_home.dart';

class ChangeTeacherWidget extends StatelessWidget {
  var schoolClassId;


  ChangeTeacherWidget({Key? key, required this.schoolClassId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getUnassignedTeachers(),
        builder: (context, AsyncSnapshot<List<Teacher>> snapshot) {
          print(snapshot.toString());
          if (snapshot.hasData) {
            return unassignedTeachersListView(context, snapshot.requireData);
          } else {
            return NoDataWidget(NO_DATA_FOUND);
          }
        });
  }

  Future<bool> changeTeacher(Teacher teacher) async {

    var result = await changeClassFormTutor(teacher, schoolClassId);

    return result;
  }

  Container unassignedTeachersListView(BuildContext context, List<Teacher> teacher) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: buildBoxDecoration(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        appBar: buildAppBar("Add students"),
        body: ListView.separated(
          itemCount: teacher.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: const Icon(Icons.person_outlined,color: Colors.white, size: 30.0),
              trailing:
              IconButton(icon: Icon(Icons.compare_arrows), color: Color(0xFF2E7D32), onPressed: () async {
                var result = await changeTeacher(teacher[index]);
                if (result == true) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ClassesWidget()
                      )
                  );
                } else if (result == false) {
                  openPopup(context, 'Error while adding student', 'Try later');
                }},),
              title: _name('${teacher[index].name}',
                  const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.white)),
              dense: true,
              onTap: () => null,
            );
          },
          separatorBuilder: (context, index) {
            return const Divider(color: Color(0xFF2E7D32), thickness: 1, indent: 10, endIndent: 10,);
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


}