/// =======================================================
/// File: home_screen.dart
/// Feature: News
/// Description:
/// Main dashboard of News Assistant.
///
/// Responsibilities:
/// - Display latest news
/// - Display trending headlines
/// - Allow article navigation
/// - Refresh news feed
/// =======================================================

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../App_colors.dart';
import '../../providers/news_provider.dart';
import '../widgets/news_card.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(
      BuildContext context,
      WidgetRef ref,
      ) {

    final newsAsync =
    ref.watch(topNewsProvider);

    return Scaffold(

      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: const Text(
          "News Assistant",
          style: TextStyle(fontWeight: FontWeight.bold
          ),
        ),
        centerTitle: true,
      ),

      body: RefreshIndicator(

        onRefresh: () async {
          ref.refresh(topNewsProvider);
        },

        child: newsAsync.when(

          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),

          error: (error, stack) =>
              Center(
                child: Text(
                  error.toString(),
                ),
              ),

          data: (articles) {

            if (articles.isEmpty) {
              return const Center(
                child: Text(
                  "No news available",
                ),
              );
            }

            return ListView(
              padding: const EdgeInsets.all(16),

              children: [

                /// Greeting
                const Text(
                  "Good Morning!",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 6),

                const Text(
                  "Stay updated with the latest news",
                ),

                const SizedBox(height: 24),

                const Text(
                  "Top Headlines",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 16),

                ...articles.map(
                      (article) => NewsCard(
                    article: article,

                    onTap: () {

                      /// TODO:
                      /// Navigate to Article Detail Screen

                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}