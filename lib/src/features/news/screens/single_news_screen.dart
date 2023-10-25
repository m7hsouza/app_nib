import 'package:flutter/material.dart';

class SingleNewsScreen extends StatelessWidget {
  const SingleNewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final newsID = ModalRoute.of(context)!.settings.arguments as String;
    const news = {
      "id": "002",
      "title": "Tile 002",
      "content": "Sample description 002",
      "imageURL": "https://placehold.co/768x1366/png?text=News\n2",
      "likes": "10",
      "comments": "15",
    };

    return Scaffold(
      body: Column(
        children: [
          Hero(
            tag: "news:$newsID",
            child: Container(
              height: 250,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(news["imageURL"]!),
                  fit: BoxFit.cover,
                ),
              ),
              child: AppBar(
                backgroundColor: Colors.transparent,
              ),
            ),
          ),
          Expanded(
            child: Transform.translate(
              offset: const Offset(0, -32),
              child: Container(
                transformAlignment: Alignment.topCenter,
                width: double.infinity,
                padding: const EdgeInsets.only(top: 24),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Chip(
                            avatar: const CircleAvatar(
                              backgroundImage: NetworkImage("https://github.com/m7hsouza.png"),
                            ),
                            elevation: 1,
                            side: BorderSide.none,
                            backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                            label: const Text("Matheus L", style: TextStyle(fontStyle: FontStyle.italic)),
                          ),
                          Chip(
                            elevation: 1,
                            side: BorderSide.none,
                            avatar: const Icon(Icons.access_time_rounded),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                            label: const Text("10 h", style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                          ActionChip.elevated(
                            avatar: const Icon(Icons.thumb_up_alt_rounded),
                            label: const Text("10", style: TextStyle(fontWeight: FontWeight.bold)),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      news["title"]!,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
