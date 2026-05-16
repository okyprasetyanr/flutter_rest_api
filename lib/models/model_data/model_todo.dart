class ModelTodo {
  final int id;
  final String todo;
  final bool completed;
  final int userId;
  final bool isDeleted;
  final DateTime? deletedOn;

  ModelTodo({
    required this.id,
    required this.todo,
    required this.completed,
    required this.userId,
    required this.isDeleted,
    required this.deletedOn,
  });
}
