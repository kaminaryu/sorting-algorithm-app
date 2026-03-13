import 'package:flutter/material.dart';

class Controls extends StatelessWidget {
    final VoidCallback onShuffleClick;
    final VoidCallback onStartClick;
    final VoidCallback onPauseClick;

    const Controls({
        required this.onShuffleClick,
        required this.onStartClick,
        required this.onPauseClick,
        super.key
    });

    @override
    Widget build(BuildContext context) {
        return Container(
            margin: EdgeInsets.symmetric(horizontal: 32),
            child: Row(
                children: [
                    ElevatedButton(
                        onPressed: onShuffleClick, // () => onClick() also works
                        child: Text("Shuffle")
                    ),
                    ElevatedButton(
                        onPressed: onStartClick,
                        child: Text("Start")
                    ),
                    ElevatedButton(
                        onPressed: () => {},
                        child: Text("Pause")
                    ),
                ],
            ),
        );
    }
}
