import 'package:flutter/material.dart';

class SlideTileWidget extends StatelessWidget {
  const SlideTileWidget({super.key, required this.imageURL, required this.active});

  final String imageURL;
  final bool active;

  @override
  Widget build(BuildContext context) {
    final boxShadow = <BoxShadow>[];
    if (active) {
      boxShadow.add(const BoxShadow(
        color: Colors.black26,
        blurRadius: 10,
        offset: Offset(10, 10),
      ));
    }

    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      margin: EdgeInsets.only(
        top: active ? 20 : 40,
        bottom: 20,
        right: 16,
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          image: DecorationImage(
            image: NetworkImage(imageURL),
            fit: BoxFit.cover,
          ),
          boxShadow: boxShadow),
    );
  }
}
