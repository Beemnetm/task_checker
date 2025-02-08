import 'package:bloc/bloc.dart';
import 'package:task_checker/domain/models/todo.dart';
import 'package:task_checker/domain/repository/todo_repo.dart';

class TodoCubit extends Cubit<List<Todo>> {
  final TodoRepo todoRepo;

  TodoCubit(this.todoRepo) : super([]) {
    loadTodos();
  }

  Future<void> loadTodos() async {
    final todolist = await todoRepo.getTodos();

    emit(todolist);
  }

  Future<void> addTodo(String text) async {
    final newTodo = Todo(
      id: DateTime.now().millisecondsSinceEpoch,
      text: text,
    );

    await todoRepo.addTodo(newTodo);
    loadTodos();
  }

  Future<void> deleteTodo(Todo todo) async {
    await todoRepo.deleteTodo(todo);
    loadTodos();
  }

  Future<void> toggleCompletion(Todo todo) async {
    final updateTodo = todo.toggleCompletion();
    await todoRepo.updateTodo(updateTodo);

    loadTodos();
  }
}
