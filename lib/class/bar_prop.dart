import 'package:flutter/material.dart';
import '../data/theme.dart';

class BarProp {
    final double value;
    double? height;
    Color color;

    void resetColor() {
        color = AppTheme.main;
    }

    BarProp({
        required this.value,
        this.height,
        this.color = AppTheme.main,
    });
}
