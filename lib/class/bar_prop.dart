import 'package:flutter/material.dart';
import '../data/theme.dart';

class BarProp {
    final double value;
    double? height;
    Color color;

    BarProp({
        required this.value,
        this.height,
        this.color = AppTheme.main,
    });
}
