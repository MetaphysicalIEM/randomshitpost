import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projectshitpost/video_page.dart';

// https://www.youtube.com/watch?v=hfF9tOKEpFg&ab_channel=yoanlul
// https://www.youtube.com/watch?v=xjwuAqgnk4I&t=3s&ab_channel=SCFChannel

class StoryPage extends StatefulWidget {
  const StoryPage({Key? key}) : super(key: key);

  @override
  State<StoryPage> createState() => _StoryPageState();
}

class _StoryPageState extends State<StoryPage> {
  final ScrollController _scrollController = ScrollController();
  final AudioPlayer _playerAudio = AudioPlayer();

  final String _urlBlue =
      'https://www.youtube.com/watch?v=hfF9tOKEpFg&ab_channel=yoanlul';
  final String _urlRed =
      ' https://www.youtube.com/watch?v=xjwuAqgnk4I&t=3s&ab_channel=SCFChannel';

  String _textAbout = '';
  bool _isTextReady = false;
  bool _isAnimationFinish = false;

  void timing() {
    const milliseconds = Duration(milliseconds: 500);
    Timer.periodic(milliseconds, (Timer timer) {
      if (_isAnimationFinish) {
        print('STOP PERIODIC!');
        timer.cancel();
      }
      print('Time scroll:  ${DateTime.now()}');
      autoScrool();
    });
  }

  void autoScrool() {
    try {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        curve: Curves.easeOut,
        duration: const Duration(milliseconds: 100),
      );
      debugPrint('scrolling');
    } catch (e) {
      print(e);
    }
  }

  Future<void> readFileAboutCharacter() async {
    debugPrint('reading...');

    try {
      final String loadedData =
          await rootBundle.loadString('assets/text/virgil.txt');
      _textAbout = loadedData;
      debugPrint('Could read file');
      setState(() {
        _isTextReady = true;
      });
    } catch (e) {
      debugPrint("Couldn't read file!!!");
    }
  }

  Future<void> playMusic() async {
    String localAsset = 'audios/bf_music.mp3';
    await _playerAudio.setSource(AssetSource(localAsset));
    _playerAudio.resume();
  }

  @override
  void initState() {
    super.initState();
    playMusic();
    timing();
    readFileAboutCharacter();
  }

  @override
  void dispose() {
    super.dispose();
    _playerAudio.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: _buildAnimation(),
    );
  }

  Widget _buildAnimation() {
    return !_isTextReady
        ? Center(
            child: CircularProgressIndicator(color: Colors.green),
          )
        : _buildSpecialText();
  }

  Widget _buildRowButton() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.35,
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        InkWell(
          onTap: () {
            print('blue');
            _playerAudio.stop();
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => VideoPage(url: _urlBlue)));
          },
          child: Container(
            width: MediaQuery.of(context).size.width * 0.45,
            height: MediaQuery.of(context).size.height * 0.15,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.blue,
            ),
            child: Center(
              child: Text(
                'I need more power!',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ),
        InkWell(
          onTap: () {
            print('red');
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => VideoPage(url: _urlRed)));
            _playerAudio.stop();
          },
          child: Container(
            width: MediaQuery.of(context).size.width * 0.45,
            height: MediaQuery.of(context).size.height * 0.15,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.red,
            ),
            child: Center(
              child: Text(
                'Fuck you http',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }

  Widget _buildSpecialText() {
    return Container(
      color: Colors.transparent,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        controller: _scrollController,
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            SizedBox(
              child: DefaultTextStyle(
                style: const TextStyle(fontSize: 20.0, color: Colors.white),
                child: Padding(
                  padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
                  child: AnimatedTextKit(
                    //stopPauseOnTap: true,
                    onFinished: () {
                      setState(() {
                        _isAnimationFinish = true;
                      });
                    },
                    onTap: () {
                      setState(() {
                        _isAnimationFinish = true;
                      });
                    },
                    isRepeatingAnimation: false,
                    repeatForever: false,
                    displayFullTextOnTap: true,
                    animatedTexts: [
                      TyperAnimatedText(_textAbout,
                          speed: const Duration(milliseconds: 60)),
                      // TyperAnimatedText('you must know what to do,'),
                      // TyperAnimatedText('and then do your best'),
                      // TyperAnimatedText('- W.Edwards Deming'),
                    ],
                  ),
                ),
              ),
            ),
            _isAnimationFinish ? _buildRowButton() : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
