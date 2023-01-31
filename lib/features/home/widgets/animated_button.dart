import 'dart:math';

import 'package:flutter/material.dart';

class AnimatedButton extends StatefulWidget {
  final double width;
  final double height;
  final bool isSelected;
  final VoidCallback? onPress;
  final ValueChanged<bool>? onChanges;
  final Widget unselectedWidget;
  final Widget selectedWidget;

  const AnimatedButton({
    this.width = double.infinity,
    this.height = 50,
    this.isSelected = false,
    this.onChanges,
    required this.onPress,
    required this.unselectedWidget,
    required this.selectedWidget,
    Key? key,
  }) : super(key: key);

  @override
  State<AnimatedButton> createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> slideAnimation;
  double slideBegin = 0.0;
  double slideEnd = 1.0;

  AnimationController? get animationController => _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 400));

    slideAnimation = Tween(begin: slideBegin, end: slideEnd).animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeInOutCubic));

    widget.isSelected ? _controller.forward() : _controller.reverse();
  }

  @override
  void didUpdateWidget(covariant AnimatedButton oldWidget) {
    if (oldWidget.isSelected != widget.isSelected) {
      widget.isSelected ? _controller.forward() : _controller.reverse();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(50),
      child: Stack(children: [
        Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(50),
          ),
          child: Align(
            alignment: Alignment.center,
            child: widget.unselectedWidget,
          ),
        ),
        AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return ClipPath(
              clipper: RectClipper(slideAnimation.value),
              child: child,
            );
          },
          child: Container(
            width: widget.width,
            height: widget.height,
            decoration: BoxDecoration(
              color: const Color(0xffC2E7FF),
              borderRadius: BorderRadius.circular(50),
            ),
            child: Align(
              alignment: Alignment.center,
              child: widget.selectedWidget,
            ),
          ),
        )
      ]),
    );
  }

  @override
  void dispose() {
    super.dispose();
    animationController?.dispose();
  }

  onPressed() {
    _controller.forward();
    widget.onChanges?.call(true);
    widget.onPress?.call();
  }
}

class RectClipper extends CustomClipper<Path> {
  final double clipFactor;

  RectClipper(this.clipFactor);

  @override
  Path getClip(Size size) {
    Path path = Path();

    path.addOval(Rect.fromCircle(
        center: Offset(size.width / 2, size.height / 2),
        radius: (sqrt((size.width * size.width) + (size.height * size.height)) *
            clipFactor)));
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
