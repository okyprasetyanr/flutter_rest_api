import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_restful_api/connection/get_api.dart';
import 'package:flutter_restful_api/features/main_menu/logic/main_menu_event.dart';
import 'package:flutter_restful_api/features/main_menu/logic/main_menu_state.dart';
import 'package:flutter_restful_api/models/model_data/model_todo.dart';
import 'package:flutter_restful_api/models/model_data/model_todo_parent.dart';

class MainMenuBloc extends Bloc<MainMenuEvent, MainMenuState> {
  MainMenuBloc() : super(MainMenuInitial()) {
    on<MainMenuGetData>(_getData);
    on<MainMenuResetSelected>(_resetSelected);
    on<MainMenuUpdateTodo>(_updateTodo);
    on<MainMenuDeleteTodo>(_deleteTodo);
  }

  Future<void> _getData(
    MainMenuGetData event,
    Emitter<MainMenuState> emit,
  ) async {
    final currentState = state is MainMenuLoaded
        ? state as MainMenuLoaded
        : MainMenuLoaded();
    ModelTodoParent? mainData;
    ModelTodo? selectedData;
    mainData = await getApiTodoList();
    if (event.limit != null || event.skip != null) {
      mainData = await getApiTodoList(limit: event.limit, skip: event.skip);
    }
    if (event.idUser != null) {
      mainData = await getApiTodoByUser(id: event.idUser!);
    }
    if (event.idItem != null) {
      selectedData = await getApiTodoById(id: event.idItem!);
    }

    emit(
      currentState.copyWith(
        filteredTodo: mainData,
        listTodo: mainData?.todos ?? [],
        selectedTodo: selectedData,
      ),
    );
  }

  FutureOr<void> _resetSelected(
    MainMenuResetSelected event,
    Emitter<MainMenuState> emit,
  ) {
    emit((state as MainMenuLoaded).copyWith(selectedTodo: null));
  }

  Future<void> _updateTodo(MainMenuUpdateTodo event, Emitter<MainMenuState> emit) async {
    final data=await update
  }
}
