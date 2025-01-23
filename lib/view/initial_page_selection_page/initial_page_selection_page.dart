import 'package:firebase_todo_app/config/utils/widgets/responsive.dart';
import 'package:firebase_todo_app/routes/enum_routes.dart';
import 'package:firebase_todo_app/view/home_page/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectedPage = StateProvider.autoDispose<pages>((ref) => pages.home_page);

class InitialPageView extends ConsumerStatefulWidget {
  const InitialPageView({super.key});

  @override
  ConsumerState<InitialPageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends ConsumerState<InitialPageView> {
  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);

    return SafeArea(
      child: Scaffold(
        appBar: ref.watch(selectedPage.notifier).state == pages.home_page
            ? AppBar(
                title: Text(
                  'Bio Data App',
                ),
              )
            : null,
        body: Builder(
          builder: (_) {
            final page = ref.watch(selectedPage);
            switch (page) {
              case pages.home_page:
                return const HomePage();
              default:
                return const Center(child: Text('Page not found'));
            }
          },
        ),
      ),
    );
  }
}
