import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:json_theme/json_theme.dart';
import 'package:multi_theme_with_appainter/theme.dart';
import 'package:multi_theme_with_appainter/theme_bloc/bloc.dart';
import 'package:multi_theme_with_appainter/theme_type.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final theme = await AppTheme().init();
  runApp(MyApp(
    appTheme: theme,
  ));
}

class MyApp extends StatelessWidget {
  final AppTheme appTheme;

  const MyApp({super.key, required this.appTheme});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ThemeBloc>(
      create: (context) =>
          ThemeBloc()..add(ToggleThemeEvent(appTheme.getTheme())),
      child: BlocBuilder<ThemeBloc, ThemeType>(
        builder: (context, themeType) {
          print("${themeType}");
          return MaterialApp(
            theme: themeType == ThemeType.light ? appTheme.lightTheme : appTheme.darkTheme,
            home: MyHomePage(title: 'Flutter Demo Home Page'),
          );
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    final themeBloc = BlocProvider.of<ThemeBloc>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          themeBloc.add(ToggleThemeEvent(themeBloc.state == ThemeType.light
              ? ThemeType.dark
              : ThemeType.light));
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
