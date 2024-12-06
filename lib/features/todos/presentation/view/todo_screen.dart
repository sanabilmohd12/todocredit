import 'package:creditapp/features/todos/presentation/provider/todoprovider.dart';
import 'package:creditapp/features/todos/presentation/view/widgets/todopopup.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Todoscreen extends StatefulWidget {
  const Todoscreen({super.key});

  @override
  State<Todoscreen> createState() => _TodoscreenState();
}

class _TodoscreenState extends State<Todoscreen> {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
      final ScrollController scrollController = ScrollController();

     @override
  void initState() {
    final todoProvider = Provider.of<TodoProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        todoProvider.initData(scrollController: scrollController);
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      
      backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Colors.blue,
        title:  const Text('Transactions',style: TextStyle(color: Colors.white),),),


      body: Consumer<TodoProvider>(
        builder: (context,todopro,child) {
           
          return ListView.builder(
            itemCount: todopro.todoList.length,
            shrinkWrap: true,
            physics: const ScrollPhysics(),
            itemBuilder: (context, index) {
                        final todos = todopro.todoList[index];

              return ListTile(contentPadding: const EdgeInsets.fromLTRB(1,4,24,4),
                title: Text(todos.title),
                subtitle:  Text(todos.amount.toString()),
                leading: IconButton(onPressed: () {
                  
                  // todopro.deleteTodo(todos[index].id);
                }, icon: const Icon(Icons.delete_forever_outlined,color: Colors.red,)),
                trailing:  Text(todos.isCredited ? 'Credited'  : 'Debited', style:todos.isCredited ? const TextStyle(color: Colors.green):const TextStyle(color: Colors.red)),
              );
            
            
          },);
        }
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        addItemPopup(context,formKey:_formKey );
      },),
    );
  }
}