import 'package:flutter/material.dart';

class CptLoading extends StatelessWidget {
  final double size;

  const CptLoading({Key? key, this.size = 14}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Stack(
        alignment: Alignment.center,
        children: [
          _buildDot(
            1,
            Theme.of(context).primaryColor,
            AnimationController(
              vsync: TickerProviderStateMixin.createTicker(this),
              duration: const Duration(milliseconds: 1200),
            )..repeat(),
          ),
          _buildDot(
            2,
            Theme.of(context).highlightColor,
            null,
          ),
          _buildDot(
            3,
            Theme.of(context).selectedRowColor,
            AnimationController(
              vsync: TickerProviderStateMixin.createTicker(this),
              duration: const Duration(milliseconds: 1200),
            )..repeat(reverse: true),
          ),
        ],
      ),
    );
  }

  Widget _buildDot(int index, Color color, AnimationController? controller) {
    return AnimatedBuilder(
      animation: controller ?? const AlwaysStoppedAnimation<double>(0),
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(
              20 * (index % 2 == 0 ? 1 : -1) * (controller?.value ?? 0), 0),
          child: child,
        );
      },
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
