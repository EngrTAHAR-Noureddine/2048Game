import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:game2048/redux/state/MainState.dart';
import 'package:game2048/redux/store/MainStore.dart';
import 'package:game2048/ui/view/GameHome.dart';

void main() {
  MainStore().initialize();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider<MainState>(
      store: MainStore().store,
      child: MaterialApp(
        title: '2048',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const GameHome(),
      ),
    );
  }
}
