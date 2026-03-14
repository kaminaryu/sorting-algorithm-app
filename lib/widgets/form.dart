import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // text formatting

import '../data/algorithm_list.dart';

class SortingOptions extends StatefulWidget {
    final TextEditingController barCountCtrl;
    final TextEditingController delayCtrl;
    final String? selectedAlgorithm;
    final ValueChanged<String?> onSelectedAlgorithmChange; // like void function(String?)
    final VoidCallback onBarCountChange; // like void function()
    final VoidCallback onDelayChange; // like void function()

    const SortingOptions({
        required this.barCountCtrl,
        required this.delayCtrl,
        required this.selectedAlgorithm,
        required this.onSelectedAlgorithmChange,
        required this.onBarCountChange,
        required this.onDelayChange,
        super.key,
    });

    @override
    State<SortingOptions> createState() => _SortingOptionsState();
}

class _SortingOptionsState extends State<SortingOptions> {
    final _sortingAlgorithms = sortingAlgorithmsFunctions.keys;

    @override
    Widget build(BuildContext context) {
        return Container(
            margin: EdgeInsets.all(32),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                    Text(
                        "Options: ",
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                        ),
                    ),
                    Text(""),

                    DropdownButtonFormField<String>(
                        initialValue: widget.selectedAlgorithm,
                        decoration: InputDecoration(
                            labelText: "Choose a sorting algorithm"
                        ),
                        items: _sortingAlgorithms.map(
                            (opt) => DropdownMenuItem(
                                value: opt,
                                child: Text(opt),
                            )
                        ).toList(),
                        onChanged: widget.onSelectedAlgorithmChange,
                    ),
                    Text(" "),

                    TextField(
                        controller: widget.barCountCtrl,
                        keyboardType: TextInputType.numberWithOptions(),
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        decoration: InputDecoration(labelText: "Number of Items"),
                        onChanged: (_) => widget.onBarCountChange(),
                    ),
                    TextField(
                        controller: widget.delayCtrl,
                        keyboardType: TextInputType.numberWithOptions(),
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        decoration: InputDecoration(labelText: "Delay Between Comparison (ms)"),
                        onChanged: (_) => widget.onBarCountChange(),
                    ),
                ],
            )
        );
    }
}

