import 'package:flutter/material.dart';
import 'login_page.dart';
import 'installation_report_page.dart';
import 'register_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Field Service Report',
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(),
        '/report': (context) => InstallationReportForm(),
        '/register': (context) => RegisterPage(),
      },
    );
  }
}
