import 'package:flutter_restful_api/models/model_data/model_todo.dart';

class ModelTodoParent {
  final List<ModelTodo> todos;
  final int total;
  final int skip;
  final int limit;

  ModelTodoParent({
    required this.todos,
    required this.total,
    required this.skip,
    required this.limit,
  });
}
