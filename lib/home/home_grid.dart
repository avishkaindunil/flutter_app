import 'package:flutter/material.dart';
import '../common/glass_card.dart';

class HomeGrid extends StatelessWidget {
  final VoidCallback? onTapCalculator;
  final VoidCallback? onTapConverter;
  final VoidCallback? onTapTakePhoto;

  const HomeGrid({
    Key? key,
    this.onTapCalculator,
    this.onTapConverter,
    this.onTapTakePhoto,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? Colors.white.withOpacity(0.2) : Colors.black.withOpacity(0.1);
    final borderColor = isDark ? Colors.white.withOpacity(0.3) : Colors.black.withOpacity(0.2);
    final textColor = isDark ? Colors.white : Colors.black;

    return GridView.count(
      padding: const EdgeInsets.all(20),
      crossAxisCount: 2,
      mainAxisSpacing: 20,
      crossAxisSpacing: 20,
      children: [
        GlassCard(
          label: 'Calculator',
          onTap: onTapCalculator ?? () {},
          bgColor: bgColor,
          borderColor: borderColor,
          textColor: textColor,
        ),
        GlassCard(
          label: 'Currency Con.',
          onTap: onTapConverter ?? () {},
          bgColor: bgColor,
          borderColor: borderColor,
          textColor: textColor,
        ),
        GlassCard(
          label: 'Take a Photo',
          onTap: onTapTakePhoto ?? () {},
          bgColor: bgColor,
          borderColor: borderColor,
          textColor: textColor,
        ),
      ],
    );
  }
}
