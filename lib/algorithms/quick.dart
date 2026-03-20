import 'package:sorting_algorithm/class/bar_prop.dart';
import 'package:sorting_algorithm/data/theme.dart';

Stream<List<BarProp>> quickSort(List<BarProp> bars, int delay) async* {
    // make a local list to manipulate the list
    final localBars = bars.map((bar) => BarProp(value: bar.value)).toList();

    yield* _quickSort(localBars, 0, localBars.length - 1, delay);
}

Stream<List<BarProp>> _quickSort(List<BarProp> localBars, int start, int end, int delay) async* {
    if (start >= end) {
        if (start == end) {
            yield [...localBars];
        }
        return;
    }

    int pivot = end;
    int smallestIndex = start;
    
    localBars[pivot].color = AppTheme.special;

    for (int i = start; i < end; i++) {
        localBars[i].color = AppTheme.comparison;
        localBars[smallestIndex].color = AppTheme.comparison;

        yield [...localBars];
        await Future.delayed(Duration(microseconds: delay));

        if (localBars[i].value <= localBars[pivot].value) {
            final temp = localBars[smallestIndex];
            localBars[smallestIndex] = localBars[i];
            localBars[i] = temp;

            localBars[i].resetColor();
            localBars[smallestIndex].resetColor();

            smallestIndex++;
        } 
        else {
            localBars[i].resetColor();
            localBars[smallestIndex].resetColor();
        }

        yield [...localBars];
        await Future.delayed(Duration(microseconds: delay));
    }

    localBars[pivot].resetColor();

    final temp = localBars[smallestIndex];
    localBars[smallestIndex] = localBars[pivot];
    localBars[pivot] = temp;

    // localBars[smallestIndex].color = AppTheme.special;
    // yield [...localBars];
    // await Future.delayed(Duration(microseconds: delay));

    yield* _quickSort(localBars, start, smallestIndex - 1, delay);
    yield* _quickSort(localBars, smallestIndex + 1, end, delay);
}
