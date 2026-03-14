import 'package:flutter/material.dart';

class Controls extends StatefulWidget {
    final bool isPaused;
    final bool isSorting;
    final bool isShuffled;
    final VoidCallback onShuffleClick;
    final VoidCallback onStartClick;
    final VoidCallback onPauseClick;
    final VoidCallback onResumeClick;
    final VoidCallback onStopClick;

    // no way this is optimal cuh
    const Controls({
        required this.isPaused,
        required this.isSorting,
        required this.isShuffled,
        required this.onShuffleClick,
        required this.onStartClick,
        required this.onPauseClick,
        required this.onResumeClick,
        required this.onStopClick,
        super.key
    });

    @override
    State<Controls> createState() => _ControlsState();
}

class _ControlsState extends State<Controls> {
    @override
    Widget build(BuildContext context) {
        return Container(
            margin: EdgeInsets.symmetric(horizontal: 32),
            child: Row(
                children: [
                    ElevatedButton(
                        onPressed: widget.isSorting ? null : widget.onShuffleClick, // () => onClick() also works
                        child: Text("Shuffle")
                    ),
                    ElevatedButton(
                        // onPressed: widget.onStartClick,
                        onPressed: !widget.isShuffled ? null : () => setState(() {
                            if (widget.isSorting) {
                                widget.onStopClick();
                            }
                            else {
                                widget.onStartClick();
                            }
                        }),
                        child: Text(widget.isSorting ? "Stop" : "Start"),
                    ),
                    ElevatedButton(
                        onPressed: () => setState(() {
                            if (widget.isPaused) {
                                widget.onResumeClick();
                            }
                            else {
                                widget.onPauseClick();
                            }
                        }),
                        child: Text(widget.isPaused ? "Resume" : "Pause")
                    ),
                ],
            ),
        );
    }
}
