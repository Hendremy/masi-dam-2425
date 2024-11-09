import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:masi_dam_2425/firebase_options.dart';
import 'package:masi_dam_2425/model/database/source/sqlite_database.dart';
import 'package:masi_dam_2425/widget_tree.dart';
import 'package:provider/provider.dart';

import 'model/database/source/datasource.dart';
import 'model/database/repository/repository_factory.dart';

Future<RepositoryFactory> initializeRepositoryFactory() async {
  final sqliteDb = await SQLiteDatabase.initDatabase();
  return RepositoryFactory(
    source: DatabaseSource.sqlite,
    sqliteDb: sqliteDb,
  );
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return FutureProvider<RepositoryFactory>(
      create: (_) => initializeRepositoryFactory(),
      initialData: RepositoryFactory(source: DatabaseSource.sqlite),
      child: MaterialApp(
        title: 'GreenMon',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const WidgetTree(),
      ),
    );

  }
}
