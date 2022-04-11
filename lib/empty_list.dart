import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class EmptyList extends StatelessWidget {
  const EmptyList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Lottie.asset('assets/man.json'),
      ),
    );
  }
}
