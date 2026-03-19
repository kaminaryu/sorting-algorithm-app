import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:math';

import 'widgets/bars.dart';
import 'widgets/form.dart';
import 'widgets/controls.dart';

import 'data/algorithm_list.dart';

import 'algorithms/finished.dart';

import 'class/bar_prop.dart';

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
    // why static const? so that theyre avaiable when init, since theyre class level
    static const int _defaultBarCount = 67;
    static const int _defaultDelay = 1000;

    final _barCountCtrl = TextEditingController(text: _defaultBarCount.toString());
    final _delayCtrl = TextEditingController(text: _defaultDelay.toString());
    String? selectedAlgorithm = "Bubble";

    late List<BarProp> bars = List.generate(_defaultBarCount, (i) => BarProp(value: (i+1).toDouble()));

    StreamSubscription<List<BarProp>>? _visualSub;
    bool _isSorting = false;
    bool _isPaused = false;
    bool _isShuffled = false;

    void _generateBars() {
        setState(() {
            int barsCount = int.tryParse(_barCountCtrl.text) ?? _defaultBarCount;

            // limit cuz the shit might kill itself
            barsCount = min(barsCount, 100000);
            barsCount = max(1, barsCount);

            // generate the bars
            bars = List.generate(barsCount, (i) => BarProp(value: (i+1).toDouble()));
        });
    }

    void _shuffleArray() {
        setState(() {
            _generateBars(); // regenerate the bars
            bars.shuffle();
            _isShuffled = true;
        });
    }

    void _runAlgorithm() async {
        _resumeAlgorithm();

        final delay = int.tryParse(_delayCtrl.text) ?? 5;

        // get the sorting algorithm function of the list of algs
        final sortingFunc = sortingAlgorithmsFunctions[selectedAlgorithm];

        if (sortingFunc == null) return;

        _visualSub = sortingFunc(bars, delay).listen(
            (state) {
                setState(() {
                    bars = state;
                    _isSorting = true;
                });
            },
            onDone: _playFinishedAnim,
            onError: (_) => setState(() {
                _isSorting = false;
                _isShuffled = false;
            }),
        );
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
        });
    }


    void _playFinishedAnim() {
        final delay = int.tryParse(_delayCtrl.text) ?? 5;

        _visualSub = finishAnim(bars, delay).listen(
            (state) {
                setState(() {
                    bars = state;
                    _isSorting = true;
                });
            },
            onDone: () => setState(() {
                _isSorting = false;
                _isShuffled = false;
                for (var bar in bars) {
                    bar.resetColor();
                }
            }),
            onError: (_) => setState(() {
                _isSorting = false;
                _isShuffled = false;
            }),
        );

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
                            onShuffleClick: () => _shuffleArray(),
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
