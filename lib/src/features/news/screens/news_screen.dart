import 'package:app_nib/src/features/news/models/article.dart';
import 'package:app_nib/src/features/news/stores/news_slide_store.dart';
import 'package:app_nib/src/features/news/stores/news_store.dart';
import 'package:app_nib/src/features/news/widgets/recent_articles_widget.dart';
import 'package:app_nib/src/features/news/widgets/slide_widget.dart';
import 'package:app_nib/src/shared/widgets/image_network_with_token.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  late final NewsSlideStore sldiesStore = Provider.of(context);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final newsStore = context.watch<NewsStore>();

    if (newsStore.state == NewsState.loading) {
      return const SafeArea(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return SafeArea(
      child: Column(
        children: [
          if (sldiesStore.state.isLoading) const CircularProgressIndicator(),
          if (sldiesStore.cards.isNotEmpty) const SlideWidget(),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: RecentArticlesWidget(),
          ),
        ],
      ),
    );
  }

  Widget? _itemBuilder(Article article) {
    return ListTile(
      onTap: () {
        Navigator.pushNamed(context, "/screens/single-news", arguments: article.id);
      },
      leading: SizedBox(
        width: 60,
        child: Hero(
          tag: "news:${article.id}",
          child: ImageNetworkWithToken(
            article.image,
            fit: BoxFit.cover,
          ),
        ),
      ),
      title: Text(article.title),
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
                Text("${article.likes}"),
                const SizedBox(width: 16),
                const Icon(
                  Icons.comment_rounded,
                ),
                const Text("0"),
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
