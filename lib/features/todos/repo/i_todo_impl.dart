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
  // Future<Either<MainFailure, TodoModel>> uploadTodo(
  //     {required TodoModel todoModel}) async {
  //   try {
  //     final todoRef = firestore.collection(FirebaseCollections.todos);
  //     final id = todoRef.doc().id;

  //     final user = todoModel.copyWith(id: id);

  //     await todoRef.doc(id).set(user.toMap());

  //     return right(user);
  //   } catch (e) {
  //     return left(MainFailure.serverFailure(errorMessage: e.toString()));
  //   }
  // }
  @override
Future<Either<MainFailure, TodoModel>> uploadTodo(
    {required TodoModel todoModel}) async {
  try {
    final todoRef = firestore.collection(FirebaseCollections.todos);
    final metaRef = firestore.collection('metaData').doc('totals');
    final id = todoRef.doc().id;

    final user = todoModel.copyWith(id: id);

    await todoRef.doc(id).set(user.toMap());

    final metaDoc = await metaRef.get();
    final currentTotals = metaDoc.exists
        ? metaDoc.data() as Map<String, dynamic>
        : {"totalCredit": 0, "totalDebit": 0, "netProfit": 0};

    final totalCredit = currentTotals["totalCredit"] ?? 0;
    final totalDebit = currentTotals["totalDebit"] ?? 0;

    if (todoModel.isCredited) {
      currentTotals["totalCredit"] = totalCredit + todoModel.amount;
    } else {
      currentTotals["totalDebit"] = totalDebit + todoModel.amount;
    }

    currentTotals["netProfit"] =
        currentTotals["totalCredit"] - currentTotals["totalDebit"];

    // Save the updated totals
    await metaRef.set(currentTotals);

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
  void clearData() {
    lastDocument = null;
    noMoreData = false;
  }
  
  @override
  @override
Future<Either<MainFailure, Unit>> deleteTodo({required String todoId}) async {
  try {
    final todoRef = firestore.collection(FirebaseCollections.todos);
    final metaRef = firestore.collection('metaData').doc('totals');

    // Fetch the todo item
    final todoDoc = await todoRef.doc(todoId).get();
    if (!todoDoc.exists) {
      return left(const MainFailure.serverFailure(errorMessage: "Todo not found"));
    }

    final todoData = todoDoc.data() as Map<String, dynamic>;
    final amount = todoData["amount"] as num;
    final isCredited = todoData["isCredited"] as bool;

    // Fetch the current totals
    final metaDoc = await metaRef.get();
    final currentTotals = metaDoc.exists
        ? metaDoc.data() as Map<String, dynamic>
        : {"totalCredit": 0, "totalDebit": 0, "netProfit": 0};

    // Update the totals
    final totalCredit = currentTotals["totalCredit"] ?? 0;
    final totalDebit = currentTotals["totalDebit"] ?? 0;

    if (isCredited) {
      currentTotals["totalCredit"] = totalCredit - amount;
    } else {
      currentTotals["totalDebit"] = totalDebit - amount;
    }

    currentTotals["netProfit"] =
        currentTotals["totalCredit"] - currentTotals["totalDebit"];

    // Save the updated totals
    await metaRef.set(currentTotals);

    // Delete the todo item
    await todoRef.doc(todoId).delete();

    return right(unit);
  } catch (e) {
    return left(MainFailure.serverFailure(errorMessage: e.toString()));
  }
}

}
