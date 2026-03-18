import '../class/bar_prop.dart';
import '../data/theme.dart';

Stream<List<BarProp>> finishAnim(List<BarProp> bars, int delay) async* {
    // make a local list to manipulate the list
    final localBars = bars.map((bar) => BarProp(value: bar.value)).toList();

    for (int i = 0; i < localBars.length; i++) {
        localBars[i].color = AppTheme.special;
        yield [...localBars];
        await Future.delayed(Duration(milliseconds: 1));
    }
}
