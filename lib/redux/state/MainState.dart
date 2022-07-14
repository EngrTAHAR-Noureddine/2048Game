import 'package:game2048/redux/state/MovementState.dart';

import '../action/GameAction.dart';

class MainState {

  final MovementState movementState;

  MainState({required this.movementState,});


  factory MainState.initial() => MainState(movementState: GameAction().startMoving(MovementState.initial()));

  MainState copyWith({MovementState? moveState,}) {

    return MainState( movementState: moveState ?? movementState, );

  }
}