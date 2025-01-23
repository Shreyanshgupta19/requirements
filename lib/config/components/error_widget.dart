import 'package:flutter/material.dart';

class CustomErrorWidget extends StatelessWidget {
  final String errorMessage;

  CustomErrorWidget({required this.errorMessage});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.error_outline,
                  color: Theme.of(context).colorScheme.error,
                  size: 50.0,
                ),
                SizedBox(height: 10.0),
                Text(
                  'Error Occurred!',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  softWrap: true,
                ),
                SizedBox(height: 10.0),
                Text(
                  errorMessage,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16.0),
                  softWrap: true,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}