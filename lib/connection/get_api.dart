import 'package:dio/dio.dart';
import 'package:flutter_restful_api/models/from_json.dart';
import 'package:flutter_restful_api/models/model_data/model_todo.dart';
import 'package:flutter_restful_api/models/model_data/model_todo_parent.dart';

final dio = Dio();
Future<ModelTodoParent?> getApiTodoList({int? limit, int? skip}) async {
  final data = await dio.get(
    'https://dummyjson.com/todos',
    queryParameters: {
      if (limit != null) 'limit': limit,
      if (skip != null) 'skip': skip,
    },
  );
  if (data.statusCode == 200) {
    return fromJsonTodoParent(data.data as Map<String, dynamic>);
  }
  return null;
}

Future<ModelTodoParent?> getApiTodoByUser({required int id}) async {
  final data = await dio.get('https://dummyjson.com/todos/user/$id');
  if (data.statusCode == 200) {
    return fromJsonTodoParent(data.data as Map<String, dynamic>);
  }
  return null;
}

Future<ModelTodo?> getApiTodoById({required int id}) async {
  final data = await dio.get('https://dummyjson.com/todos/$id');
  if (data.statusCode == 200) {
    return fromJsonTodo(data.data as Map<String, dynamic>);
  }
  return null;
}
