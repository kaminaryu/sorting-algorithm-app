import '../class/bar_prop.dart';
import '../data/theme.dart';

Stream<List<BarProp>> selectionSort(List<BarProp> bars, int delay) async* {
    final localBars = bars.map((bar) => BarProp(value: bar.value)).toList();

    for (int i = 0; i < localBars.length; i++) {
        int min = i;
        localBars[min].color = AppTheme.special;

        for (int j = i; j < localBars.length; j++) {
            localBars[j].color = AppTheme.comparison;
            yield[...localBars];
            await Future.delayed(Duration(microseconds: delay));

            if (localBars[j].value < localBars[min].value) {
                // swapping the color of specials
                localBars[min].color = AppTheme.main;
                localBars[j].color = AppTheme.special;
                min = j;
            } 
            else {
                localBars[j].color = AppTheme.main;
            }
        }

        // state before swapping min with current index
        localBars[i].color = AppTheme.swapping;
        localBars[min].color = AppTheme.swapping;

        yield[...localBars];
        await Future.delayed(Duration(microseconds: delay));

        // state after swapping min with current index
        final temp = localBars[i];
        localBars[i] = localBars[min];
        localBars[min] = temp;

        yield[...localBars];
        await Future.delayed(Duration(microseconds: delay));

        // resetting colors
        localBars[min].color = AppTheme.main;
        localBars[i].color = AppTheme.main;
    }
}
