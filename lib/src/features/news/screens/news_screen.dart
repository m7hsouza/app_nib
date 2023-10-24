import 'package:app_nib/src/features/news/widgets/slide_widget.dart';
import 'package:flutter/material.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  final _slides = [
    {
      "id": "1",
      "imageURL": "https://placehold.co/1366x768/png?text=Image\n1"
    },
    {
      "id": "2",
      "imageURL": "https://placehold.co/1366x768/png?text=Image\n2"
    },
    {
      "id": "3",
      "imageURL": "https://placehold.co/1366x768/png?text=Image\n3"
    },
    {
      "id": "4",
      "imageURL": "https://placehold.co/1366x768/png?text=Image\n4"
    },
  ];



  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          SlideWidget(slides: _slides),
        
        ],
      ),
    );
  }
}
