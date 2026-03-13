import 'package:flutter/material.dart';
import 'package:sorting_algorithm/algorithms/bubble.dart';

import 'widgets/bars.dart';
import 'widgets/form.dart';
import 'widgets/controls.dart';

void main(List<String> arguments) {
    runApp(const MainApp());
}

class MainApp extends StatelessWidget {
    const MainApp({super.key});

    @override
    Widget build(BuildContext context) {
        return MaterialApp(
            home: Home(),
        );
    }
}

class Home extends StatefulWidget {
    const Home({super.key});

    @override
    State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
    final int _defaultBarCount = 67;
    final _barCountCtrl = TextEditingController(text: "67");
    late List<double> bars = List.generate(_defaultBarCount, (i) => (i+1).toDouble());
    String? selectedAlgorithm;


    void _generateBars() {
        setState(() {
            int barsCount = int.tryParse(_barCountCtrl.text) ?? _defaultBarCount;

            // limit cuz the shit might kill itself
            if (barsCount <= 0 || barsCount >= 5000) barsCount = _defaultBarCount;

            // generate the bars
            bars = List.generate(barsCount, (i) => (i+1).toDouble());
        });
    }

    void _shuffleBars() {
        setState(() {
            bars.shuffle();
        });
    }

    void _runAlgorithm() async {
        await for (final state in bubbleSort(bars)) {
            setState(() => bars = state);
        }
    }

    void _pauseAlgorithm() {
        
    }

    @override
    void dispose() {
        _barCountCtrl.dispose();
        super.dispose();
    }

    @override
    Widget build(BuildContext context) {

        return Scaffold(
            appBar: AppBar(
                title: Align(
                    alignment: Alignment.center,
                    child: Text("Sorting Algorithms"),
                ),
                backgroundColor: Colors.grey,
            ),
            body: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                    BarsContainer(bars), 
                    SortingOptions(
                        barCountCtrl: _barCountCtrl,
                        selectedAlgorithm: selectedAlgorithm,
                        onSelectedAlgorithmChange: (alg) => setState(() => selectedAlgorithm = alg),
                        onBarCountChange: () => _generateBars(),

                    ),
                    Controls(
                        onShuffleClick: () => _shuffleBars(),
                        onStartClick: () => _runAlgorithm(),
                        onPauseClick: () => _pauseAlgorithm(),
                    ),
                ],
            ),
        );
    }
}
