

import 'package:game2048/redux/state/MovementState.dart';

import '../model/Board.dart';

class GameController{
  static final GameController _gameController = GameController._internal();

  factory GameController() {
    return _gameController;
  }

  GameController._internal();


  int scoreGame = 0;

  bool gameOver = false;

  Board oldBoard = MovementState.initial().board;


}

