import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_restful_api/app_properties/app_properties_color.dart';
import 'package:flutter_restful_api/app_properties/app_properties_style.dart';
import 'package:flutter_restful_api/common_widget/custom_snack_bar.dart';
import 'package:flutter_restful_api/connection/post_api.dart';
import 'package:flutter_restful_api/features/main_menu/logic/main_menu_bloc.dart';
import 'package:flutter_restful_api/features/main_menu/logic/main_menu_event.dart';
import 'package:flutter_restful_api/features/main_menu/logic/main_menu_state.dart';
import 'package:flutter_restful_api/models/model_data/model_todo.dart';

class UiMainMenu extends StatefulWidget {
  const UiMainMenu({super.key});

  @override
  State<UiMainMenu> createState() => _UiMainMenuState();
}

class _UiMainMenuState extends State<UiMainMenu> {
  final todoController = TextEditingController();
  @override
  void dispose() {
    todoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            final bloc = context.read<MainMenuBloc>();
            showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (context) => DraggableScrollableSheet(
                initialChildSize: 0.6,
                minChildSize: 0.3,
                maxChildSize: 0.8,
                expand: false,
                builder: (context, scrollController) {
                  return Column(
                    children: [
                      Container(
                        width: 40,
                        height: 5,
                        margin: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: AppPropertyColor.grey,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      const SizedBox(height: 40),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 10,
                          ),
                          child: Column(
                            children: [
                              TextField(
                                controller: todoController,
                                decoration: InputDecoration(
                                  labelStyle: lv1TextStyle,
                                  labelText: "Todo",
                                  hintStyle: lv1TextStyle,
                                  hintText: "...",
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  border: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(8),
                                    ),
                                  ),
                                ),
                              ),
                              Spacer(),
                              ElevatedButton.icon(
                                style: ButtonStyle(
                                  backgroundColor: const WidgetStatePropertyAll(
                                    AppPropertyColor.primary,
                                  ),
                                ),
                                onPressed: () async {
                                  final response = await postAddTodo(
                                    ModelTodo(
                                      id:
                                          (bloc.state as MainMenuLoaded)
                                              .listTodo
                                              .length +
                                          1,
                                      todo: todoController.text,
                                      completed: false,
                                      userId: 99,
                                      isDeleted: false,
                                      deletedOn: null,
                                    ),
                                  );
                                  if (response.$2 != null) {
                                    bloc.add(MainMenuAdd(data: response.$2!));
                                    if (context.mounted) {
                                      return Navigator.pop(context);
                                    }
                                  }
                                  todoController.clear();
                                  return context.mounted
                                      ? customSnackBar(response.$1, context)
                                      : null;
                                },
                                label: Text("Simpan", style: lv1TextStyleWhite),
                                icon: Icon(
                                  Icons.check,
                                  color: AppPropertyColor.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            );
          },
          elevation: 3,
          backgroundColor: AppPropertyColor.primary,
          child: const Icon(Icons.add, color: AppPropertyColor.white),
        ),
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
                              child: GestureDetector(
                                onTap: () {
                                  final bloc = context.read<MainMenuBloc>();
                                  showDialog(
                                    context: context,
                                    builder: (context) => Row(
                                      children: [
                                        TextButton(
                                          onPressed: () {},
                                          child: Text("Update"),
                                        ),
                                      ],
                                    ),
                                  );
                                },
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
