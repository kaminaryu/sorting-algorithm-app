import 'package:flutter/material.dart';


class BarsCanvas extends CustomPainter {
    final List<double> bars;
    BarsCanvas({required this.bars}); // no super.key cuz it aint a widget

    @override
    void paint(Canvas canvas, Size size) {
        final paint = Paint()..color = Color(0xff670067);

        final horizontalPadding = 25;
        final canvasWidth = size.width - horizontalPadding;
        final canvasHeight = size.height;

        final barWidth = canvasWidth / bars.length;

        for (int i = 0; i < bars.length; i++) {
            final x = horizontalPadding / 2 + i * barWidth;

            canvas.drawRect(Rect.fromLTWH(x, canvasHeight, barWidth, -bars[i]), paint);
        }
    }

    @override
    bool shouldRepaint(BarsCanvas old) => old.bars != bars;
}


class BarsContainer extends StatefulWidget {
    const BarsContainer(this.bars, {super.key});

    final List<double> bars;

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
        final double maxValue = widget.bars.reduce((x, y) => x > y ? x : y);

        // calculate bar heights
        List<double> barHeightsPercentage = widget.bars.map((value) => value / maxValue).toList();
        List<double> barHeights = barHeightsPercentage.map((perc) => (containerHeight - topPadding) * perc).toList();

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
                painter: BarsCanvas(bars: barHeights),
            ),
        );
    }
}
//             child: Row(
//                 mainAxisSize: MainAxisSize.max,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 children: barHeights.map((bar) => Expanded(
//                     child: Container(
//                         height: bar,
//                         margin: EdgeInsets.symmetric(horizontal: 0),
//                         decoration: BoxDecoration(
//                             color: Colors.white,
//                             border: Border.all(
//                                 color: Colors.black,
//                                 width: 1,
//                             ),
//                         ),
//                     )
//                 )).toList(),
//             ),
//         );
//     }
// }
