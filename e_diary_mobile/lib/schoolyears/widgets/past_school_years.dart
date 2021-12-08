import 'package:e_diary_mobile/model/end_year_report.dart';
import 'package:e_diary_mobile/model/end_year_report_request.dart';
import 'package:e_diary_mobile/model/report_type.dart';
import 'package:e_diary_mobile/reports/report_service.dart';
import 'package:e_diary_mobile/schoolyears/widgets/grid_item.dart';
import 'package:e_diary_mobile/shared/app_common_styles.dart';
import 'package:e_diary_mobile/shared/components/app_common.dart';
import 'package:e_diary_mobile/shared/components/error_popup.dart';
import 'package:e_diary_mobile/shared/components/no_data.dart';
import 'package:e_diary_mobile/shared/error_messages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';

import '../school_year_service.dart';

class PastSchoolYearsWidget extends StatefulWidget {
  PastSchoolYearsWidget({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PastSchoolYearsWidget();
}

class _PastSchoolYearsWidget extends State<PastSchoolYearsWidget> {
  List<String> reportsYears = [];
  ReportType reportType = ReportType.STUDENT;
  List<EndYearReport> selectedList = [];
  List<EndYearReport> endYearReports = [];

  List<DropdownMenuItem<String>> _dropdownItems = [];
  int _selectedYear = DateTime.now().year;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _loadYears();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getPastSchoolYearsReports(reportType, _selectedYear),
        builder: (context, AsyncSnapshot<List<EndYearReport>> snapshot) {
          if (snapshot.hasData) {
            endYearReports = snapshot.requireData;
            return reportsListView(context, snapshot.requireData);
          } else {
            return NoDataWidget(NO_REPORTS);
          }
        });
  }

  Container reportsListView(BuildContext context, List<EndYearReport> reports) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: buildBoxDecoration(),
      child: Scaffold(
        bottomNavigationBar: selectedList.isNotEmpty
            ? buildDownloadBottomNavigationBard()
            : buildDefaultBottomNavigationBar(),
        backgroundColor: Colors.transparent,
        appBar: selectedList.isNotEmpty ? buildMultipleSelectionAppBar() : buildAppBar("Past school years"),
        body: ListView.separated(
          itemCount: reports.length,
          itemBuilder: (context, index) {
            return GridItem(
                endYearReport: reports[index],
                isSelected: (bool value) {
                  setState(() {
                    if (value) {
                      selectedList.add(reports[index]);
                    } else {
                      selectedList.remove(reports[index]);
                    }
                  });
                },
                key: Key(reports[index].id.toString()));
          },
          separatorBuilder: (context, index) {
            return const Divider();
          },
        ),
        floatingActionButton: selectedList.isEmpty ? buildYearSelect() : null,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      ),
    );
  }

  Container buildYearSelect() {
    return Container(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
        decoration: const ShapeDecoration(
            color: Color(0xFF303030),
            shape:  RoundedRectangleBorder(
              side:  BorderSide(color: Color(0xFF212121),width: 2),
              borderRadius: BorderRadius.all(
                Radius.circular(20.0),
              ),
          ),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            hint: Text('Year: '),
            value: _selectedYear.toString(),
            icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
            iconSize: 24,
            elevation: 10,
            style:  TextStyle(color: Colors.white),
            underline: Container(
              height: 1,
              color: Color(0xFF2E7D32),
            ),
            onChanged: (year) {
              setState(() {
                _selectedYear = int.parse(year!);
                _loadReports(reportType);
              });
            },
            dropdownColor: Color(0xFF303030),
            alignment: Alignment.center,
            items: _dropdownItems,
          ),
        ),
      );
  }

  BottomAppBar buildDownloadBottomNavigationBard() {
    return BottomAppBar(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: TextButton(
              onPressed: () async {
                var path = await downloadReports();
              if (path != null) {
                _onSelectNotification(path);
              } else {
                openPopup(context, 'Error while generating report', 'Try later');
              }},
              child: Text(
                  'Download selected',
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
    );
  }

  AppBar buildMultipleSelectionAppBar() {
    return AppBar(
        title: Row(
          children: <Widget>[
            Text('Selected items: ' + selectedList.length.toString()),
          ],
        ),
        actions: const <Widget>[],
        backgroundColor: Color(0xFF2E7D32),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(25.0),
        )));
  }

  BottomNavigationBar buildDefaultBottomNavigationBar() {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.assignment_ind_outlined),
          label: 'Students',
          backgroundColor: Color(0xFF2E7D32),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.school),
          label: 'Teachers',
          backgroundColor: Color(0xFF2E7D32),
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Color(0xFF2E7D32),
      onTap: _onItemTapped,
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      ReportType selectedReportType = index == 0 ? ReportType.STUDENT : ReportType.TEACHER;
      _loadReports(selectedReportType);
      reportType = selectedReportType;
    });
  }

  _loadReports(ReportType reportType) async {
    endYearReports = await getPastSchoolYearsReports(reportType, _selectedYear);
  }

  _loadYears() async {
    var result = await getAllReportsYears();
    setState(() {
      reportsYears = result;
      _dropdownItems = _mapResultToDropdownItems();
    });
  }

  downloadSingleReport(int reportId) async {
    List<int> reportIds = [];
    reportIds.add(reportId);

    EndYearReportRequest request = EndYearReportRequest(reportIds);
    var result = await generateEndYearReport(request);

    return result;
  }

  Future<String?> downloadReports() async {
    List<int> reportIds = [];

    for (var element in selectedList) {
      reportIds.add(element.id);
    }

    EndYearReportRequest request = EndYearReportRequest(reportIds);
    var result = await generateEndYearReport(request);

    return result;
  }

  List<DropdownMenuItem<String>> _mapResultToDropdownItems() {
    return reportsYears.map<DropdownMenuItem<String>>((String year) {
      return DropdownMenuItem<String>(
        value: year,
        child: Text(year),
      );
    }).toList();
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
              Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) =>  PastSchoolYearsWidget()),
              );
            },
          )
        ],
      ),
    );
  }

}
