import 'package:flutter/material.dart';
import 'package:my_bili_f/model/video_model.dart';

@immutable
class HomePage extends StatefulWidget {
  final ValueChanged<VideoModel> onJumpDetail;

  const HomePage({Key? key, required this.onJumpDetail}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            const Text('this is home page'),
            const SizedBox(
              height: 20,
            ),
            MaterialButton(
              onPressed: () => widget.onJumpDetail(VideoModel(2222)),
              child: const Text('go to detail'),
            )
          ],
        ),
      ),
    );
  }
}
