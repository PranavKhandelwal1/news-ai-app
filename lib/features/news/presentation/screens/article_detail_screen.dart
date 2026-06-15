/// =======================================================
/// File: article_detail_screen.dart
/// Feature: News
/// Description:
/// Displays complete news article information.
///
/// Responsibilities:
/// - Display article image
/// - Display title
/// - Display source
/// - Display publication date
/// - Display article content
/// - Navigate back to Home Screen
///
/// Future Enhancements:
/// - Bookmark article
/// - Share article
/// - Text-to-Speech
/// - AI Summary
/// =======================================================

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../bookmarks/providers/bookmark_provider.dart';
import '../../data/models/news_model.dart';
class ArticleDetailScreen extends ConsumerStatefulWidget {
  const ArticleDetailScreen({
    super.key,
    required this.article,
  });

  final NewsModel article;

  @override
  ConsumerState<ArticleDetailScreen> createState() =>
      _ArticleDetailScreenState();
}

class _ArticleDetailScreenState
    extends ConsumerState<ArticleDetailScreen> {

  bool isBookmarked = false;

  @override
  void initState() {
    super.initState();
    _checkBookmark();
  }

  Future<void> _checkBookmark() async {
    try {
      final saved = await ref
          .read(bookmarkRepositoryProvider)
          .isBookmarked(widget.article);

      if (mounted) {
        setState(() {
          isBookmarked = saved;
        });
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> _toggleBookmark() async {
    try {
      if (isBookmarked) {
        await ref
            .read(bookmarkRepositoryProvider)
            .removeBookmark(widget.article);

        setState(() {
          isBookmarked = false;
        });
      } else {
        await ref
            .read(bookmarkRepositoryProvider)
            .saveBookmark(widget.article);

        setState(() {
          isBookmarked = true;
        });
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [

          /// ===================================================
          /// App Bar with Hero Image
          /// ===================================================
          SliverAppBar(
            expandedHeight: 280,
            pinned: true,

            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                widget.article.image,
                fit: BoxFit.cover,

                errorBuilder: (
                    context,
                    error,
                    stackTrace,
                    ) {
                  return Container(
                    color: Colors.grey.shade300,
                    child: const Center(
                      child: Icon(
                        Icons.image_not_supported,
                        size: 50,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          /// ===================================================
          /// Article Content
          /// ===================================================
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),

              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,

                children: [

                  /// News Source
                  Text(
                    widget.article.source,
                    style: const TextStyle(
                      color: Colors.blue,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(height: 10),

                  /// News Headline
                  Text(
                    widget.article.title,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      height: 1.3,
                    ),
                  ),

                  const SizedBox(height: 16),

                  /// Publication Date
                  Row(
                    children: [
                      const Icon(
                        Icons.access_time,
                        size: 18,
                        color: Colors.grey,
                      ),

                      const SizedBox(width: 6),

                      Expanded(
                        child: Text(
                          widget.article.publishedAt,
                          style: TextStyle(
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  /// Divider
                  const Divider(),

                  const SizedBox(height: 24),

                  /// Description
                  if (widget.article.description.isNotEmpty)
                    Text(
                      widget.article.description,
                      style: const TextStyle(
                        fontSize: 18,
                        height: 1.6,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                  const SizedBox(height: 24),

                  /// Full Content
                  Text(
                    widget.article.content.isNotEmpty
                        ? widget.article.content
                        : "Full article content is not available from the API.",
                    style: const TextStyle(
                      fontSize: 16,
                      height: 1.8,
                    ),
                  ),

                  const SizedBox(height: 40),

                  /// ===================================================
                  /// Future Action Buttons
                  /// ===================================================
                  Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceEvenly,

                    children: [

                      /// Bookmark
                      GestureDetector(
                        onTap: _toggleBookmark,
                        child: Column(
                          children: [
                            Icon(
                              isBookmarked
                                  ? Icons.bookmark
                                  : Icons.bookmark_border,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              isBookmarked
                                  ? "Saved"
                                  : "Save",
                            ),
                          ],
                        ),
                      ),

                      /// Listen
                      Column(
                        children: const [
                          Icon(Icons.volume_up_outlined),
                          SizedBox(height: 4),
                          Text("Listen"),
                        ],
                      ),

                      /// AI Summary
                      Column(
                        children: const [
                          Icon(Icons.auto_awesome),
                          SizedBox(height: 4),
                          Text("Summary"),
                        ],
                      ),

                      /// Share
                      Column(
                        children: const [
                          Icon(Icons.share_outlined),
                          SizedBox(height: 4),
                          Text("Share"),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}