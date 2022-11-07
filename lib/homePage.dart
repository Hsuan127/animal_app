import 'package:animal_app/signIn_signUp_item/sign_in_page.dart';
// import 'package:animal_app/temp_utils/matchScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

/*
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('首頁'),
      ),
      body: Center(child: Text("首頁")),
    );
  }
}
 */

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text("首頁"),
      ),
      body: GamePage(
        videoPlayerController: VideoPlayerController.asset(
          'assets/videos/game_1.mp4',
        ),
        looping: true,
        autoplay: true,
      ),
    );
  }
}
class GamePage extends StatefulWidget{
  final VideoPlayerController videoPlayerController;
  final bool looping;
  final bool autoplay;


  GamePage({
    required this.videoPlayerController,
    required this.looping, required this.autoplay,
    Key? key,
  }) : super(key: key);

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  late ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    _chewieController = ChewieController(
      videoPlayerController: widget.videoPlayerController,
      aspectRatio:10/16,
      autoInitialize: true,
      autoPlay: widget.autoplay,
      looping: widget.looping,
      errorBuilder: (context, errorMessage) {
        return Center(
          child: Text(
            errorMessage,
            style: TextStyle(color: Colors.white),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _chewieController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0),
      child: Chewie(
        controller: _chewieController,
      ),
    );
  }
}