import 'package:flutter_restful_api/enum/enum_model_data.dart';
import 'package:flutter_restful_api/models/model_data/model_todo.dart';

Map<String, dynamic> toJsonTodo(ModelTodo data) {
  return {
    EnumModelTodo.completed.name: data.completed,
    EnumModelTodo.deletedOn.name: data.deletedOn,
    EnumModelTodo.id.name: data.id,
    EnumModelTodo.isDeleted.name: data.isDeleted,
    EnumModelTodo.todo.name: data.todo,
    EnumModelTodo.userId.name: data.userId,
  };
}
