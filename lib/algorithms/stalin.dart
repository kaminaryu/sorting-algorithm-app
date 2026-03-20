import '../class/bar_prop.dart';
import '../data/theme.dart';

Stream<List<BarProp>> stalinSort(List<BarProp> bars, int delay) async* {
    // make a local list to manipulate the list
    final localBars = bars.map((bar) => BarProp(value: bar.value)).toList();
    int i = 0;

    while (i < localBars.length - 1) {
        localBars[i].color = AppTheme.comparison;

        if (localBars[i].value > localBars[i + 1].value) {
            localBars[i + 1].color = AppTheme.swapping;
            yield [...localBars];
            await Future.delayed(Duration(microseconds: delay));

            localBars[i + 1].resetColor();
            localBars.removeAt(i + 1);
        }
        else {
            localBars[i + 1].color = AppTheme.comparison;

            yield [...localBars];
            await Future.delayed(Duration(microseconds: delay));

            localBars[i].resetColor();
            i++;
        }
 
    }
}
