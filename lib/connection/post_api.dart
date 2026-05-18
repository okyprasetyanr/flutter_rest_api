import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_restful_api/enum/enum_model_data.dart';
import 'package:flutter_restful_api/models/convert_json/from_json.dart';
import 'package:flutter_restful_api/models/convert_json/to_json.dart';
import 'package:flutter_restful_api/models/model_data/model_todo.dart';

final dio = Dio();
Future<(String, ModelTodo?)> postAddTodo(ModelTodo data) async {
  try {
    final removeField = toJsonTodo(data);
    removeField.remove(EnumModelTodo.isDeleted.name);
    removeField.remove(EnumModelTodo.id.name);
    removeField.remove(EnumModelTodo.deletedOn.name);
    final response = await dio.post(
      'https://dummyjson.com/todos/add',
      data: toJsonTodo(data),
    );
    debugPrint("Response PostAddTOdo Success: ${response.data}");
    return ("Sukses", fromJsonTodo(response.data));
  } on DioException catch (e) {
    debugPrint("Response PostAddTOdo Error: ${e.message}");
    return (e.message!, null);
  }
}
