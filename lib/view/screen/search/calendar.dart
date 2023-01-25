import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:test_project_session_3/viewmodel/search_model.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var searchModel = Provider.of<SearchModel>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(elevation: 0, backgroundColor: Colors.white, title: Text('날짜 추가', style: TextStyle(color: Colors.black)), iconTheme: IconThemeData(color: Colors.black)),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(icon: Icon(Icons.arrow_back_ios, size: 15,), onPressed: () => searchModel.setCalendar(searchModel.year, searchModel.month--)),
                Text('${searchModel.year}년 ${searchModel.month}월', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
                IconButton(icon: Icon(Icons.arrow_forward_ios, size: 15,), onPressed: () => searchModel.setCalendar(searchModel.year, searchModel.month++)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(alignment: Alignment.center, width: 30, height: 30, child: Text("일", style: TextStyle(fontWeight: FontWeight.bold, color:Colors.red))),
                Container(alignment: Alignment.center, width: 30, height: 30, child: Text("월", style: TextStyle(fontWeight: FontWeight.bold))),
                Container(alignment: Alignment.center, width: 30, height: 30, child: Text("화", style: TextStyle(fontWeight: FontWeight.bold))),
                Container(alignment: Alignment.center, width: 30, height: 30, child: Text("수", style: TextStyle(fontWeight: FontWeight.bold))),
                Container(alignment: Alignment.center, width: 30, height: 30, child: Text("목", style: TextStyle(fontWeight: FontWeight.bold))),
                Container(alignment: Alignment.center, width: 30, height: 30, child: Text("금", style: TextStyle(fontWeight: FontWeight.bold))),
                Container(alignment: Alignment.center, width: 30, height: 30, child: Text("토", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue))),
            ],),
            Column(
              children: calendar(context),
            ),
            SizedBox(height: 8),
            Row(children: [
              searchModel.data['checkIn'] == null ? Text('') : Text('${DateFormat('M.d').format(searchModel.data['checkIn'])} ~ ', style: TextStyle(fontWeight: FontWeight.bold)),
              searchModel.data['checkOut'] == null ? Text('') : Text(DateFormat('M.d').format(searchModel.data['checkOut']), style: TextStyle(fontWeight: FontWeight.bold)),
              searchModel.data['checkOut'] == null ? Text('')
                  : Text(' (${DateTime.parse('${searchModel.data['checkOut']}').difference(DateTime.parse('${searchModel.data['checkIn']}')).inDays}박 '
                  '${DateTime.parse('${searchModel.data['checkOut']}').difference(DateTime.parse('${searchModel.data['checkIn']}')).inDays + 1}일)',
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ]),
          ],
        ),
      ),
      floatingActionButton: ElevatedButton(onPressed: () => Navigator.pushNamed(context, '/search/guest'), child: Text('다음')),
    );
  }

  Widget dayWidget(context, int year, int month, int day) {
    var searchModel = Provider.of<SearchModel>(context);
    bool check = false;
    bool prevCheck = DateTime.now().compareTo(DateTime(year, month, day)) > 0;
    DateTime today = DateTime(year, month, day);
    if(searchModel.data['checkIn'] != null) {
      if(searchModel.data['checkIn'] == today) {
        check = true;
      }
      if(searchModel.data['checkOut'] != null) {
        if(searchModel.data['checkIn'].compareTo(today) <= 0
            && searchModel.data['checkOut'].compareTo(today) >= 0) {
          check = true;
        }
      }
    }

    return GestureDetector(
      onTap: prevCheck ? null : (){
        if(searchModel.typeCheck == "checkIn") {
          searchModel.checkInChange(DateTime(year, month, day));
          searchModel.typeCheck = "checkOut";
        } else if(searchModel.typeCheck == "checkOut") {
          if(searchModel.data['checkIn'].compareTo(DateTime(year, month, day)) >= 0) {
            print(searchModel.data['checkIn']);
            searchModel.checkInChange(DateTime(year, month, day));
            searchModel.typeCheck = "checkOut";
            return;
          }

          searchModel.checkOutChange(DateTime(year, month, day));
          searchModel.typeCheck = "reset";
        } else {
          searchModel.checkInChange(DateTime(year, month, day));
          searchModel.checkOutChange(null);
          searchModel.typeCheck = "checkOut";
        }
      },
      child: Container(
        decoration: check == true ? BoxDecoration(
          color: Color.fromRGBO(0, 255, 255, .5),
          borderRadius: BorderRadius.circular(100)
        ) : BoxDecoration(),
        width: 30,
        height: 30,
        alignment: Alignment.center,
        child: Text('${day ?? ''}', style: TextStyle(color: prevCheck ? Colors.grey : Colors.black)),
      ),
    );
  }

  List<Widget> calendar(context, [int? year, int? month]) {
    var searchModel = Provider.of<SearchModel>(context);
    var calendarData = searchModel.setCalendar();

    List<Widget> result = [];
    for(var n = 1, i = 0; i < calendarData['totalWeek']; i++) {
      List<Widget> rows = [];
      for(var k = 0; k < 7; k++) {
        if( (n > 1 || k + 1 >= calendarData['startWeek']) && calendarData['totalDay'] >= n ) {
          rows.add(dayWidget(context, calendarData['year'], calendarData['month'], n));
          n++;
        } else {
          rows.add(SizedBox(width: 30, height: 30));
        }
      }
      result.add(Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: rows));
    }
    return result;
  }
}
