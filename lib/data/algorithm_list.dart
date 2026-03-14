import '../algorithms/bubble.dart';
import '../algorithms/selection.dart';
import '../algorithms/insertion.dart';

const Map< String, Stream<List<double>> Function(List<double>, int) > sortingAlgorithmsFunctions = {
    "Bubble": bubbleSort,
    "Selection": selectionSort,
    "Insertion": insertionSort,
};
