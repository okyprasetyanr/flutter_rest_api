import 'package:equatable/equatable.dart';
import 'package:flutter_restful_api/models/model_data/model_todo.dart';
import 'package:flutter_restful_api/models/model_data/model_todo_parent.dart';

class MainMenuState {}

class MainMenuInitial extends MainMenuState {}

class MainMenuLoaded extends MainMenuState with EquatableMixin {
  final ModelTodo? selectedTodo;
  final ModelTodoParent? filteredTodo;
  final List<ModelTodo> listTodo;

  MainMenuLoaded({
    this.selectedTodo,
    this.filteredTodo,
    this.listTodo = const [],
  });

  MainMenuLoaded copyWith({
    ModelTodo? selectedTodo,
    ModelTodoParent? filteredTodo,
    List<ModelTodo>? listTodo,
  }) {
    return MainMenuLoaded(
      filteredTodo: filteredTodo ?? this.filteredTodo,
      selectedTodo: selectedTodo,
      listTodo: listTodo ?? this.listTodo,
    );
  }

  @override
  List<Object?> get props => [selectedTodo, filteredTodo, listTodo];
}
