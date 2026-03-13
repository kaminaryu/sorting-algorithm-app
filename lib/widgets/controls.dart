import 'package:flutter/material.dart';

class Controls extends StatefulWidget {
    final VoidCallback onShuffleClick;
    final VoidCallback onStartClick;
    final VoidCallback onPauseClick;
    final VoidCallback onResumeClick;

    const Controls({
        required this.onShuffleClick,
        required this.onStartClick,
        required this.onPauseClick,
        required this.onResumeClick,
        super.key
    });

    @override
    State<Controls> createState() => _ControlsState();
}

class _ControlsState extends State<Controls> {
    bool paused = false;

    @override
    Widget build(BuildContext context) {
        return Container(
            margin: EdgeInsets.symmetric(horizontal: 32),
            child: Row(
                children: [
                    ElevatedButton(
                        onPressed: widget.onShuffleClick, // () => onClick() also works
                        child: Text("Shuffle")
                    ),
                    ElevatedButton(
                        onPressed: widget.onStartClick,
                        child: Text("Start")
                    ),
                    ElevatedButton(
                        onPressed: () => setState(() {
                            if (paused) {
                                widget.onResumeClick();
                            }
                            else {
                                widget.onPauseClick();
                            }
                            paused = !paused;
                        }),
                        child: Text(paused ? "Resume" : "Pause")
                    ),
                ],
            ),
        );
    }
}
