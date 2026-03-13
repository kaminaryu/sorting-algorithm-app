import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // text formatting

const List<String> sortingAlgorithms = [
    "Bubble",
    "Selection",
    "Insertion",
];

class SortingOptions extends StatefulWidget {
    final TextEditingController barCountCtrl;
    final String? selectedAlgorithm;
    final ValueChanged<String?> onSelectedAlgorithmChange; // like void function(String?)
    final VoidCallback onBarCountChange; // like void function()

    const SortingOptions({
        required this.barCountCtrl,
        required this.selectedAlgorithm,
        required this.onSelectedAlgorithmChange,
        required this.onBarCountChange,
        super.key,
    });

    @override
    State<SortingOptions> createState() => _SortingOptionsState();
}

class _SortingOptionsState extends State<SortingOptions> {
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
                        items: sortingAlgorithms.map(
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
                ],
            )
        );
    }
}

