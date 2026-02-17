import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/article.dart';

class ArticleCard extends StatelessWidget {
  final Article article;

  const ArticleCard({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    // Normalize thumbnail URL: if backend returns a relative path (e.g. '/uploads/..')
    // or a host-local URL, convert it to a proper absolute URL the emulator/device can reach.
    String thumbnailUrl = article.thumbnail.trim();
    if (thumbnailUrl.isNotEmpty) {
      // If it starts with '/', assume it's relative to backend root
      if (thumbnailUrl.startsWith('/')) {
        thumbnailUrl = 'http://10.0.2.2:3000$thumbnailUrl';
      } else if (!thumbnailUrl.startsWith('http://') &&
          !thumbnailUrl.startsWith('https://')) {
        // If no scheme, try to prepend emulator host
        thumbnailUrl = 'http://10.0.2.2:3000/$thumbnailUrl';
      }
    }
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Constrain the image so it can't grow unbounded inside tight layouts
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: SizedBox(
              width: double.infinity,
              // limit height to a fraction of typical card size to avoid overflow
              height: 160,
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: (thumbnailUrl.isNotEmpty)
                    ? CachedNetworkImage(
                        imageUrl: thumbnailUrl,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                        placeholder: (c, s) =>
                            Container(color: Colors.grey[200]),
                        errorWidget: (c, s, e) {
                          // Helpful debug output when image fails to load
                          // ignore: avoid_print
                          print(
                            'CachedNetworkImage error loading: $thumbnailUrl -> $e',
                          );
                          return Container(
                            color: Colors.grey[200],
                            child: const Icon(Icons.broken_image),
                          );
                        },
                      )
                    : Container(
                        color: Colors.grey[200],
                        child: const Icon(Icons.image, size: 36),
                      ),
              ),
            ),
          ),
          // Use Flexible for the textual content so it can shrink when vertical space is limited
          Flexible(
            fit: FlexFit.loose,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          article.title,
                          style: const TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (article.isTrending)
                        Container(
                          margin: const EdgeInsets.only(left: 8),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Colors.orange, Colors.deepOrangeAccent],
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            'TRENDING',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    article.desc,
                    style: const TextStyle(color: Colors.black54, fontSize: 14),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const Icon(
                        Icons.access_time,
                        size: 14,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        article.createdAt.toLocal().toString(),
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                      // removed category label per design
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
