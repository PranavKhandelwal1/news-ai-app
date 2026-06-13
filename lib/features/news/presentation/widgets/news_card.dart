/// =======================================================
/// File: news_card.dart
/// Feature: News
/// Description:
/// Reusable card widget used to display a news article.
///
/// Responsibilities:
/// - Display article image
/// - Display title
/// - Display source
/// - Handle article click
/// =======================================================

import 'package:flutter/material.dart';

import '../../../../App_colors.dart';
import '../../data/models/news_model.dart';

class NewsCard extends StatelessWidget {
  final NewsModel article;
  final VoidCallback onTap;

  const NewsCard({
    super.key,
    required this.article,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,

      child: Card(
        margin: const EdgeInsets.only(bottom: 16),
        elevation: 3,
        color: backgroundColor,

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// News Image
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(16),
              ),

              child: Image.network(
                article.image,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,

                errorBuilder:
                    (_, __, ___) =>
                    Container(
                      height: 200,
                      color: Colors.grey.shade300,
                      child: const Center(
                        child: Icon(Icons.image_not_supported),
                      ),
                    ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(12),

              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [

                  /// News Source
                  Text(
                    article.source,
                    style: const TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(height: 8),

                  /// Headline
                  Text(
                    article.title,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,

                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  /// Description
                  Text(
                    article.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,

                    style: TextStyle(
                      color: Colors.grey.shade700,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}