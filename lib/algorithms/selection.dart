Stream<List<double>> selectionSort(List<double> bars, int delay) async* {
    final list = [...bars];
    for (int i = 0; i < list.length; i++) {
        int min = i;
        for (int j = i; j < list.length; j++) {
            if (list[j] < list[min]) {
                min = j;
            }
            await Future.delayed(Duration(milliseconds: delay));
        }
        final temp = list[i];
        list[i] = list[min];
        list[min] = temp;

        yield[...list];
    }
}
