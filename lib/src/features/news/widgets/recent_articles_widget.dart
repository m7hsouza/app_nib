import 'package:app_nib/src/features/news/models/article.dart';
import 'package:app_nib/src/features/news/stores/recent_articles_store.dart';
import 'package:app_nib/src/shared/widgets/image_network_with_token.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RecentArticlesWidget extends StatefulWidget {
  const RecentArticlesWidget({super.key});

  @override
  State<RecentArticlesWidget> createState() => _RecentArticlesWidgetState();
}

class _RecentArticlesWidgetState extends State<RecentArticlesWidget> {
  late final RecentArticlesStore _store;
  @override
  void initState() {
    super.initState();
    _store = context.read<RecentArticlesStore>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _store.getRecentArticles();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Devocionais',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              if (_store.articles.length > 6) TextButton(
                onPressed: () {},
                child: Text('Ver mais'),
              )
            ],
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 120,
            child: switch (_store.state) {
              RecentArticleState.idle => const SizedBox(),
              RecentArticleState.loading => const Center(child: CircularProgressIndicator()),
              RecentArticleState.success => _succesBuild(_store.articles),
              RecentArticleState.error => null
            },
          ),
        ],
      ),
    );
  }

  Widget _succesBuild(List<Article> articles) {
    return ListView.separated(
      itemCount: articles.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (_, index) {
        final article = articles[index];
        return ClipRRect(
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(8),
          ),
          child: SizedBox(
            width: 160,
            child: Column(
              children: [
                Expanded(
                  child: ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        bottom: Radius.circular(8),
                      ),
                      child: ImageNetworkWithToken(article.image, fit: BoxFit.fill)),
                ),
                Container(
                  height: 35,
                  padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
                  child: DefaultTextStyle(
                    style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic, color: Colors.grey.shade800),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            article.title,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            softWrap: true,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Icon(Icons.thumb_up_alt_rounded, size: 12, color: Colors.grey.shade800),
                        const SizedBox(width: 4),
                        Text('${article.likes}')
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
      separatorBuilder: (_, __) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: RotatedBox(
            quarterTurns: 1,
            child: Divider(
              color: Colors.grey.shade200,
            ),
          ),
        );
      },
    );
  }
}
