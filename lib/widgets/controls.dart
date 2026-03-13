import 'package:flutter/material.dart';

class Controls extends StatelessWidget {
    final VoidCallback onClick;

    const Controls({
        required this.onClick,
        super.key
    });

    @override
    Widget build(BuildContext context) {
        return Container(
            margin: EdgeInsets.symmetric(horizontal: 32),
            child: Row(
                children: [
                    ElevatedButton(
                    onPressed: onClick, // () => onClick() also works
                    child: Text("Shuffle"))
                ],
            ),
        );
    }
}
