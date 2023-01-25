import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_project_session_3/view/screen/search/calendar.dart';
import 'package:test_project_session_3/view/screen/search/guest_screen.dart';
import 'package:test_project_session_3/view/screen/home_screen.dart';
import 'package:test_project_session_3/view/screen/login_screen.dart';
import 'package:test_project_session_3/view/screen/reservation_screen.dart';
import 'package:test_project_session_3/view/screen/search/result_screen.dart';
import 'package:test_project_session_3/view/screen/search/search_screen.dart';
import 'package:test_project_session_3/view/style.dart' as style;
import 'package:test_project_session_3/view/widget/app_bar.dart';
import 'package:test_project_session_3/view/widget/bottom_bar.dart';
import 'package:test_project_session_3/viewmodel/calendar_model.dart';
import 'package:test_project_session_3/viewmodel/hotel_model.dart';
import 'package:test_project_session_3/viewmodel/reservation_model.dart';
import 'package:test_project_session_3/viewmodel/search_model.dart';
import 'package:test_project_session_3/viewmodel/user_model.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => UserModel()),
      ChangeNotifierProvider(create: (_) => HotelModel()),
      ChangeNotifierProvider(create: (_) => ReservationModel()),
      ChangeNotifierProvider(create: (_) => CalendarModel()),
      ChangeNotifierProvider(create: (_) => SearchModel()),
    ],
    child: MaterialApp(
      theme: style.theme,
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => MyApp(),
        '/home': (context) => HomeScreen(),
        '/login': (context) => LoginScreen(),
        '/search': (context) => SearchScreen(),
        '/search/calendar': (context) => CalendarScreen(),
        '/search/guest': (context) => GuestScreen(),
        '/search/result': (context) => ResultScreen(),
        '/reservation': (context) => ReservationScreen(),
      },
    ),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var userModel = Provider.of<UserModel>(context);
    return userModel.isLoading
        ? Center(child: CircularProgressIndicator())
        : (userModel.user == null ? LoginScreen() : DefaultTabController(
      length: 2,
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: app_bar,
          body: TabBarView(
            children: [
              HomeScreen(),
              ReservationScreen()
            ],
          ),
          bottomNavigationBar: bottom_bar
      ),
    ));
  }
}
