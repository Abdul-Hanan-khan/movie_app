import 'package:better_player/better_player.dart';

import 'package:flutter/material.dart';
import 'package:movie_db_app/constants.dart';

class BasicPlayerPage extends StatefulWidget {
  @override
  _BasicPlayerPageState createState() => _BasicPlayerPageState();
}

class _BasicPlayerPageState extends State<BasicPlayerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 8),
          AspectRatio(
            aspectRatio: 16 / 9,
            child: BetterPlayer.network(
              Constants.forBiggerBlazesUrl,
            ),
          ),

          const SizedBox(height: 8),
          // FutureBuilder<String>(
          //   future: Utils.getFileUrl(Constants.fileTestVideoUrl),
          //   builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          //     if (snapshot.data != null) {
          //       return BetterPlayer.file(snapshot.data!);
          //     } else {
          //       return const SizedBox();
          //     }
          //   },
          // )
        ],
      ),
    );
  }
}