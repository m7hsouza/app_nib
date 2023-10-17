import 'package:flutter/material.dart';

class LayoutWidget extends StatelessWidget {
  const LayoutWidget({super.key, required this.body, this.title});

  final Widget body;
  final Widget? title;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(150),
        child: ClipPath(
          clipper: _SShapedClipper(),
          child: SizedBox(
            height: 150,
            width: screenSize.width,
            child: AppBar(
              title: title,
              centerTitle: true,
              backgroundColor: Theme.of(context).primaryColor,
            ),
          ),
        ),
      ),
      body: body,
    );
  }
}

class _SShapedClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.moveTo(0, 0);
    path.lineTo(0, size.height);

    final x1 = size.width * 0.45;
    const y1 = 25.0;

    final x2 = size.width * 0.65;
    const y2 = 175.0;

    final x3 = size.width;
    const y3 = 50.0;

    path.cubicTo(x1, y1, x2, y2, x3, y3);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return oldClipper != this;
  }
}
