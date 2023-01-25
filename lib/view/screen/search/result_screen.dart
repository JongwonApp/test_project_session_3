import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:test_project_session_3/view/widget/app_bar.dart';
import 'package:test_project_session_3/viewmodel/search_model.dart';

class ResultScreen extends StatelessWidget {
  ResultScreen({Key? key}) : super(key: key);
  bool fetchCheck = false;

  @override
  Widget build(BuildContext context) {
    var searchModel = Provider.of<SearchModel>(context);
    return Scaffold(
      appBar: app_bar,
      body: searchModel.isLoading ? Center(child: CircularProgressIndicator()) : Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            '${searchModel.data['address']}, '
            '${DateFormat('M.d').format(searchModel.data['checkIn'])}'
            ' ~ ${DateFormat('d').format(searchModel.data['checkOut'])}'
            ' 게스트 ${searchModel.data['noPeople']}명 숙소',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Expanded(
            child: ListView.builder(shrinkWrap: true, itemCount: searchModel.result.length, itemBuilder: (c,i) {
              var res = searchModel.result[i].toJson();
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(padding: EdgeInsets.symmetric(vertical: 8), child: ClipRRect(borderRadius: BorderRadius.circular(20), child: Image.memory(base64Decode(res['representationImg']['image']), fit: BoxFit.cover)),),
                    Padding(padding: EdgeInsets.symmetric(horizontal: 8), child: Text("${res['hotelName']}", style: TextStyle(fontWeight: FontWeight.bold)),),
                    Padding(padding: EdgeInsets.symmetric(horizontal: 8), child: Text("${res['address']}"),),
                    Padding(padding: EdgeInsets.symmetric(horizontal: 8),child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                        Text("★ ★ ★ ★ ★", style: TextStyle(color: CupertinoColors.systemYellow),),SizedBox(width: 8),
                        Text("(${(res['rating'] * 5).toStringAsFixed(1)})", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 12))
                      ]),
                    ),
                  ],
                ),
              );
            }),
          )
        ],
      ),
    );
  }
}
