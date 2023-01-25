import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_project_session_3/viewmodel/search_model.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final searchModel = Provider.of<SearchModel>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        automaticallyImplyLeading: false,
        title: TextField(
          controller: _searchController,
          onChanged: (text) => searchModel.fetchAddress(_searchController.text),
          decoration: InputDecoration(hintText: '주소를 검색하세요', border: InputBorder.none)
        ),
        actions: [TextButton(onPressed: () => Navigator.pop(context), child: Text('취소'),)],
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: searchModel.isLoading ? Center(child: CircularProgressIndicator()) : ListView.builder(itemCount: searchModel.address.length, itemBuilder: (c, i) {
          return GestureDetector(
            onTap: () {
              searchModel.data['address'] = searchModel.address[i];
              Navigator.pushNamed(context, '/search/calendar');
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(border: Border(bottom: BorderSide())),
              child: ListTile(
                leading: Icon(Icons.pin_drop, color: CupertinoColors.systemYellow, size: 30),
                title: Text(searchModel.address[i]),
              ),
            ),
          );
        }),
      )
    );
  }
}
