import 'package:game2048/redux/reducer/MainReducer.dart';

import '../state/MainState.dart';
import 'package:redux/redux.dart';

class MainStore{
  static final MainStore _mainStore = MainStore._internal();

  factory MainStore() {
    return _mainStore;
  }

  MainStore._internal();

  late Store<MainState> store;

  initialize(){

    store = Store<MainState>(
      mainReducer ,
      initialState: MainState.initial(),
    );

  }

}