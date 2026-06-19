/// =======================================================
/// File: bookmarks_screen.dart
/// Feature: Bookmarks
/// Description:
/// Displays all bookmarked articles saved by the user.
///
/// Responsibilities:
/// - Fetch bookmarks from Firestore
/// - Display saved articles
/// - Open article details
/// - Remove bookmarks
///
/// Author: Pranav Khandelwal
/// Project: News Assistant
/// =======================================================

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../news/data/models/news_model.dart';
import '../../../news/presentation/screens/article_detail_screen.dart';
import '../../../news/presentation/widgets/news_card.dart';
import '../../providers/bookmark_provider.dart';

class BookmarksScreen extends ConsumerWidget {
  const BookmarksScreen({
    super.key,
  });

  @override
  Widget build(
      BuildContext context,
      WidgetRef ref,
      ) {
    final bookmarkRepository =
    ref.read(bookmarkRepositoryProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Bookmarks",
          textAlign: TextAlign.start,
          style: TextStyle(
              fontWeight: FontWeight.bold
          ),
        ),
        centerTitle: true,
      ),

      body: StreamBuilder<QuerySnapshot>(
        stream: bookmarkRepository.getBookmarks(),

        builder: (
            context,
            snapshot,
            ) {
          /// Loading State
          if (snapshot.connectionState ==
              ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          /// Empty State
          if (!snapshot.hasData ||
              snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text(
                "No saved articles yet",
              ),
            );
          }

          final bookmarks =
              snapshot.data!.docs;

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: bookmarks.length,

            itemBuilder: (
                context,
                index,
                ) {
              final data =
              bookmarks[index].data()
              as Map<String, dynamic>;

              final article = NewsModel(
                title: data['title'],
                description:
                data['description'],
                content: data['content'],
                image: data['image'],
                url: data['url'],
                source: data['source'],
                publishedAt:
                data['publishedAt'],
              );

              return Dismissible(
                key: Key(
                  bookmarks[index].id,
                ),

                direction:
                DismissDirection.endToStart,

                onDismissed: (_) async {
                  await bookmarkRepository
                      .removeBookmark(
                    article,
                  );

                  if (!context.mounted) return;

                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(
                    const SnackBar(
                      content: Text(
                        "Bookmark removed",
                      ),
                    ),
                  );
                },

                background: Container(
                  alignment:
                  Alignment.centerRight,
                  padding:
                  const EdgeInsets.only(
                    right: 20,
                  ),
                  color: Colors.red,
                  child: const Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                ),

                child: NewsCard(
                  article: article,

                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            ArticleDetailScreen(
                              article: article,
                            ),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}