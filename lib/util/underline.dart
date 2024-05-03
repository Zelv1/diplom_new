import 'package:diplom_new/util/color.dart';
import 'package:flutter/material.dart';

class UnderLine extends StatelessWidget {
  const UnderLine({super.key});

  @override
  Widget build(BuildContext context) {
    return const Divider(
      color: colorForUnderline,
      height: 1,
      thickness: 0,
    );
  }
}
