import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:math';

import 'widgets/bars.dart';
import 'widgets/form.dart';
import 'widgets/controls.dart';

import 'data/algorithm_list.dart';

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
    String? selectedAlgorithm = "Bubble";

    // gen default bars
    late List<double> bars = List.generate(_defaultBarCount, (i) => (i+1).toDouble());

    StreamSubscription<List<double>>? _visualSub;
    bool _isSorting = false;
    bool _isPaused = false;
    bool _isShuffled = false;

    void _generateBars() {
        setState(() {
            int barsCount = int.tryParse(_barCountCtrl.text) ?? _defaultBarCount;

            // limit cuz the shit might kill itself
            // if (barsCount <= 0 || barsCount >= 5000) barsCount = _defaultBarCount;
            barsCount = min(barsCount, 5000);
            barsCount = max(1, barsCount);

            // generate the bars
            bars = List.generate(barsCount, (i) => (i+1).toDouble());
        });
    }

    void _shuffleBars() {
        setState(() {
            bars.shuffle();
            _isShuffled = true;
        });
    }

    void _runAlgorithm() async {
        _resumeAlgorithm();

        final delay = int.tryParse(_delayCtrl.text) ?? 5;

        // get the sorting algorithm function of the list of algs
        final algFunc = sortingAlgorithmsFunctions[selectedAlgorithm];

        if (algFunc == null) return;

        _visualSub = algFunc(bars, delay).listen(
            (state) {
                setState(() {
                    bars = state;
                    _isSorting = true;
                });
            },
            onDone: () => setState(() {
                _isSorting = false;
                _isShuffled = false;
            }),
            onError: (_) => setState(() {
                _isSorting = false;
                _isShuffled = false;
            }),
        );
        // await for (final state in bubbleSort(bars, delay)) {
        //     setState(() => bars = state);
        // }
    }

    void _pauseAlgorithm() {
        _visualSub?.pause();
        setState(() => _isPaused = true);
    }

    void _resumeAlgorithm() {
        _visualSub?.resume();
        setState(() => _isPaused = false);
    }

    void _stopAlgorithm() {
        _visualSub?.cancel();
        setState(() {
            _isSorting = false;
            _isShuffled = false;
            _generateBars(); // regenerate the bars
        });
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
            body: SingleChildScrollView(
                child: Column(
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
                            isPaused: _isPaused,
                            isSorting: _isSorting,
                            isShuffled: _isShuffled,
                            onShuffleClick: () => _shuffleBars(),
                            onStartClick: () => _runAlgorithm(),
                            onPauseClick: () => _pauseAlgorithm(),
                            onResumeClick: () => _resumeAlgorithm(),
                            onStopClick: () => _stopAlgorithm(),
                        ),
                    ],
                ),
            ),
        );
    }
}
