import 'package:flutter/material.dart';

import 'widgets/bars.dart';
import 'widgets/form.dart';

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
    String? selectedAlgorithm;

    final _barCountCtrl = TextEditingController(text: "67");

    @override
    void dispose() {
        _barCountCtrl.dispose();
        super.dispose();
    }

    @override
    Widget build(BuildContext context) {
        int barCount = int.tryParse(_barCountCtrl.text) ?? 67;

        // limit cuz the shit might kill itself
        if (barCount <= 0 || barCount >= 5000) barCount = 67;

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
                    BarsContainer(barCount), 
                    SortingOptions(
                        barCountCtrl: _barCountCtrl,
                        selectedAlgorithm: selectedAlgorithm,
                        onSelectedAlgorithmChange: (alg) => setState(() => selectedAlgorithm = alg),
                        onBarCountChange: () => setState(() => {}), // trigger rebuild
                    )
                ],
            ),
        );
    }
}
