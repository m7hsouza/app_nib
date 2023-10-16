import 'package:flutter/material.dart';

class LayoutWidget extends StatelessWidget {
  const LayoutWidget({super.key, required this.child, this.title});

  final Widget child;
  final Widget? title;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    return Material(
      child: ColoredBox(
        color: Theme.of(context).primaryColor,
        child: Column(
          children: [
            SizedBox(
              height: screenSize.height * 0.05,
              child: title,
            ),
            ClipPath(
              clipper: _SShapedClipper(),
              child: SizedBox(
                height: screenSize.height * 0.95,
                child: ColoredBox(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  child: child,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SShapedClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.moveTo(0, size.height);
    path.lineTo(0, 100);
    path.cubicTo(size.width * 0.40, -15, size.width * 0.65, 150, size.width, 0);
    path.lineTo(size.width, size.height);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return oldClipper != this;
  }
}
