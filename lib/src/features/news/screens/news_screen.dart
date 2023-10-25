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
      "imageURL": "https://placehold.co/1366x768/png?text=Card\n1"
    },
    {
      "id": "2",
      "imageURL": "https://placehold.co/1366x768/png?text=Card\n2"
    },
    {
      "id": "3",
      "imageURL": "https://placehold.co/1366x768/png?text=Card\n3"
    },
    {
      "id": "4",
      "imageURL": "https://placehold.co/1366x768/png?text=Card\n4"
    },
  ];

  final _news = [
    {
      "id": "001",
      "title": "Tile 001",
      "content": "Sample description 001",
      "imageURL": "https://placehold.co/768x1366/png?text=News\n1",
      "likes": "10",
      "comments": "8",
    },
    {
      "id": "002",
      "title": "Tile 002",
      "content": "Sample description 002",
      "imageURL": "https://placehold.co/768x1366/png?text=News\n2",
      "likes": "10",
      "comments": "15",
    },
    {
      "id": "003",
      "title": "Tile 003",
      "content": "Sample description 003",
      "imageURL": "https://placehold.co/768x1366/png?text=News\n3",
      "likes": "1",
      "comments": "0",
    }
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          SlideWidget(slides: _slides),
          Expanded(
            child: ListView.separated(
              itemCount: _news.length,
              itemBuilder: _itemBuilder,
              separatorBuilder: (_, __) => const Divider(),
            ),
          )
        ],
      ),
    );
  }

  Widget? _itemBuilder(BuildContext context, int index) {
    final currentNews = _news[index];
    return ListTile(
      onTap: () {
        Navigator.pushNamed(context, "/screens/single-news", arguments: currentNews["id"]);
      },
      leading: SizedBox(
        width: 60,
        child: Hero(
          tag: "news:${currentNews['id']}",
          child: Image.network(
            currentNews['imageURL']!,
            fit: BoxFit.cover,
          ),
        ),
      ),
      title: Text("${currentNews['title']}"),
      subtitle: IconTheme.merge(
        data: const IconThemeData(size: 16),
        child: DefaultTextStyle.merge(
          style: const TextStyle(
            fontSize: 12,
            fontStyle: FontStyle.italic,
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 6),
            child: Row(
              children: [
                const Icon(
                  Icons.thumb_up_alt_rounded,
                ),
                Text("${currentNews['likes']}"),
                const SizedBox(width: 16),
                const Icon(
                  Icons.comment_rounded,
                ),
                Text("${currentNews['comments']}"),
                const Spacer(),
                const Text("Dois mêses atras")
              ],
            ),
          ),
        ),
      ),
    );
  }
}
