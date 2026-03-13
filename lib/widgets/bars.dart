import 'package:flutter/material.dart';

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
