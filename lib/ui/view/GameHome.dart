import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:game2048/redux/action/Movement.dart';
import 'package:game2048/redux/state/MainState.dart';
import 'package:game2048/ui/component/CardNumber.dart';

import '../../model/Board.dart';

class GameHome extends StatelessWidget {
  const GameHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {



    return Scaffold(
      appBar: AppBar(
        title: const Text("2048",),
        centerTitle: true,
      ),

      body:StoreConnector<MainState, dynamic>(
        converter: (store) => store,
        builder: (context,  store) {

          return  Center(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                color: Colors.grey,
                height:  MediaQuery.of(context).size.width,
                width:  MediaQuery.of(context).size.width,

                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onHorizontalDragEnd: (DragEndDetails d) {
                    if (d.primaryVelocity! > 0) {
                      ActionModel actionModel = ActionModel(type: Move.RIGHT);
                      store.dispatch(actionModel);
                    } else {
                      ActionModel actionModel = ActionModel(type: Move.LEFT);
                      store.dispatch(actionModel);
                    }
                  },
                  onVerticalDragEnd: (DragEndDetails d) {
                    if (d.primaryVelocity! > 0) {
                      ActionModel actionModel = ActionModel(type: Move.DOWN);
                      store.dispatch(actionModel);
                    } else {
                      ActionModel actionModel = ActionModel(type: Move.UP);
                      store.dispatch(actionModel);
                    }
                  },
                  child: const GameGrid(),
                ),


              ),
            ),
          );
        }

      ),

    );
  }
}

class GameGrid extends StatelessWidget{
  const GameGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

   double side = (MediaQuery.of(context).size.width - 20) / 4;

   return StoreConnector<MainState, Board>(
       converter: (store) => store.state.movementState.board,
       builder: (context,  board) {

         return ListView(
           children: [
             Row(children: List.generate(board.firstRow.length, (index) => cardNumber(number: board.firstRow[index], side: side)),),

             Row(children: List.generate(board.secondRow.length, (index) => cardNumber(number: board.secondRow[index], side: side)),),

             Row(children: List.generate(board.thirdRow.length, (index) => cardNumber(number: board.thirdRow[index], side: side)),),

             Row(children: List.generate(board.fourthRow.length, (index) => cardNumber(number: board.fourthRow[index], side: side)),)
           ],
         );

       });
  }

}
