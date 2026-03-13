Stream<List<double>> bubbleSort(List<double> bars, int delay) async* {
    final list = [...bars];
    for (int i = 0; i < list.length; i++) {
        for (int j = 0; j < list.length - i - 1; j++) {
            if (list[j] > list[j + 1]) {
                final temp = list[j];
                list[j] = list[j + 1];
                list[j + 1] = temp;
                yield [...list];
            }
            await Future.delayed(Duration(milliseconds: delay));
        }
    }
}
