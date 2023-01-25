import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_project_session_3/viewmodel/hotel_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    var hotelModel = Provider.of<HotelModel>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: hotelModel.isLoading ? Center(child: CircularProgressIndicator()) : Padding(
        padding: EdgeInsets.fromLTRB(16.0,16.0,16.0,0),
        child: Column(
          children: [
            TextField(onTap: () {
              FocusScope.of(context).unfocus();
              Navigator.pushNamed(context, '/search');
            }, decoration: InputDecoration(hintText: "주소를 검색하세요",border: OutlineInputBorder())),
            SizedBox(height: 16),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 10, crossAxisSpacing: 10, childAspectRatio: 1/1.15),
                itemCount: hotelModel.hotels.length,
                itemBuilder: (c, i) {
                  return Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.memory(base64Decode(hotelModel.hotels[i].representationImg['image']), fit: BoxFit.cover)
                    ),
                    SizedBox(height: 8),
                    Text(hotelModel.hotels[i].hotelName.length > 15 ? "${hotelModel.hotels[i].hotelName.substring(0,13)}..." : hotelModel.hotels[i].hotelName),
                    Text(hotelModel.hotels[i].address, style: TextStyle(fontSize: 10)),
                    Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                      Text("★ ★ ★ ★ ★", style: TextStyle(color: CupertinoColors.systemYellow)), SizedBox(width: 8),
                      Text("(${(hotelModel.hotels[i].rating * 5).toStringAsFixed(1)})", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 12))
                    ])
                  ]);
                }
              ),
            ),
          ],
        ),
      ),
    );
  }
}
