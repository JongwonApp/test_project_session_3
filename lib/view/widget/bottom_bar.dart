import 'package:flutter/material.dart';

var bottom_bar = TabBar(
  tabs: [
    Tab(
      icon: Icon(Icons.home, size: 25, color: Colors.black,),
      child: Text('HOME', style: TextStyle(fontSize: 9, color: Colors.black)),
    ),
    Tab(
      icon: Icon(Icons.person, size: 25, color: Colors.black,),
      child: Text('My Reservation', style: TextStyle(fontSize: 9, color: Colors.black)),
    ),
  ],
);