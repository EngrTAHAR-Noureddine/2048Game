

import 'package:game2048/redux/state/MainState.dart';

import 'MovementReducer.dart';

MainState mainReducer(MainState state, action) {
  return MainState(
    movementState: movementReducer(state.movementState, action),
  );
}