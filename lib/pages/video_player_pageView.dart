import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myapp/widget/card_video_player.dart';
import 'package:myapp/domain/domain_video_player.dart';
import 'package:myapp/db/database.dart';

class PageViewScreen extends StatefulWidget {
  const PageViewScreen({
    super.key,
  });

  @override
  State<PageViewScreen> createState() => _PageViewScreenState();
}

class _PageViewScreenState extends State<PageViewScreen> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return Scaffold(
      body: PageView.builder(
        scrollDirection: Axis.vertical,
        itemCount: Database.domainVideoPlayer.length,
        itemBuilder: (
          context,
          index,
        ) {
          return VideoPlayerScreen(
            domain_videoPlayer: Database.domainVideoPlayer[index],
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    super.dispose();
  }
}
