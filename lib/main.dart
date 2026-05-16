import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_restful_api/features/main_menu/logic/main_menu_bloc.dart';
import 'package:flutter_restful_api/features/main_menu/logic/main_menu_event.dart';
import 'package:flutter_restful_api/features/main_menu/presentation/ui_main_menu.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: BlocProvider(
            create: (context) => MainMenuBloc()..add(MainMenuGetData()),
            child: const UiMainMenu(),
          ),
        ),
      ),
    );
  }
}
