import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:test_project_session_3/viewmodel/reservation_model.dart';

class ReservationScreen extends StatelessWidget {
  const ReservationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var reservationModel = Provider.of<ReservationModel>(context);
    return reservationModel.isLoading
        ? Center(child: CircularProgressIndicator())
        : (reservationModel.reservations.isEmpty
            ? Center(child: Text('예약 내역이 존재하지 않습니다.'))
            : ListView.builder(
                itemCount: reservationModel.reservations.length,
                itemBuilder: (c, i) {
                  var difference = int.parse(DateTime.parse(reservationModel.reservations[i].checkOut).difference(DateTime.parse(reservationModel.reservations[i].checkIn)).inDays.toString());
                  return Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            '${reservationModel.reservations[i].checkIn.substring(0, 10)}'
                            ' ~ ${reservationModel.reservations[i].checkOut.substring(0, 10)}'
                            ' - $difference박 ${difference + 1}일 간의 여행'),
                          ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: Text('총 숙박비 ￦${NumberFormat('###,###,###,###').format(reservationModel.reservations[i].amount).replaceAll(' ', '')}')
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: ClipRRect(borderRadius: BorderRadius.circular(20), child: Image.memory(base64Decode(reservationModel.reservations[i].image), fit: BoxFit.cover),),
                        ),
                        Text(reservationModel.reservations[i].hotelName, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        Text(reservationModel.reservations[i].address),
                        Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                          Text("★ ★ ★ ★ ★", style: TextStyle(color: CupertinoColors.systemYellow),),SizedBox(width: 8),
                          Text("(${(reservationModel.reservations[i].rating * 5).toStringAsFixed(1)})", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 12))
                        ]),
                      ],
                    ),
                  );
                },
              ));
  }
}
