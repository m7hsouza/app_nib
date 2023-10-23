import 'package:flutter/material.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              Container(
                height: 200,
                width: MediaQuery.sizeOf(context).width - 64,
                color: Colors.red,
              ),
              const SizedBox(width: 8),
              Container(
                height: 216,
                width: MediaQuery.sizeOf(context).width - 48,
                color: Colors.green,
              ),
              const SizedBox(width: 8),
              Container(
                height: 200,
                width: MediaQuery.sizeOf(context).width - 64,
                color: Colors.blue,
              ),
            ],
          ),
        )
      ],
    );
  }
}
