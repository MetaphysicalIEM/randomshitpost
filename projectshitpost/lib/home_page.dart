import 'package:flutter/material.dart';
import 'package:projectshitpost/story_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  final String urlImage = 'https://c.tenor.com/uI8oAgroF60AAAAd/anime-fate.gif';
  final String assetImage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        width: MediaQuery.of(context).size.width * 1,
        height: MediaQuery.of(context).size.height * 1,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          color: Colors.transparent,
          shape: BoxShape.rectangle,
          image: DecorationImage(
            fit: BoxFit.cover,
            filterQuality: FilterQuality.high,
            image: urlImage.isNotEmpty
                ? NetworkImage(urlImage)
                : AssetImage(assetImage) as ImageProvider,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => StoryPage()));
        },
        child: Text('Next'),
      ),
    );
  }
}
