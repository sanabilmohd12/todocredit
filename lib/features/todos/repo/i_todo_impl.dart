import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:creditapp/features/todos/data/i_todo_facade.dart';
import 'package:creditapp/features/todos/data/model/todo_model.dart';
import 'package:creditapp/general/failure/failures.dart';
import 'package:creditapp/general/utils/firebase_collections.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ITodofacade)
class ITodoimpl implements ITodofacade {
  final FirebaseFirestore firestore;
  ITodoimpl(this.firestore);

  @override
  Future<Either<MainFailure, TodoModel>> uploadTodo(
      {required TodoModel todoModel}) async {
    try {
      final todoRef = firestore.collection(FirebaseCollections.todos);
      final id = todoRef.doc().id;

      final user = todoModel.copyWith(id: id);

      await todoRef.doc(id).set(user.toMap());

      return right(user);
    } catch (e) {
      return left(MainFailure.serverFailure(errorMessage: e.toString()));
    }
  }

  DocumentSnapshot? lastDocument;
  bool noMoreData = false;

  @override
  Future<Either<MainFailure, List<TodoModel>>> fetchTodo() async {
    if (noMoreData) return right([]);
    try {
      Query query = firestore
          .collection(FirebaseCollections.todos)
          .orderBy("amount", descending: true);

      if (lastDocument != null) {
        query = query.startAfterDocument(lastDocument!);
      }

      final querySnapshot = await query.limit(15).get();

      if (querySnapshot.docs.length < 15) {
        noMoreData = true;
      } else {
        lastDocument = querySnapshot.docs.last;
      }

      final newlist = querySnapshot.docs
          .map((doc) => TodoModel.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
      log("sswsw${newlist.length}");

      return right(newlist);
    } catch (e) {
      return left(MainFailure.serverFailure(errorMessage: e.toString()));
    }
  }

  @override
  @override
  void clearData() {
    lastDocument = null;
    noMoreData = false;
  }
  
  @override
  Future<Either<MainFailure, Unit>> deleteTodo({required String todoId}) async {
    
    try {
    final todoRef = firestore.collection(FirebaseCollections.todos);

    await todoRef.doc(todoId).delete();

    return right(unit); // `unit` is used for void return types in Dartz.
  } catch (e) {
    return left(MainFailure.serverFailure(errorMessage: e.toString()));
  }

  }
}
