import 'package:creditapp/features/todos/data/i_todo_facade.dart';
import 'package:creditapp/features/todos/presentation/provider/todoprovider.dart';
import 'package:creditapp/features/todos/presentation/view/todo_screen.dart';
import 'package:creditapp/general/di/injection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependency();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => TodoProvider(iTodofacade: sl<ITodofacade>()),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const Todoscreen(),
      ),
    );
  }
}
