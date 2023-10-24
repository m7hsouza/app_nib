import 'package:app_nib/src/features/news/widgets/slide_tile_widget.dart';
import 'package:flutter/material.dart';

class SlideWidget extends StatefulWidget {
  const SlideWidget({super.key, required this.slides});

  final List<Map<String, String>> slides;

  @override
  State<SlideWidget> createState() => _SlideWidgetState();
}

class _SlideWidgetState extends State<SlideWidget> {
  int _currentSlide = 0;
  final _slideController = PageController(viewportFraction: 0.85);
  @override
  void initState() {
    _slideController.addListener(() {
      final nextSlide = _slideController.page?.round();

      if (nextSlide != null && _currentSlide != nextSlide) {
        setState(() {
          _currentSlide = nextSlide;
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 240,
          child: PageView.builder(
            controller: _slideController,
            itemCount: widget.slides.length,
            itemBuilder: (_, currentIndex) {
              final slide = widget.slides[currentIndex];
              return SlideTileWidget(
                imageURL: slide["imageURL"]!,
                active: _currentSlide == currentIndex,
              );
            },
          ),
        ),
        _buildBullets(context)
      ],
    );
  }

  Widget _buildBullets(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: widget.slides.map((slide) {
          final isCurrentSlide = widget.slides.indexOf(slide) == _currentSlide;
          return AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            width: isCurrentSlide ? 30 : 10,
            height: 10,
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: isCurrentSlide ? Theme.of(context).primaryColor : Colors.grey,
            ),
          );
        }).toList(),
      ),
    );
  }
}
