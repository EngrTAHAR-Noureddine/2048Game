
import 'package:game2048/model/Board.dart';

class MovementState{

  Board board;

  MovementState({required this.board});

  factory MovementState.initial() => MovementState(board: Board(firstRow: [0,0,0,0] , fourthRow: [0,0,0,0], secondRow: [0,0,0,0] ,thirdRow: [0,0,0,0]));

}