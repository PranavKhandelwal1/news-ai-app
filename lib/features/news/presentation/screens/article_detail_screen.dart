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
import 'package:intl/intl.dart';
import 'package:news_assistant/features/assistant/providers/tts_provider.dart';
import 'package:news_assistant/features/news/providers/share_provider.dart';
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
  bool isPlaying = false;
  late final tts;

  @override
  void initState() {
    super.initState();

    tts = ref.read(ttsProvider);

    _checkBookmark();

    tts.setCompletionHandler(() {
      if (mounted) {
        setState(() {
          isPlaying = false;
        });
      }
    });
  }

  @override
  void dispose() {
    debugPrint("ArticleDetailScreen disposed");
    tts.stop();
    super.dispose();
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

        if (!mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              "Bookmark Removed",
            ),
          ),
        );
      } else {
        await ref
            .read(bookmarkRepositoryProvider)
            .saveBookmark(widget.article);

        setState(() {
          isBookmarked = true;
        });

        if (!mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              "Article Saved",
            ),
          ),
        );
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> _toggleListen() async {
    try {
      if (isPlaying) {
        await tts.stop();
        setState(() {
          isPlaying = false;
        });
      } else {
        final fullText =
            "${widget.article.title}. "
            "${widget.article.description}. "
            "${widget.article.content}";

        await tts.speak(fullText);

        setState(() {
          isPlaying = true;
        });
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Read Full Article ",
          textAlign: TextAlign.start,
          style: TextStyle(
              fontWeight: FontWeight.bold
          ),
        ),
        centerTitle: true,
      ),

      body: CustomScrollView(
        slivers: [
          /// ===================================================
          /// App Bar with Hero Image
          /// ===================================================
          // SliverAppBar(
          //   automaticallyImplyLeading: false,
          //   expandedHeight: 280,
          //   pinned: true,
          //
          //   flexibleSpace: FlexibleSpaceBar(
          //     background: Image.network(
          //       widget.article.image,
          //       fit: BoxFit.cover,
          //
          //       errorBuilder: (
          //           context,
          //           error,
          //           stackTrace,
          //           ) {
          //         return Container(
          //           color: Colors.grey.shade300,
          //           child: const Center(
          //             child: Icon(
          //               Icons.image_not_supported,
          //               size: 50,
          //             ),
          //           ),
          //         );
          //       },
          //     ),
          //   ),
          // ),

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
                  /// News Headline
                  Text(
                    widget.article.title,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      height: 1.3,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      /// Left side (Source + Date)
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Source • ${widget.article.source}",
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),

                            Text(
                              formatDate(widget.article.publishedAt),
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(width: 16),

                      /// Right side (Bookmark)
                      GestureDetector(
                        onTap: _toggleBookmark,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              isBookmarked
                                  ? Icons.bookmark
                                  : Icons.bookmark_border,
                              size: 26,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              isBookmarked ? "Saved" : "Save",
                              style: const TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(
                      widget.article.image,
                      height: 220,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: 220,
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

                  const SizedBox(height: 10),

                  SizedBox(height: 10),
                  /// Divider
                  const Divider(color: Colors.black),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: CircleAvatar(
                          backgroundColor: Colors.black,
                          radius: 20,
                          child: Icon(
                              Icons.read_more,
                            color: Colors.white,
                            size: 25,
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Text(
                          "Read Summary With AI",
                          style:  TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                      ),
                    ],
                  ),
                  const Divider(color: Colors.black,),

                  const SizedBox(height: 10),

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

                      // /// Bookmark
                      // GestureDetector(
                      //   onTap: _toggleBookmark,
                      //   child: Column(
                      //     children: [
                      //       Icon(
                      //         isBookmarked
                      //             ? Icons.bookmark
                      //             : Icons.bookmark_border,
                      //       ),
                      //       const SizedBox(height: 4),
                      //       Text(
                      //         isBookmarked
                      //             ? "Saved"
                      //             : "Save",
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      //
                      // /// Listen
                      // GestureDetector(
                      //   onTap: _toggleListen,
                      //
                      //   child: Column(
                      //     children: [
                      //       Icon( isPlaying ? Icons.stop : Icons.volume_up_outlined),
                      //       const SizedBox(height: 4),
                      //       Text(isPlaying ? "Stop" : "Listen"),
                      //     ],
                      //   ),
                      // ),

                      // /// AI Summary
                      // Column(
                      //   children: const [
                      //     Icon(Icons.auto_awesome),
                      //     SizedBox(height: 4),
                      //     Text("Summary"),
                      //   ],
                      // ),

                      /// Share
                      GestureDetector(
                        onTap: () async {
                          await ref
                              .read(shareProvider)
                              .shareArticle(
                            title: widget.article.title,
                            url: widget.article.url,
                          );
                        },

                        child: const Column(
                          children: [
                            Icon(Icons.share_outlined),
                            SizedBox(height: 4),
                            Text("Share"),
                          ],
                        ),
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

      //  Floating Action button
      floatingActionButton: FloatingActionButton(
        onPressed: _toggleListen,
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        shape: const CircleBorder(),
        child: Icon(
          isPlaying ? Icons.stop : Icons.volume_up_outlined,
        ),
      ),
    );
  }
}
String formatDate(String date) {
  final parsedDate = DateTime.parse(date);
  return DateFormat('MMM d, yyyy • h:mm a').format(parsedDate);
}