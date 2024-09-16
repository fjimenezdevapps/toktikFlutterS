import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toktik/domain/repositories/video_posts_repository.dart';
import 'package:toktik/infrastructure/datasources/local_videos_datasource_impl.dart';
import 'package:toktik/infrastructure/repositories/video_posts_repository.dart';
import 'package:toktik/presentation/discover/discover_screen.dart';
import 'package:toktik/presentation/providers/discover_provider.dart';

import 'config/theme/app_theme.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final videoPostRepository =
        VideoPostsRepositoryImpl(videoPostsDatasource: LocalVideosDatasource());

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            lazy: false,
            create: (_) =>
                DiscoverProvider(videoPostRepository: videoPostRepository)
                  ..loadNextPage()),
      ],
      child: MaterialApp(
          title: 'TokTik',
          debugShowCheckedModeBanner: false,
          theme: AppTheme().getTheme(),
          home: const DiscoverScreen()),
    );
  }
}
