import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:game2048/redux/action/Movement.dart';
import 'package:game2048/redux/state/MainState.dart';
import 'package:game2048/ui/component/CardNumber.dart';

import '../../constant/custom_color.dart';
import '../../controller/GameController.dart';
import '../../model/Board.dart';

class GameHome extends StatelessWidget {
  const GameHome({super.key});

  @override
  Widget build(BuildContext context) {
    double minSize = min(
        MediaQuery.of(context).size.width, MediaQuery.of(context).size.height);

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Center(
            child: StoreConnector<MainState, dynamic>(
                converter: (store) => store,
                builder: (context, store) {
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        _header(store),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            color: boardColor,
                            height: minSize - 20,
                            width: minSize - 20,
                            child: Stack(
                              children: [
                                GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  onHorizontalDragEnd: (DragEndDetails d) {
                                    if (d.primaryVelocity! > 0) {
                                      GameController().oldBoard =
                                          store.state.movementState.board;
                                      ActionModel actionModel =
                                          ActionModel(type: Move.RIGHT);
                                      store.dispatch(actionModel);
                                    } else {
                                      GameController().oldBoard =
                                          store.state.movementState.board;
                                      ActionModel actionModel =
                                          ActionModel(type: Move.LEFT);
                                      store.dispatch(actionModel);
                                    }
                                  },
                                  onVerticalDragEnd: (DragEndDetails d) {
                                    if (d.primaryVelocity! > 0) {
                                      GameController().oldBoard =
                                          store.state.movementState.board;
                                      ActionModel actionModel =
                                          ActionModel(type: Move.DOWN);
                                      store.dispatch(actionModel);
                                    } else {
                                      GameController().oldBoard =
                                          store.state.movementState.board;
                                      ActionModel actionModel =
                                          ActionModel(type: Move.UP);
                                      store.dispatch(actionModel);
                                    }
                                  },
                                  child: const GameGrid(),
                                ),
                                (GameController().gameOver)
                                    ? Container(
                                        color:
                                            Colors.white.withValues(alpha: 0.8),
                                        child: Center(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              const Text(
                                                'Game Over',
                                                style: TextStyle(
                                                    color: headerColor,
                                                    fontSize: 48,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                '${GameController().scoreGame}',
                                                style: const TextStyle(
                                                    color: headerColor,
                                                    fontSize: 48,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    : Container()
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
          ),
        ),
      ),
    );
  }

  Widget _header(dynamic store) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      margin: const EdgeInsets.only(bottom: 50),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            '2048 Game',
            style: TextStyle(
                color: headerColor, fontSize: 48, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 30,
            width: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Text(
                    'Score  ',
                    style: TextStyle(
                        color: headerColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  ElevatedButton(
                    onPressed: null,
                    style: ButtonStyle(
                        backgroundColor:
                            WidgetStateProperty.all<Color>(textColor),
                        shape:
                            WidgetStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ))),
                    child: Text(
                      '${GameController().scoreGame}',
                      style: const TextStyle(
                          color: backgroundColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
              IconButton(
                onPressed: () {
                  ActionModel actionModel = ActionModel(type: Move.INIT);
                  store.dispatch(actionModel);
                },
                icon: const Icon(
                  Icons.loop,
                  size: 30,
                ),
                color: textColor,
              ),
            ],
          )
        ],
      ),
    );
  }
}

class GameGrid extends StatelessWidget {
  const GameGrid({super.key});

  @override
  Widget build(BuildContext context) {
    double minSize = min(
        MediaQuery.of(context).size.width, MediaQuery.of(context).size.height);

    double side = (minSize - 20) / 4;

    return StoreConnector<MainState, Board>(
        converter: (store) => store.state.movementState.board,
        builder: (context, board) {
          return SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: List.generate(
                      board.firstRow.length,
                      (index) => cardNumber(
                          number: board.firstRow[index], side: side)),
                ),
                Row(
                  children: List.generate(
                      board.secondRow.length,
                      (index) => cardNumber(
                          number: board.secondRow[index], side: side)),
                ),
                Row(
                  children: List.generate(
                      board.thirdRow.length,
                      (index) => cardNumber(
                          number: board.thirdRow[index], side: side)),
                ),
                Row(
                  children: List.generate(
                      board.fourthRow.length,
                      (index) => cardNumber(
                          number: board.fourthRow[index], side: side)),
                )
              ],
            ),
          );
        });
  }
}
