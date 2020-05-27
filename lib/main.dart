import 'package:flutter/material.dart';

import 'Dashboard.dart';

void main() {
  runApp(Details());
}
class Details extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Dashboard(),
    );
  }
}


