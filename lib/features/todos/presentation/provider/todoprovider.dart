import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:creditapp/features/todos/data/i_todo_facade.dart';
import 'package:creditapp/features/todos/data/model/todo_model.dart';
import 'package:flutter/material.dart';

class TodoProvider extends ChangeNotifier {
  final ITodofacade iTodofacade;
  TodoProvider({required this.iTodofacade});

  TextEditingController todoAmountController = TextEditingController();
  TextEditingController todoitemController = TextEditingController();
  bool isCredited = true;
  bool isFetching = false;

  List<TodoModel> todoList = [];

  void toggleCreditedUpdate(bool value) {
    isCredited = value;
    notifyListeners();
  }

  void addTodoLocally(TodoModel todo) {
    todoList.insert(0, todo);
    notifyListeners();
  }

  void cleartextfield() {
    todoAmountController.clear();
    todoitemController.clear();
  }

  Future<void> uploadTodo({
    required void Function() onFailure,
    required void Function() onSuccess,
  }) async {
    final result = await iTodofacade.uploadTodo(
      todoModel: TodoModel(
        title: todoitemController.text,
        amount: num.parse(todoAmountController.text),
        isCredited: isCredited,
      ),
    );
    result.fold(
      (err) {
        log(err.errorMessage);
        onFailure.call();
      },
      (success) {
        cleartextfield();
        addTodoLocally(success);

        onSuccess.call();
      },
    );
    notifyListeners();
  }

  void clearTodoList() {
    iTodofacade.clearData();
    todoList = [];
    notifyListeners();
  }

  Future<void> _fetchTodo({int? filterOlder, String? search}) async {
    isFetching = true;
    notifyListeners();
    final result = await iTodofacade.fetchTodo();
    result.fold(
      (err) {
        log(err.errorMessage);
      },
      (success) {
        todoList.addAll(success);
      },
    );
    isFetching = false;
    notifyListeners();
  }

  Map<String, dynamic> totals = {
      "totalCredit": 0,
      "totalDebit": 0,
      "netProfit": 0
    };

    Future<void> fetchTotals() async {
      final metaRef =
          FirebaseFirestore.instance.collection('metaData').doc('totals');

      final metaDoc = await metaRef.get();
      if (metaDoc.exists) {
        totals = metaDoc.data() as Map<String, dynamic>;
        notifyListeners();
      }
    }

  Future<void> initData({
    required ScrollController scrollController,
  }) async {
    clearTodoList();
    fetchTotals();

    _fetchTodo();
    scrollController.addListener(
      () {
        if (scrollController.position.pixels ==
                scrollController.position.maxScrollExtent &&
            !isFetching) {
          _fetchTodo();
          // log("scroll$sortedOption");
        }
      },
    );
  }

  Future<void> deleteTodo({required String todoId}) async {
    final result = await iTodofacade.deleteTodo(todoId: todoId);
    result.fold(
      (err) {
        log(err.errorMessage);
      },
      (success) {
        removeTodoLocally(todoId);
        log("deleted");
      },
    );
    notifyListeners();
  }

  void removeTodoLocally(String todoId) {
    final index = todoList.indexWhere((todo) => todo.id == todoId);

    if (index != -1) {
      todoList.removeAt(index);

      notifyListeners();
    }
  }
}
