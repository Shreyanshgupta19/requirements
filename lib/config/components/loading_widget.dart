import 'package:flutter/foundation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Custom loading widget, used to show a loading indicator depending on the platform.
// This widget is generic and changes will reflect across the app.
class LoadingWidget extends StatelessWidget {
  final double size;

  const LoadingWidget({Key? key, this.size = 36.0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: size,
        height: size,
        child: kIsWeb
            ? const CircularProgressIndicator(
          strokeWidth: 2.0,
          color: Colors.blue,
        )
            : (defaultTargetPlatform == TargetPlatform.iOS
            ? const CupertinoActivityIndicator(
          color: Colors.blue,
        )
            : const CircularProgressIndicator(
          strokeWidth: 2.0,
          color: Colors.blue,
        )),
      ),
    );
  }
}
