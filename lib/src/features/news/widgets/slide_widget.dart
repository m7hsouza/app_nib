import 'package:app_nib/src/features/news/models/article.dart';
import 'package:app_nib/src/features/news/stores/news_slide_store.dart';
import 'package:app_nib/src/features/news/widgets/slide_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SlideWidget extends StatefulWidget {
  const SlideWidget({super.key});

  @override
  State<SlideWidget> createState() => _SlideWidgetState();
}

class _SlideWidgetState extends State<SlideWidget> {
  int _currentSlide = 0;
  final _slideController = PageController(viewportFraction: 0.85);

  late final NewsSlideStore store = Provider.of(context);

  @override
  void initState() {
    super.initState();
    _slideController.addListener(() {
      final nextSlide = _slideController.page?.round();

      if (nextSlide != null && _currentSlide != nextSlide) {
        setState(() {
          _currentSlide = nextSlide;
        });
      }
    });
  }

  @override
  void dispose() {
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cards = store.cards;

    return Column(
      children: [
        SizedBox(
          height: 240,
          child: PageView.builder(
            controller: _slideController,
            itemCount: cards.length,
            itemBuilder: (_, currentIndex) {
              final card = cards[currentIndex];
              return SlideTileWidget(
                imageURL: card.image,
                active: _currentSlide == currentIndex,
              );
            },
          ),
        ),
        _buildBullets(context, cards)
      ],
    );
  }

  Widget _buildBullets(BuildContext context, List<Article> articles) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: articles.map((slide) {
          final isCurrentSlide = articles.indexOf(slide) == _currentSlide;
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
