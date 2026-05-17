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

class MainMenuAdd extends MainMenuEvent {
  final ModelTodo data;

  MainMenuAdd({required this.data});
}
