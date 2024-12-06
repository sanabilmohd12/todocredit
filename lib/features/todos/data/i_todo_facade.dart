
import 'package:creditapp/features/todos/data/model/todo_model.dart';
import 'package:creditapp/general/failure/failures.dart';
import 'package:dartz/dartz.dart';

abstract class ITodofacade {
Future<Either<MainFailure, TodoModel>> uploadTodo(
      {required TodoModel todoModel}) {
    throw UnimplementedError('uploadTodo not impl');
  }
  
Future<Either<MainFailure, List<TodoModel>>> fetchTodo() {
    throw UnimplementedError('uploadTodo not impl');
  }


void clearData();


}