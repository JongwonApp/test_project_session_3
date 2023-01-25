import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_project_session_3/viewmodel/search_model.dart';

class GuestScreen extends StatelessWidget {
  const GuestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var searchModel = Provider.of<SearchModel>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(elevation: 0, backgroundColor: Colors.white, title: Text('게스트 추가', style: TextStyle(color: Colors.black)), iconTheme: IconThemeData(color: Colors.black)),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('성인', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),), Text('만 13세 이상', style: TextStyle(color: Colors.grey, fontSize: 12),)
            ]),
            Row(children: [
              IconButton(onPressed: () => searchModel.changeAdultCount(false), icon: Icon(Icons.remove)),
              Text(searchModel.adult.toString(), style: TextStyle(fontSize: 20)),
              IconButton(onPressed: () => searchModel.changeAdultCount(true), icon: Icon(Icons.add)),
            ]),
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('어린이', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),), Text('만 13세 미만', style: TextStyle(color: Colors.grey, fontSize: 12),)
            ]),
            Row(children: [
              IconButton(onPressed: () => searchModel.changeChildrenCount(false), icon: Icon(Icons.remove)),
              Text(searchModel.children.toString(), style: TextStyle(fontSize: 20)),
              IconButton(onPressed: () => searchModel.changeChildrenCount(true), icon: Icon(Icons.add)),
            ]),
          ])
        ]),
      ),
      floatingActionButton: ElevatedButton(onPressed: () {
        searchModel.search();
        Navigator.pushNamed(context, '/search/result');
      }, child: Text('검색')),
    );
  }
}
