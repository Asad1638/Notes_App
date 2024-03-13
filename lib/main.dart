import 'package:flutter/material.dart';

import 'package:hive_flutter/adapters.dart';



import 'models/notes_model.dart';
import 'widgets/home.dart';

void main()async {
    await Hive.initFlutter();
 Hive.registerAdapter(NotesModelAdapter());

  await Hive.openBox('Notes');
  runApp(const MyApp());
  

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
     brightness: Brightness.dark,
        useMaterial3: true,
      ),debugShowCheckedModeBanner: false,
      home: const Home(),
    );
  }
}

