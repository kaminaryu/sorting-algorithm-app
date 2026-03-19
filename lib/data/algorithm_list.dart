import 'package:sorting_algorithm/algorithms/stalin.dart';

import '../algorithms/bubble.dart';
import '../algorithms/selection.dart';
import '../algorithms/insertion.dart';
import '../algorithms/bogo.dart';
import '../algorithms/merge.dart';
import '../algorithms/quick.dart';

import '../class/bar_prop.dart';

const Map<String, Stream<List<BarProp>> Function(List<BarProp>, int)> sortingAlgorithmsFunctions = {
    "Bubble": bubbleSort,
    "Selection": selectionSort,
    "Insertion": insertionSort,
    "Bogo": bogoSort,
    "Merge": mergeSort,
    "Quick": quickSort,
    "Stalin": stalinSort,
};
