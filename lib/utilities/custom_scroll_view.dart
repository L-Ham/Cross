import 'package:flutter/material.dart';

class CustomScrollPhysics extends ClampingScrollPhysics {
  final double maxExtent;

  CustomScrollPhysics({required this.maxExtent, ScrollPhysics? parent})
      : super(parent: parent);

  @override
  CustomScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return CustomScrollPhysics(maxExtent: maxExtent, parent: buildParent(ancestor));
  }

  @override
  double applyBoundaryConditions(ScrollMetrics position, double value) {
    if (value > maxExtent) {
      // Prevents the scroll from exceeding the max extent
      return value - maxExtent;
    }
    return super.applyBoundaryConditions(position, value);
  }
}