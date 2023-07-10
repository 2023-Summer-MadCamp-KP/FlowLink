import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
              child: CupertinoActivityIndicator(
                animating: true,
                radius: 30,
              ),
            ),
    );
  
  }
}