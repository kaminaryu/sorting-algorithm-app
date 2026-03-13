import 'dart:async';

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
    final _delayCtrl = TextEditingController(text: "5");
    late List<double> bars = List.generate(_defaultBarCount, (i) => (i+1).toDouble());
    String? selectedAlgorithm;

    StreamSubscription<List<double>>? _visualSub;

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
        _visualSub?.cancel();
        setState(() {
            bars.shuffle();
        });
    }

    void _runAlgorithm() async {
        final delay = int.tryParse(_delayCtrl.text) ?? 5;
        _visualSub = bubbleSort(bars, delay).listen((state) {
            setState(() => bars = state);
        });
        // await for (final state in bubbleSort(bars, delay)) {
        //     setState(() => bars = state);
        // }
    }

    void _pauseAlgorithm() {
        _visualSub?.pause();
        print("Paued");
    }

    void _resumeAlgorithm() {
        _visualSub?.resume();
        print("Resume");
    }

    @override
    void dispose() {
        _barCountCtrl.dispose();
        _visualSub?.cancel();
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
                        delayCtrl: _delayCtrl,
                        selectedAlgorithm: selectedAlgorithm,
                        onSelectedAlgorithmChange: (alg) => setState(() => selectedAlgorithm = alg),
                        onBarCountChange: () => _generateBars(),
                        onDelayChange: () => setState(() {}),
                    ),
                    Controls(
                        onShuffleClick: () => _shuffleBars(),
                        onStartClick: () => _runAlgorithm(),
                        onPauseClick: () => _pauseAlgorithm(),
                        onResumeClick: () => _resumeAlgorithm(),
                    ),
                ],
            ),
        );
    }
}
