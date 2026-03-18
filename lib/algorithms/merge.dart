// TODO : make better alg, add colors
import '../class/bar_prop.dart';
import '../data/theme.dart';

Stream<List<BarProp>> mergeSort(List<BarProp> bars, int delay) async* {
    // make a local list to manipulate the list
    final localBars = bars.map((bar) => BarProp(value: bar.value)).toList();
    
    yield * _mergeSort(localBars, 0, localBars.length - 1, delay);
}

Stream<List<BarProp>> _mergeSort(List<BarProp> localBars, int start, int end, int delay) async* {
    if (start >= end) {
        return;
    }

    final int middle = (start + end) ~/ 2;
    yield* _mergeSort(localBars, start, middle, delay);
    yield* _mergeSort(localBars, middle + 1, end, delay);
    yield* _merge(localBars, start, middle, end, delay);
}

Stream<List<BarProp>> _merge(List<BarProp> localBars, int start, int middle, int end, int delay) async* {
    int leftPointer = 0;
    int rightPointer = middle - start + 1;
    int mainPointer = start;
    List<BarProp> tempBars = localBars.sublist(start, end + 1);

    while (leftPointer <= middle - start && rightPointer < tempBars.length) {
        if (tempBars[leftPointer].value < tempBars[rightPointer].value) {
            localBars[mainPointer] = tempBars[leftPointer];
            localBars[mainPointer++].color = AppTheme.swapping;
            localBars[leftPointer++].color = AppTheme.swapping;
        }
        else if (tempBars[leftPointer].value > tempBars[rightPointer].value) {
            localBars[mainPointer++] = tempBars[rightPointer++];
        }
        yield [...localBars];
        await Future.delayed(Duration(microseconds: delay));
    }

    // emptying the leftovers
    while (leftPointer <= middle - start) {
        localBars[mainPointer++] = tempBars[leftPointer++];
        yield [...localBars];
        await Future.delayed(Duration(microseconds: delay));
    }
    while (rightPointer < tempBars.length) {
        localBars[mainPointer++] = tempBars[rightPointer++];
        yield [...localBars];
        await Future.delayed(Duration(microseconds: delay));
    }
}
