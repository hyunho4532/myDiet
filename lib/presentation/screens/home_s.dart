import 'package:flutter/material.dart';

class HomeS extends StatefulWidget {
  const HomeS({super.key});

  @override
  State<HomeS> createState() => _HomeSState();
}

class _HomeSState extends State<HomeS> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text('1234')
        ],
      ),
      backgroundColor: Colors.white,
    );
  }
}
