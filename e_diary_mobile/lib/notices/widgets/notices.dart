import 'package:e_diary_mobile/model/notice.dart';
import 'package:e_diary_mobile/notices/notice_service.dart';
import 'package:e_diary_mobile/shared/components/app_common.dart';
import 'package:e_diary_mobile/shared/components/no_data.dart';
import 'package:e_diary_mobile/shared/error_messages.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

class NoticesWidget extends StatelessWidget {
  const NoticesWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getNotices(),
        builder: (context, AsyncSnapshot<List<Notice>> snapshot) {
          if (snapshot.hasData) {
            return noticesListView(context, snapshot.requireData);
          } else {
            return NoDataWidget(NO_NOTICES);
          }
        });
  }

  Scaffold noticesListView(BuildContext context, List<Notice> notices) {
    return Scaffold(
      appBar: buildAppBar("Notices"),
      body: ListView.separated(
        itemCount: notices.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: _title('${notices[index].title}',
                const TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold)),
            subtitle: _dateAuthorAndContent('${notices[index].date}',
                '${notices[index].authorName}', '${notices[index].content}'),
            dense: true,
            onTap: () => null,
          );
        },
        separatorBuilder: (context, index) {
          return const Divider();
        },
      ),
    );
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

  Widget _dateAuthorAndContent(String date, String author, String content) {
    var textStyle = TextStyle(fontSize: 13.0, fontStyle: FontStyle.italic, letterSpacing: 1);
    var moreLessStyle = TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.deepPurple);

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget> [
          Text(
            date,
            style: textStyle,
          ),
          Text(
            author,
            style: textStyle,
          ),
           ReadMoreText(
            '\n$content',
            trimLines: 5,
            trimMode: TrimMode.Line,
            trimCollapsedText: 'Show more',
            trimExpandedText: 'Show less',
            style: TextStyle(fontSize: 14, color: Colors.black),
            moreStyle: moreLessStyle,
            lessStyle: moreLessStyle,
          )
        ],
      )
    );
  }

}