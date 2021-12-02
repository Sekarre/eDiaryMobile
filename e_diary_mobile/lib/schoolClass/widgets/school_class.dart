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

import '../school_class_service.dart';

class SchoolClassWidget extends StatefulWidget {
  SchoolClassWidget({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SchoolClassWidget();
}

class _SchoolClassWidget extends State<SchoolClassWidget> {
  int _activeStepIndex = 0;
  late List<Teacher> teachers;
  int _chosenTeacherId = -1;
  int groupFormTutor = 0;

  TextEditingController formTutorController = TextEditingController();
  TextEditingController classNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getUnassignedTeachers(),
        builder: (context, AsyncSnapshot<List<Teacher>> snapshot) {
          if (snapshot.hasData) {
            teachers = snapshot.data!;
            return teachersListView(context, snapshot.requireData);
          } else {
            return NoDataWidget(NO_TEACHERS);
          }
        });
  }

  Container teachersListView(BuildContext context, List<Teacher> teachers) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: buildBoxDecoration(),
      child: Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      appBar: buildAppBar("Create class"),
      body: Stepper(
        type: StepperType.vertical,
        currentStep: _activeStepIndex,
        steps: stepList(),
        onStepContinue: () {
          if (_activeStepIndex < (stepList().length - 1)) {
            setState(() {
              _activeStepIndex += 1;
            });
          } else {
            onCreateClass();
          }
        },
        onStepCancel: () {
          if (_activeStepIndex == 0) {
            return;
          }

          setState(() {
            _activeStepIndex -= 1;
          });
        },
        onStepTapped: (int index) {
          setState(() {
            _activeStepIndex = index;
          });
        },
        controlsBuilder: (context, {onStepContinue, onStepCancel}) {
          final isLastStep = _activeStepIndex == stepList().length - 1;
          return Container(
            padding: EdgeInsets.symmetric(vertical:25.0),
            width: double.infinity,
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: onStepContinue,
                    child: (isLastStep)
                        ? const Text('Create')
                        : const Text('Next'),
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFF2E7D32),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                if (_activeStepIndex > 0)
                  Expanded(
                    child: ElevatedButton(
                      onPressed: onStepCancel,
                      child: const Text('Back'),
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xFF2E7D32),
                      ),
                    ),
                  )
              ],
            ),
          );
        },
      ),
      ),
    );
  }

  List<Step> stepList() => [
    Step(
      state: _activeStepIndex <= 0 ? StepState.editing : StepState.complete,
      isActive: _activeStepIndex >= 0,
      title: const Text('Form Tutor', style: TextStyle(color: Colors.white)),
      content: Column(
        children: <Widget>[
          ListView.builder(
            shrinkWrap: true,
            itemCount: teachers.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text('${teachers[index].name}', style: TextStyle(color: Colors.white)),
                leading: Icon(Icons.person, color: Colors.white, size: 30,),
                onTap: () => {
                  setState(() {
                    _chosenTeacherId = teachers[index].id;
                    formTutorController.text = teachers[index].name;
                    _activeStepIndex += 1;
                  }),
                },
              );
            },
          ),
        ],
      ),
    ),
    Step(
        state:
        _activeStepIndex <= 1 ? StepState.editing : StepState.complete,
        isActive: _activeStepIndex >= 1,
        title: const Text('Class', style: TextStyle(color: Colors.white)),
        content: Container(
          child: Column(
            children: [
              const SizedBox(
                height: 8,
              ),
              TextField(
                style: TextStyle(color: Colors.white),
                enabled: false,
                controller: formTutorController,
                decoration: const InputDecoration(
                  disabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF2E7D32), width: 2.0),
                  ),
                  border: OutlineInputBorder(),
                  labelText: "Form tutor",
                  labelStyle: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              TextField(
                style: TextStyle(color: Colors.white),
                cursorColor: Color(0xFF2E7D32),
                controller: classNameController,
                decoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF2E7D32), width: 2.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF2E7D32), width: 2.0),
                  ),
                  border: OutlineInputBorder(),
                  labelText: 'Class name',
                  labelStyle: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        )),
    Step(
        state: StepState.complete,
        isActive: _activeStepIndex >= 2,
        title: const Text('Confirm', style: TextStyle(color: Colors.white)),
        content: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('Form Tutor : ${formTutorController.text}',
                    style: TextStyle(color: Colors.white, fontSize: 20)),
                Text('Class name : ${classNameController.text}',
                    style: TextStyle(color: Colors.white, fontSize: 20)),
              ],
            )))
  ];

  onCreateClass() async {
    if ((_chosenTeacherId == null || _chosenTeacherId < 0) || formTutorController.text.isEmpty) {
      openPopup(context, ERROR_OCCURED, NO_FORM_TUTOR_SELECTED);
    } else if (classNameController.text.isEmpty) {
      openPopup(context, ERROR_OCCURED, CLASSNAME_EMPTY);
    } else if (classNameController.text.length < 2) {
      openPopup(context, ERROR_OCCURED, CLASSNAME_LESS_THAN_2);
    }

    var response = await createClassWithFormTutorAndClassName(SchoolClass.builder(classNameController.text, _chosenTeacherId));

    if (response.statusCode == 200) {
      _openPopupOnCreatedClass();
    } else if (response.statusCode == 400) {
      openPopup(context, ERROR_OCCURED, 'Could not create the class. \n${response.body}');
    } else {
      openPopup(context, ERROR_OCCURED, 'Could not create the class. \nTry again later');
    }

  }

  _openPopupOnCreatedClass() {
    Alert(
        context: context,
        title: 'Success',
        style: AlertStyle(titleStyle: TextStyle(color: Colors.green)),
        content: Column(
          children: <Widget>[
            Text("Class has been created", style: const TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold)),
          ],
        ),
        buttons: [
          DialogButton(
            onPressed: () async {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePage(),
                  )
              );
            },
            child: const Text(
              "Ok",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ]).show();
  }

}
