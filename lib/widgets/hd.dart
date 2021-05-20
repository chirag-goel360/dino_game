import 'package:flutter/material.dart';

class HD extends StatelessWidget {
  final Function onPausePressed;
  final ValueNotifier<int> life;
  const HD({Key key, @required this.onPausePressed, @required this.life})
      : assert(onPausePressed != null),
        assert(life != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: Icon(
            Icons.pause,
            color: Colors.white,
            size: 30,
          ),
          onPressed: () {
            onPausePressed.call();
          },
        ),
        ValueListenableBuilder(
          valueListenable: life,
          builder: (BuildContext context, value, Widget child) {
            final List<Widget> list = [];
            for (int i = 0; i < 5; i++) {
              list.add(
                Icon(
                  (i < value) ? Icons.favorite : Icons.favorite_border,
                  color: Colors.red,
                ),
              );
            }
            return Row(
              children: list,
            );
          },
        ),
      ],
    );
  }
}
