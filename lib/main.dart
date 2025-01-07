// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc_app/app_router.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp(
    appRouter: AppRouter(),
  ));
}

class MyApp extends StatelessWidget {
  final AppRouter appRouter;
  const MyApp({
    super.key,
    required this.appRouter,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      showSemanticsDebugger: false,
      onGenerateRoute: appRouter.generateRoute,
    );
  }
}
