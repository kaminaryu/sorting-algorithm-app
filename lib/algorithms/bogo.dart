import '../class/bar_prop.dart';
import '../data/theme.dart';

Stream<List<BarProp>> bogoSort(List<BarProp> bars, int delay) async* {
    // make a local list to manipulate the list
    final localBars = bars.map((bar) => BarProp(value: bar.value)).toList();

    bool isSorted = true;

    do {
        isSorted = true;
        for (int i = 0; i < localBars.length - 1; i++) {
            localBars[i].color = AppTheme.comparison;
            yield [...localBars];
            await Future.delayed(Duration(microseconds: delay));

            if (localBars[i].value > localBars[i + 1].value) {
                isSorted = false;

                localBars[i + 1].color = AppTheme.swapping;
                yield [...localBars];
                await Future.delayed(Duration(microseconds: delay));

                break;
            }
        }

        if (!isSorted){
            localBars.shuffle();
            resetColors(localBars);
        }

        yield [...localBars];
        await Future.delayed(Duration(microseconds: delay));

    } while (!isSorted);
}

void resetColors(List<BarProp> bars) {
    for (BarProp bar in bars) {
        bar.resetColor();
    }
}
