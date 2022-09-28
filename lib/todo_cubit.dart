import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/todo_repository.dart';

import 'models/Todo.dart';

abstract class TodoState{}

class LoadingTodos extends TodoState{}

class ListTodosSuccess extends TodoState{
  final List<Todo> todos;

  ListTodosSuccess({required this.todos});
}

class ListTodosFailure extends TodoState{
  final Object exception;

  ListTodosFailure({required this.exception});
}

class TodoCubit extends Cubit<TodoState>{
  final _todoRepo = TodoRepository();

  TodoCubit() : super(LoadingTodos());

  void getTodos() async{
    if (state is ListTodosSuccess == false) {
      emit(LoadingTodos());
    }
    
    try{
      final todos = await _todoRepo.getTodos();
      emit(ListTodosSuccess(todos: todos));
    }catch(e){
      emit(ListTodosFailure(exception: e));
    }

  }

  void observeTodo(){
    final todosStream = _todoRepo.observeTodos();
    todosStream.listen((_) => getTodos());
  }

  void createTodo(String title) async{
    await _todoRepo.createTodo(title);
  }

  void updateTodoIsComplete(Todo todo, bool isComplete) async{
    await _todoRepo.updateTodoIsComplete(todo, isComplete);
  }

}