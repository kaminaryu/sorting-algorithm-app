import '../class/bar_prop.dart';
import '../data/theme.dart';
// import 'package:audioplayers/audioplayers.dart';

Stream<List<BarProp>> bubbleSort(List<BarProp> bars, int delay) async* {
    // final audioPlayer = AudioPlayer();
 
    // make a local list to manipulate the list
    final localBars = bars.map((bar) => BarProp(value: bar.value)).toList();

    for (int i = 0; i < localBars.length; i++) {
        for (int j = 0; j < localBars.length - i - 1; j++) {
            // color for comparing
            localBars[j].color = AppTheme.comparison;
            localBars[j + 1].color = AppTheme.comparison;

            yield [...localBars];
            await Future.delayed(Duration(microseconds: delay));


            if (localBars[j].value > localBars[j + 1].value) {
                final temp = localBars[j];
                localBars[j] = localBars[j + 1];
                localBars[j + 1] = temp;

                // coloring
                localBars[j].color = AppTheme.swapping;
                localBars[j + 1].color = AppTheme.swapping;
                yield [...localBars];
                await Future.delayed(Duration(microseconds: delay));

                // await audioPlayer.play(AssetSource("plop.mp3"));
                // await audioPlayer.stop();
            }

            // resetting the bar colors
            localBars[j].color = AppTheme.main;
            localBars[j + 1].color = AppTheme.main;
        }
    }
}
