import 'package:contactosapp/src/bloc/provider.dart';
import 'package:contactosapp/src/page/home_page.dart';
import 'package:flutter/material.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      child: MaterialApp(
        title: 'Material App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(),
        home: HomePage()
      ),
    );
  }
}