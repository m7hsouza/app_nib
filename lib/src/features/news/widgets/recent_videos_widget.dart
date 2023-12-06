import 'package:app_nib/src/features/news/models/video.dart';
import 'package:app_nib/src/features/news/stores/recent_videos_store.dart';
import 'package:app_nib/src/shared/widgets/image_network_with_token.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RecentVideosWidget extends StatefulWidget {
  const RecentVideosWidget({super.key});

  @override
  State<RecentVideosWidget> createState() => _RecentArticlesWidgetState();
}

class _RecentArticlesWidgetState extends State<RecentVideosWidget> {
  late final RecentVideosStore _store;
  @override
  void initState() {
    super.initState();
    _store = context.read<RecentVideosStore>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _store.getRecentVideos();
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
                'Videos',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              if (_store.videos.length > 6) TextButton(
                onPressed: () {},
                child: const Text('Ver mais'),
              )
            ],
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 120,
            child: switch (_store.state) {
              RecentVideosState.idle => const SizedBox(),
              RecentVideosState.loading => const Center(child: CircularProgressIndicator()),
              RecentVideosState.success => _succesBuild(_store.videos),
              RecentVideosState.error => null
            },
          ),
        ],
      ),
    );
  }

  Widget _succesBuild(List<Video> videos) {
    return ListView.separated(
      itemCount: videos.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (_, index) {
        final video = videos[index];
        return GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed('/show/video', arguments: video.id);
          },
          child: ClipRRect(
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
                      child: ImageNetworkWithToken(video.thumbnailUrl, fit: BoxFit.fill),
                    ),
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
                              video.title,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              softWrap: true,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Icon(Icons.thumb_up_alt_rounded, size: 12, color: Colors.grey.shade800),
                          const SizedBox(width: 4),
                          Text('${video.likes}')
                        ],
                      ),
                    ),
                  )
                ],
              ),
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
