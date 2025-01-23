import 'package:firebase_todo_app/config/components/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

enum Type{error, success, loading}
class Utils {
  static void showFullScreenLoadingDialog(
      BuildContext context, {
        required String message,
        int durationInSeconds = 3,
      }) {
    // Keep a reference to the current context
    final overlayContext = context;

    showDialog(
      context: overlayContext,
      barrierDismissible: false, // Prevent dismissal by tapping outside
      builder: (context) {
        // Automatically dismiss the dialog after the specified duration
        Future.delayed(Duration(seconds: durationInSeconds), () {
          // Check if the Navigator can pop before trying to dismiss
          if (Navigator.of(overlayContext).canPop()) {
            Navigator.of(overlayContext).pop();
          }
        });

        return Dialog(
          backgroundColor: Colors.transparent, // Makes the dialog background transparent
          insetPadding: EdgeInsets.zero, // Removes any default padding
          child: Stack(
            children: [
              // Semi-transparent background covering the entire screen
              Container(
                width: double.infinity,
                height: double.infinity,
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.3),
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      message,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Colors.blue,
                      ),
                    ),
                    const SizedBox(height: 10),
                    LoadingWidget(), // Your custom loading widget
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );




    Future.delayed(Duration(seconds: durationInSeconds), () {
      if (Navigator.of(context).canPop()) {
        Navigator.of(context).pop();
      }
    });
  }


  static void fieldFocusChange(BuildContext context , FocusNode current , FocusNode nextFocus){
    current.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  static toastMessage({
    required String message,
    required BuildContext context,
    required Type type,
  }){
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: type == Type.error
          ? Theme.of(context).colorScheme.error
          : type == Type.loading
          ? Theme.of(context).colorScheme.secondary
          : type == Type.success
          ? Colors.green
          : null,

      textColor: Theme.of(context).colorScheme.onPrimary,
      gravity: ToastGravity.BOTTOM,
      toastLength: Toast.LENGTH_SHORT,
    );
  }

  static snackBar({
    required String message,
    required BuildContext context,
    required Type type,
  }){
    return ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: type == Type.error
              ? Theme.of(context).colorScheme.error
              : type == Type.loading
              ? Theme.of(context).colorScheme.secondary
              : type == Type.success
              ? Colors.green
              : null,
          content: Text(message ),
          duration: Duration(seconds: 3),
          action: SnackBarAction(
            label: 'Dismiss',
            onPressed: () {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
            },
          ),
        ),
    );
  }


}