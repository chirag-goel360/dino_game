import 'package:dino_run/screens/main_menu.dart';
import 'package:flutter/material.dart';

class GameOverMenu extends StatelessWidget {
  final int score;
  final Function onRestartPressed;
  const GameOverMenu({Key key, @required this.score, @required this.onRestartPressed}) : assert(score!=null), assert(onRestartPressed!=null), super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        color: Colors.black.withOpacity(0.5),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 100,
            vertical: 50,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Game Over',
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                ),
              ),
              Text(
                'Your score was $score',
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      right: 2,
                    ),
                    child: RaisedButton(
                      child: Text(
                        'Retry',
                        style: TextStyle(
                          fontSize: 30,
                        ),
                      ),
                      onPressed: () {
                        onRestartPressed.call();
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 2,
                    ),
                    child: RaisedButton(
                      child: Text(
                        'Main Menu',
                        style: TextStyle(
                          fontSize: 30,
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => MainMenu()),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}