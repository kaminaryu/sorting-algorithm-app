import 'dart:math';

import 'package:flutter/material.dart';
import '../class/bar_prop.dart';

class BarsCanvas extends CustomPainter {
    final List<BarProp> bars;
    BarsCanvas({required this.bars}); // no super.key cuz it aint a widget

    @override
    void paint(Canvas canvas, Size size) {

        final horizontalPadding = 25;
        final canvasWidth = size.width - horizontalPadding;
        final canvasHeight = size.height;

        final barWidth = canvasWidth / bars.length;

        for (int i = 0; i < bars.length; i++) {
            final bar = bars[i];
            final paint = Paint()..color = bar.color; // Color(0xff670067);
            final x = horizontalPadding / 2 + i * barWidth;

            canvas.drawRect(Rect.fromLTWH(x, canvasHeight, barWidth, -bar.height!), paint);
        }
    }

    @override
    bool shouldRepaint(BarsCanvas old) => old.bars != bars;
}


class BarsContainer extends StatefulWidget {
    const BarsContainer(this.bars, {super.key});

    final List<BarProp> bars;

    @override
    State<BarsContainer> createState() => _BarsContainerState();
}

class _BarsContainerState extends State<BarsContainer> {
    final double containerWidth = 240;
    final double containerHeight = 240;
    final double topPadding = 20;

    @override
    Widget build(BuildContext context) {
        // get max height
        double maxHeight = 0;
        for (int i = 0; i < widget.bars.length; i++) {
            maxHeight = max(maxHeight, widget.bars[i].value);
        }

        // calculate bar heights
        for (int i = 0; i < widget.bars.length; i++) {
            final double percentage = widget.bars[i].value / maxHeight;
            widget.bars[i].height = percentage * (containerHeight - topPadding);
        }

        return Container(
            width: containerWidth,
            height: containerHeight,
            margin: EdgeInsets.all(32),
            decoration: BoxDecoration(
                border: Border.all(
                    color: Colors.black,
                    width: 2,
                ),
                borderRadius: BorderRadius.circular(20),
                color: Color(0xFFdedede),
            ),
            child: CustomPaint(
                size: Size(double.infinity, double.infinity),
                painter: BarsCanvas(bars: widget.bars),
            ),
        );
    }
}
