Stream<List<double>> insertionSort(List<double> bars, int delay) async* {
    final list = [...bars];
    for (int i = 0; i < list.length; i++) {
        for (int j = i; j > 0; j--) {
            if (list[j-1] > list[j]) {
                final temp = list[j];
                list[j] = list[j-1];
                list[j-1] = temp;
                yield [...list];
            }
            else {
                continue;
            }
            await Future.delayed(Duration(milliseconds: delay));
        }
    }
}
