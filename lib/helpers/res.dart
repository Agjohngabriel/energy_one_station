import 'package:flutter/material.dart';

///
/// [context] - BuildContext
///
/// [fraction] - double between 0.0 and 1.0
double width(BuildContext context, double fraction) =>
    MediaQuery.of(context).size.width * fraction;

///
/// [context] - BuildContext
///
/// [fraction] - double between 0.0 and 1.0
double height(BuildContext context, double fraction) =>
    MediaQuery.of(context).size.height * fraction;