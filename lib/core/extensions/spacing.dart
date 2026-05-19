import 'package:flutter/material.dart';

/// Extension on num to provide easy access to SizedBox for spacing.
extension SizedBoxExtensions on num {
  /// Returns a SizedBox with the height of this number.
  Widget get heightBox => SizedBox(height: toDouble());

  /// Returns a SizedBox with the width of this number.
  Widget get widthBox => SizedBox(width: toDouble());

  /// Returns a square SizedBox with the height and width of this number.
  Widget get squareBox => SizedBox(height: toDouble(), width: toDouble());
}

const bottomMargin = 8.0;
const activeFontSize = 14.0;
