import 'package:equatable/equatable.dart';
import 'package:flutter_restful_api/models/model_data/model_todo.dart';
import 'package:flutter_restful_api/models/model_data/model_todo_parent.dart';

class MainMenuState {}

class MainMenuInitial extends MainMenuState {}

class MainMenuLoaded extends MainMenuState with EquatableMixin {
  final ModelTodo? selectedTodo;
  final ModelTodoParent? filteredTodo;
  final List<ModelTodo> listTodo;
  final bool isSnackbarActive;
  final String? meesageSnackBar;

  MainMenuLoaded({
    this.isSnackbarActive = false,
    this.selectedTodo,
    this.filteredTodo,
    this.meesageSnackBar,
    this.listTodo = const [],
  });

  MainMenuLoaded copyWith({
    ModelTodo? selectedTodo,
    ModelTodoParent? filteredTodo,
    List<ModelTodo>? listTodo,
    String? meesageSnackBar,
    bool? isSnackbarActive,
  }) {
    return MainMenuLoaded(
      meesageSnackBar: meesageSnackBar,
      isSnackbarActive: isSnackbarActive ?? this.isSnackbarActive,
      filteredTodo: filteredTodo ?? this.filteredTodo,
      selectedTodo: selectedTodo,
      listTodo: listTodo ?? this.listTodo,
    );
  }

  @override
  List<Object?> get props => [
    meesageSnackBar,
    selectedTodo,
    filteredTodo,
    listTodo,
    isSnackbarActive,
  ];
}
