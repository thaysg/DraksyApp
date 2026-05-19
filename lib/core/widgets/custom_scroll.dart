import 'package:flutter/material.dart';

import '../extensions/context_extension.dart';

class CustomScroll extends StatelessWidget {
  const CustomScroll({required this.child, super.key});
  final Widget child;

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(
          horizontal: context.horizontalPadding,
          vertical: 20,
        ),
        child: child,
      );
}
