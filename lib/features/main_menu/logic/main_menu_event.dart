import 'package:flutter_restful_api/models/model_data/model_todo.dart';

class MainMenuEvent {}

class MainMenuGetData extends MainMenuEvent {
  final int? limit;
  final int? skip;
  final int? idUser;
  final int? idItem;

  MainMenuGetData({this.limit, this.skip, this.idUser, this.idItem});
}

class MainMenuResetSelected extends MainMenuEvent {}

class MainMenuUpdateTodo extends MainMenuEvent {
  final int idItem;

  MainMenuUpdateTodo({required this.idItem});
}

class MainMenuAdd extends MainMenuEvent {
  final ModelTodo data;

  MainMenuAdd({required this.data});
}

class MainMenuDeleteTodo extends MainMenuEvent {
  final int idItem;

  MainMenuDeleteTodo({required this.idItem});
}

class MainMenuResetSnackBarStatus extends MainMenuEvent {}
