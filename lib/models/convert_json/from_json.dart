import 'package:flutter_restful_api/enum/enum_model_data.dart';
import 'package:flutter_restful_api/models/model_data/model_todo.dart';
import 'package:flutter_restful_api/models/model_data/model_todo_parent.dart';

ModelTodo fromJsonTodo(Map<String, dynamic> data) {
  return ModelTodo(
    id: data[EnumModelTodo.id.name],
    todo: data[EnumModelTodo.todo.name],
    completed: data[EnumModelTodo.completed.name] ?? false,
    userId: data[EnumModelTodo.userId.name],
    isDeleted: data[EnumModelTodo.isDeleted.name] ?? false,
    deletedOn: data[EnumModelTodo.deletedOn.name],
  );
}

ModelTodoParent fromJsonTodoParent(Map<String, dynamic> data) {
  return ModelTodoParent(
    todos: (data[EnumModelTodoParent.todos.name] as List)
        .map((e) => fromJsonTodo(e as Map<String, dynamic>))
        .toList(),
    total: data[EnumModelTodoParent.total.name],
    skip: data[EnumModelTodoParent.skip.name],
    limit: data[EnumModelTodoParent.limit.name],
  );
}
