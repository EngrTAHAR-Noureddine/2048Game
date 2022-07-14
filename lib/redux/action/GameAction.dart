
import 'dart:math';

import '../../model/Board.dart';
import '../state/MovementState.dart';

class GameAction {
  static final GameAction _gameController = GameAction._internal();

  factory GameAction() {
    return _gameController;
  }

  GameAction._internal();



  /* ------------- functions ------------------------- */

  // make board(matrix) as symmetric matrix , and a symmetric of symmetric matrix is Board same
  Board _symmetricMatrix(Board board){

    List<List<int>> oldMatrix = [board.firstRow, board.secondRow, board.thirdRow, board.fourthRow];
    List<List<int>> newMatrix = [[0,0,0,0], [0,0,0,0], [0,0,0,0], [0,0,0,0]];

    for(int i= 0 ; i<4 ; i++){

      for(int j=0; j<4; j++){

        newMatrix[i][j] = oldMatrix[j][i];

      }

    }

    Board newBoard = Board(firstRow: newMatrix[0], secondRow: newMatrix[1], thirdRow: newMatrix[2], fourthRow: newMatrix[3]);

    return newBoard;
  }

  // add a random number of this list in random index of blink size
  final List<int> _randomList = [0,2,4];
  Map<String,int> _addRandomNumber(int blinkSize){
    final random = Random();

    int index = random.nextInt(blinkSize);
    int number = _randomList[random.nextInt(_randomList.length)];

    return {
      "index" : index,
      "number": number
    };
  }

  //calculate row of matrix
  List<int> _newRow(List<int> row , bool isToLeftUp){

    List<int> newRow = [0,0,0,0];

    if(isToLeftUp){
      for(int i = 0 ; i < row.length - 1  ; i++){

        newRow[i] = row[i] + row[i+1];
        row[i+1] = 0;

      }
    }else{
      for(int i = row.length - 1 ; i > 0  ; i--){

        newRow[i] = row[i] + row[i-1];
        row[i-1] = 0;

      }
    }

    return newRow;
  }

  //calculate the rows and fill the blink field with a random number
  Board _calculateNewBoard(Board board , bool isToLeftUp){
    List<List<int>> ourMatrix = [board.firstRow, board.secondRow, board.thirdRow, board.fourthRow];
    List<List<int>> newMatrix = [[0,0,0,0], [0,0,0,0], [0,0,0,0], [0,0,0,0]];

    for(int i= 0 ; i<4 ; i++){

      newMatrix[i] = _newRow(ourMatrix[i], isToLeftUp);
      int blinkSize = newMatrix[i].where((element) => element == 0).length;
      Map<String,int> addingNumber = _addRandomNumber(blinkSize);
      newMatrix[i][addingNumber["index"]!] = addingNumber["number"]!;

    }

    Board newBoard = Board(firstRow: newMatrix[0], secondRow: newMatrix[1], thirdRow: newMatrix[2], fourthRow: newMatrix[3]);

    return newBoard;
  }

  /* __________________________________________________________ */



  /* ------------- Initialize Movement ---------------- */

  // initialize our Board
  MovementState startMoving(MovementState state){

    MovementState newState = state;

    Board newBoard = _calculateNewBoard(state.board , false);

    newState.board = newBoard;

    return newState;
  }

  /* _____________________________________________________ */

  /* ---------------- The Movement ------------------------ */


  // make our board to symmetric and calculate with isToLeftUp is true after return our board with symmetric of symmetric matrix
  MovementState moveToUp(MovementState state){

    MovementState newState = state;

    Board newBoard = _symmetricMatrix( _calculateNewBoard(_symmetricMatrix(state.board) , true) );

    newState.board = newBoard;

    return newState;
  }

  // make our board to symmetric and calculate with isToLeftUp is false after return our board with symmetric of symmetric matrix
  MovementState moveToDown(MovementState state){
    MovementState newState = state;

    Board newBoard = _symmetricMatrix( _calculateNewBoard(_symmetricMatrix(state.board) , false) );

    newState.board = newBoard;

    return newState;
  }

  //  calculate our Board with isToLeftUp is false without symmetric
  MovementState moveToRight(MovementState state){
    MovementState newState = state;

    Board newBoard =  _calculateNewBoard(state.board , false);

    newState.board = newBoard;

    return newState;
  }

  //calculate our Board with isToLeftUp is true without symmetric
  MovementState moveToLeft(MovementState state){
    MovementState newState = state;

    Board newBoard = _calculateNewBoard(state.board , true) ;

    newState.board = newBoard;

    return newState;
  }

  /* __________________________________________________ */

}