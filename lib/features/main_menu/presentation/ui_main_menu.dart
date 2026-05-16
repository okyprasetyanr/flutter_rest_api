import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_restful_api/app_properties/app_properties_style.dart';
import 'package:flutter_restful_api/features/main_menu/logic/main_menu_bloc.dart';
import 'package:flutter_restful_api/features/main_menu/logic/main_menu_state.dart';
import 'package:flutter_restful_api/models/model_data/model_todo.dart';

class UiMainMenu extends StatefulWidget {
  const UiMainMenu({super.key});

  @override
  State<UiMainMenu> createState() => _UiMainMenuState();
}

class _UiMainMenuState extends State<UiMainMenu> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Text("Daftar Note", style: subTitleTextStyle),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
            ),
            Expanded(
              child: BlocSelector<MainMenuBloc, MainMenuState, List<ModelTodo>>(
                selector: (state) =>
                    state is MainMenuLoaded ? state.listTodo : [],
                builder: (context, state) => state.isEmpty
                    ? const Center(child: CircularProgressIndicator())
                    : GridView(
                        padding: const EdgeInsets.all(10),
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 400,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          childAspectRatio: 10,
                          mainAxisExtent: 100,
                        ),
                        children: [
                          ...state.map(
                            (e) => Card(
                              elevation: 3,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 5,
                                  vertical: 5,
                                ),
                                child: Column(
                                  children: [
                                    _rowContent("Note", e.todo),
                                    _rowContent("Id Note", e.id),
                                    _rowContent("Id User", e.userId),
                                    _rowContent(
                                      "Selesai",
                                      e.completed ? "Ya" : "Belum",
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _rowContent(String title, dynamic content) {
    return Row(
      children: [
        Expanded(child: Text(title, style: lv05TextStyle)),
        Text(": ", style: lv05TextStyle),
        Expanded(
          flex: 4,
          child: Text(
            content.toString(),
            style: lv05TextStyle,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
