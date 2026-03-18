import '../class/bar_prop.dart';
import '../data/theme.dart';

Stream<List<BarProp>> insertionSort(List<BarProp> bars, int delay) async* {
    final localBars = bars.map((bar) => BarProp(value: bar.value)).toList();

    for (int i = 0; i < localBars.length; i++) {
        for (int j = i; j > 0; j--) {
            // color for comparing
            localBars[j].color = AppTheme.comparison;
            localBars[j - 1].color = AppTheme.comparison;
            yield [...localBars];
            await Future.delayed(Duration(microseconds: delay));

            if (localBars[j-1].value > localBars[j].value) {
                final temp = localBars[j];
                localBars[j] = localBars[j - 1];
                localBars[j - 1] = temp;

                // coloring
                localBars[j].color = AppTheme.swapping;
                localBars[j - 1].color = AppTheme.swapping;
                yield [...localBars];
                await Future.delayed(Duration(microseconds: delay));

                // resetting colors
                localBars[j].color = AppTheme.main;
                localBars[j - 1].color = AppTheme.main;
            }
            else {
                // resetting the bar colors
                localBars[j].color = AppTheme.main;
                localBars[j - 1].color = AppTheme.main;
                break;
            }

        }
    }
}
