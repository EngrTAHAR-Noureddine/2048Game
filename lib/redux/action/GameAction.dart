
import 'dart:math';

import '../../controller/GameController.dart';
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
  final List<int> _randomList = [2,4];

  //calculate row of matrix
  List<int> _newRow(List<int> row , bool isToLeftUp){

    List<int> newRow = List.generate(row.length, (index) => row[index]);

    if(isToLeftUp){
      for(int i = 0 ; i < row.length - 1  ; i++){

        if(newRow[i] == newRow[i+1]){
          newRow[i] = newRow[i] + newRow[i+1];
          newRow[i+1] = 0;
        }


      }
    }else{
      for(int i = row.length - 1 ; i > 0  ; i--){
        if(newRow[i] == newRow[i-1] || newRow[i] == 0) {
          newRow[i] = newRow[i] + newRow[i - 1];
          newRow[i - 1] = 0;
        }
      }
    }

    return newRow;
  }

  //calculate the rows and fill the blink field with a random number
  Board _calculateNewBoard(Board board , bool isToLeftUp){

    List<List<int>> tempMatrix = [].generateMatrix(board);
    List<List<int>> ourMatrix = List.generate(tempMatrix.length, (index1) => List.generate(tempMatrix[index1].length, (index2) => tempMatrix[index1][index2]));
    List<List<int>> newMatrix = List.generate(tempMatrix.length, (index1) => List.generate(tempMatrix[index1].length, (index2) => tempMatrix[index1][index2]));


    List<int> maxValues = [];
    final random = Random();

    final rowChosen = random.nextInt(4);


    for(int i= 0 ; i<4 ; i++){

      ourMatrix[i].shiftZero(toRight:isToLeftUp);

      newMatrix[i] = _newRow(ourMatrix[i], isToLeftUp);

      newMatrix[i].shiftZero(toRight:isToLeftUp);

      int val = newMatrix[i].getMaximun();
      maxValues.add(val);

      // Add random Number
      if(rowChosen == i){

        int findIndexZero = newMatrix[i].indexOf(0);
        if(findIndexZero >=0)newMatrix[i][findIndexZero] = _randomList[random.nextInt(_randomList.length)];
      }


    }



    GameController().scoreGame = maxValues.getMaximun();

    GameController().gameOver = tempMatrix.isTheSame(newMatrix);


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
    GameController().scoreGame = 0;
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
  //calculate our Board with isToLeftUp is true without symmetric
  MovementState initGame(MovementState state){

    return startMoving(MovementState.initial());
  }

  /* __________________________________________________ */

}

extension on List {

  void shiftZero({bool toRight = true}){

    //print(toRight);

    if(toRight){
      for(int i=0; i< length -1 ; i++){
        for(int j = i+1 ; j < length ; j++){
          if(this[i] == 0 ) {
            this[i] = this[j];
            this[j] = 0;
          }
        }
      }
    }else{
      for(int i= length -1; i > 0 ; i--){
        for(int j = i-1  ; j >= 0 ; j--){

          if(this[i] == 0 ) {
            this[i] = this[j];
            this[j] = 0;
          }
        }
      }
    }
  }

  int getMaximun(){
    List<int> list  = this as List<int>;
    int max = list.reduce((max, element){
      if(max > element){
        return max;
      } else {
        return element;
      }
    });
    return max;
  }

  List<List<int>> generateMatrix(Board board){
    List<int> first = List.generate(board.firstRow.length, (index) => board.firstRow[index]);
    List<int> second = List.generate(board.secondRow.length, (index) => board.secondRow[index]);
    List<int> third = List.generate(board.thirdRow.length, (index) => board.thirdRow[index]);
    List<int> four = List.generate(board.fourthRow.length, (index) => board.fourthRow[index]);

    List<List<int>> list = [];
    list.add(first);
    list.add(second);
    list.add(third);
    list.add(four);

    return list;
  }


  bool isTheSame(List<List<int>> two){
    List<List<int>> one = List.generate(length, (index) => List.generate(this[index].length , (i)=>this[index][i]));
    List<bool> same = [];

    for(int i =0 ; i<=one.length -1; i++){

      for(int j=0; j<=one[i].length-1;j++){

        if(two[i][j] == one[i][j] && two[i][j]>0) same.add(true);
      }

    }


    return same.length == 16;
  }

}