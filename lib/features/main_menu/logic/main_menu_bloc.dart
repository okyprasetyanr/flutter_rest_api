import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_restful_api/connection/delete_api.dart';
import 'package:flutter_restful_api/connection/get_api.dart';
import 'package:flutter_restful_api/connection/update_api.dart';
import 'package:flutter_restful_api/features/main_menu/logic/main_menu_event.dart';
import 'package:flutter_restful_api/features/main_menu/logic/main_menu_state.dart';
import 'package:flutter_restful_api/models/model_data/model_todo.dart';
import 'package:flutter_restful_api/models/model_data/model_todo_parent.dart';

class MainMenuBloc extends Bloc<MainMenuEvent, MainMenuState> {
  MainMenuBloc() : super(MainMenuInitial()) {
    on<MainMenuGetData>(_getData);
    on<MainMenuResetSelected>(_resetSelected);
    on<MainMenuAdd>(_add);
    on<MainMenuUpdateTodo>(_updateTodo);
    on<MainMenuResetSnackBarStatus>(_reseetSnackBarStatus);
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

  FutureOr<void> _add(MainMenuAdd event, Emitter<MainMenuState> emit) {
    final currentState = state as MainMenuLoaded;
    final listData = currentState.listTodo.toList();
    final index = listData.indexWhere((element) => element.id == event.data.id);

    if (index != -1) {
      listData[index] = event.data;
    } else {
      listData.add(event.data);
    }
    emit(currentState.copyWith(listTodo: listData));
  }

  Future<void> _updateTodo(
    MainMenuUpdateTodo event,
    Emitter<MainMenuState> emit,
  ) async {
    final currentState = state as MainMenuLoaded;
    final data = await updateDataTodo(event.idItem);
    final listData = List<ModelTodo>.from(currentState.listTodo);
    final index = listData.indexWhere((element) => element.id == event.idItem);
    if (index != -1 && data.$2 != null) {
      listData[index] = data.$2!;
    }
    emit(
      currentState.copyWith(
        isSnackbarActive: true,
        meesageSnackBar: data.$1,
        listTodo: listData,
      ),
    );
    add(MainMenuResetSnackBarStatus());
  }

  Future<void> _deleteTodo(
    MainMenuDeleteTodo event,
    Emitter<MainMenuState> emit,
  ) async {
    final currentState = state as MainMenuLoaded;
    final data = await deleteDataTodo(event.idItem);
    final listData = List<ModelTodo>.from(currentState.listTodo);
    if (data.$2 != null) {
      listData.removeWhere((element) => element.id == data.$2!.id);
    }
    emit(
      currentState.copyWith(
        listTodo: listData,
        isSnackbarActive: true,
        meesageSnackBar: data.$1,
      ),
    );
    add(MainMenuResetSnackBarStatus());
  }

  FutureOr<void> _reseetSnackBarStatus(
    MainMenuResetSnackBarStatus event,
    Emitter<MainMenuState> emit,
  ) {
    emit((state as MainMenuLoaded).copyWith(isSnackbarActive: false));
  }
}
