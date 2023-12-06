import 'package:app_nib/src/features/news/stores/news_store.dart';
import 'package:app_nib/src/shared/widgets/image_network_with_token.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:flutter/material.dart';

class SingleNewsScreen extends StatelessWidget {
  const SingleNewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final articleId = ModalRoute.of(context)!.settings.arguments as int;
    return FutureBuilder(
      future: context.read<NewsStore>().getArticleById(articleId),
      builder: (_, snap) {
        final article = snap.data;
        if (article == null) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return Scaffold(
          body: SizedBox(
            height: MediaQuery.sizeOf(context).height,
            child: Stack(
              fit: StackFit.passthrough,
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: SizedBox(
                    height: 200,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        ImageNetworkWithToken(article.image, fit: BoxFit.cover),
                        AppBar(
                          backgroundColor: Colors.transparent,
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 175,
                  child: Container(
                    height: MediaQuery.sizeOf(context).height - 175,
                    width: MediaQuery.sizeOf(context).width,
                    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Chip(
                              avatar: ClipOval(
                                child: article.author.avatar != null ? ImageNetworkWithToken(article.author.avatar!) : const Icon(Icons.person),
                              ),
                              elevation: 1,
                              side: BorderSide.none,
                              backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                              label: Text(article.author.name, style: const TextStyle(fontStyle: FontStyle.italic)),
                            ),
                            Chip(
                              elevation: 1,
                              side: BorderSide.none,
                              avatar: const Icon(Icons.access_time_rounded),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                              label: Text(timeago.format(article.createdAt, locale: 'pt_BR_short'), style: const TextStyle(fontWeight: FontWeight.bold)),
                            ),
                            ActionChip.elevated(
                              avatar: const Icon(Icons.thumb_up_alt_rounded),
                              label: Text('${article.likes}', style: const TextStyle(fontWeight: FontWeight.bold)),
                              onPressed: () {},
                            ),
                          ],
                        ),
                        Expanded(
                          child: ListView(
                            children: [
                              const SizedBox(height: 16),
                              Text(
                                article.title,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 24),
                              Text(article.content),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
