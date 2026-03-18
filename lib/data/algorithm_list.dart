import '../algorithms/bubble.dart';
import '../algorithms/selection.dart';
import '../algorithms/insertion.dart';
import '../class/bar_prop.dart';

const Map<String, Stream<List<BarProp>> Function(List<BarProp>, int)> sortingAlgorithmsFunctions = {
    "Bubble": bubbleSort,
    "Selection": selectionSort,
    "Insertion": insertionSort,
};
