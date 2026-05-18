import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_restful_api/models/convert_json/from_json.dart';
import 'package:flutter_restful_api/models/model_data/model_todo.dart';

final dio = Dio();
Future<(String, ModelTodo?)> updateDataTodo(int id) async {
  try {
    final response = await dio.put(
      'https://dummyjson.com/todos/$id',
      data: {'completed': true},
    );
    debugPrint("Log UpdateDataTodo: ${fromJsonTodo(response.data)}");
    return ("Berhasil", fromJsonTodo(response.data));
  } on DioException catch (e) {
    debugPrint("Log UpdateDataTodo: ${e.message}");
    return (e.message.toString(), null);
  }
}
