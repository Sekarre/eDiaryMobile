import 'package:e_diary_mobile/model/end_year_report.dart';
import 'package:e_diary_mobile/model/end_year_report_request.dart';
import 'package:e_diary_mobile/reports/report_service.dart';
import 'package:e_diary_mobile/shared/components/error_popup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';

class GridItem extends StatefulWidget {
  final Key key;
  final EndYearReport endYearReport;
  ValueChanged<bool> isSelected;

  GridItem({required this.key, required this.endYearReport, required this.isSelected});

  @override
  _GridItemState createState() => _GridItemState();
}

class _GridItemState extends State<GridItem> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: () {
        setState(() {
          isSelected = !isSelected;
          widget.isSelected(isSelected);
        });
      },
      child: Stack(
        children: <Widget>[
          ListTile(
            leading: const Icon(Icons.picture_as_pdf_rounded, size: 30.0),
            trailing: const Icon(Icons.download_sharp),
            title: _title(
                widget.endYearReport.name,
                const TextStyle(
                    fontSize: 15.0, fontWeight: FontWeight.bold)),
            subtitle: Text(widget.endYearReport.year),
            dense: true,
            onTap: () async {
              var path = await downloadSingleReport(widget.endYearReport.id);
              if (path != null) {
                _onSelectNotification(path);
              } else {
                openPopup(context, 'Error while generating report', 'Try later');
              }},
          ),
          isSelected
              ? const Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(
                Icons.check_circle,
                color: Color(0xFF2E7D32),
              ),
            ),
          )
              : Container()
        ],
      ),
    );
  }

  downloadSingleReport(int reportId) async {
    List<int> reportIds = [];
    reportIds.add(reportId);

    EndYearReportRequest request = EndYearReportRequest(reportIds);
    var result = await generateEndYearReport(request);

    return result;
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
            child: Text('Open', style: TextStyle(color: Color(0xFF2E7D32))),
            onPressed: () async {
              OpenFile.open(path);
              Navigator.of(context, rootNavigator: true).pop();
            },
          )
        ],
      ),
    );
  }
}


Widget _title(String text, TextStyle style) {
  return Container(
    padding: const EdgeInsets.fromLTRB(0, 5.0, 0, 5.0),
    child: Text(
      text,
      style: style,
    ),
  );
}
