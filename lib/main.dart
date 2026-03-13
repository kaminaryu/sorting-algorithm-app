import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const List<String> sortingAlgorithms = [
    "Bubble",
    "Selection",
    "Insertion",
];

void main(List<String> arguments) {
    runApp(const MainApp());
}

class MainApp extends StatelessWidget {
    const MainApp({super.key});

    @override
    Widget build(BuildContext context) {
        return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
            title: Align(
                alignment: Alignment.center,
                child: Text("Sorting Algorithms"),
            ),
            backgroundColor: Colors.grey,
            ),
            body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [BarsContainer(67), Form()],
            ),
        ),
        );
    }
}


class BarsContainer extends StatefulWidget {
    const BarsContainer(this.barsCount, {super.key});

    final int barsCount;

    @override
    State<BarsContainer> createState() => _BarsContainerState();
}

class _BarsContainerState extends State<BarsContainer> {
    final double containerWidth = 240;
    final double containerHeight = 240;
    final double topPadding = 20;

    @override
    Widget build(BuildContext context) {
        // generate bars
        final List<double> bars = List.generate(widget.barsCount, (i) => (i+1).toDouble());
        final double maxValue = bars.reduce((x, y) => x > y ? x : y);

        // calculate bar heights
        List<double> barHeightsPercentage = bars.map((value) => value / maxValue).toList();
        List<double> barHeights = barHeightsPercentage.map((perc) => (containerHeight - topPadding) * perc).toList();

        return Container(
            width: containerWidth,
            height: containerHeight,
            margin: EdgeInsets.all(32),
            padding: EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
                border: Border.all(
                    color: Colors.black,
                    width: 2,
                ),
                borderRadius: BorderRadius.circular(20),
                color: Color(0xFFdedede),
            ),
            child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: barHeights.map((bar) => Expanded(
                    child: Container(
                        height: bar,
                        margin: EdgeInsets.symmetric(horizontal: 0),
                        decoration: BoxDecoration(
                            color: Colors.purple,
                            border: Border.all(
                                color: Colors.black,
                                width: 1,
                            ),
                        ),
                    )
                )).toList(),
            ),
        );
    }
}


class Form extends StatefulWidget {
    const Form({super.key});

    @override
    State<Form> createState() => _FormState();
}

class _FormState extends State<Form> {
    final _sortingAlgorithmCtrl = TextEditingController();

    String? selectedAlgorithm;
    // void a = 

    @override
    void dispose() {
        _sortingAlgorithmCtrl.dispose();
        super.dispose();
    }

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
                        initialValue: selectedAlgorithm,
                        decoration: InputDecoration(
                            labelText: "Choose a sorting algorithm"
                        ),
                        items: sortingAlgorithms.map(
                            (opt) => DropdownMenuItem(
                                value: opt,
                                child: Text(opt),
                            )
                        ).toList(),
                        onChanged: (alg) => setState(() => selectedAlgorithm = alg)
                    ),
                    Text(" "),
                    TextField(
                        controller: _sortingAlgorithmCtrl,
                        keyboardType: TextInputType.numberWithOptions(),
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        decoration: InputDecoration(labelText: "Number of Items"),
                    ),
                ],
            )
        );
    }
}



