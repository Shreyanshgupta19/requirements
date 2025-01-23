import 'package:firebase_todo_app/routes/enum_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectedPage = StateProvider.autoDispose<pages>((ref) => pages.home_page);

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [

        ],
      );
  }
}
