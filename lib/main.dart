import 'dart:io';
import 'package:firebase_todo_app/config/components/error_widget.dart';
import 'package:firebase_todo_app/config/utils/common/app_theme/color_theme.dart';
import 'package:firebase_todo_app/config/utils/common/app_theme/provider/change_theme_provider.dart';
import 'package:firebase_todo_app/config/utils/common/app_theme/text_theme.dart';
import 'package:firebase_todo_app/config/utils/widgets/scroll.dart';
import 'package:firebase_todo_app/view/initial_page_selection_page/initial_page_selection_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// class MyHttpOverrides extends HttpOverrides {
//   @override
//   HttpClient createHttpClient(SecurityContext? context) {
//     return super.createHttpClient(context)
//       ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
//   }
// }
void main() {
  if (kDebugMode) {
    FlutterError.onError = (FlutterErrorDetails details) {
      FlutterError.dumpErrorToConsole(details);
      runApp(ProviderScope(child: ErrorWidgetClass(details)));
    };
  }
  // HttpOverrides.global = MyHttpOverrides();
  runApp(const ProviderScope(child: MyApp()));
}

class ErrorWidgetClass extends ConsumerWidget {
  ErrorWidgetClass(this.errorDetails);
  final FlutterErrorDetails errorDetails;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: MaterialThemeForText.theme(MaterialThemeForColor.lightColorScheme),
        darkTheme: MaterialThemeForText.theme(MaterialThemeForColor.darkColorScheme),
        themeMode: themeMode == ThemeModesForApp.dark
            ? ThemeMode.dark
            : themeMode == ThemeModesForApp.light
            ? ThemeMode.light
            : ThemeMode.system,
        builder: (context, child) {
          return CustomErrorWidget(
            errorMessage: errorDetails.exceptionAsString(),
          );
        }
    );
  }
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);
    return MaterialApp(
      title: 'Bio Data App',
      theme: MaterialThemeForText.theme(MaterialThemeForColor.lightColorScheme),
      darkTheme: MaterialThemeForText.theme(MaterialThemeForColor.darkColorScheme),
      themeMode: themeMode == ThemeModesForApp.dark
          ? ThemeMode.dark
          : themeMode == ThemeModesForApp.light
          ? ThemeMode.light
          : ThemeMode.system,
      scrollBehavior: (!kIsWeb && (Platform.isAndroid || Platform.isIOS))
          ? null
          : CustomScrollBehavior(),
      debugShowCheckedModeBanner: false,
      home: InitialPageView(),
    );
  }
}

// C:\Users\Shreyansh Gupta\StudioProjects\kotlin projects\desktop_page