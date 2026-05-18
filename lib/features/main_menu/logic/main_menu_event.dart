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

class MainMenuDeleteTodo extends MainMenuEvent {
  final int idItem;

  MainMenuDeleteTodo({required this.idItem});
}

class MainMenuResetSnackBarStatus extends MainMenuEvent {}
