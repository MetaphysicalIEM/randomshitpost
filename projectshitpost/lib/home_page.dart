import 'package:flutter/material.dart';
import 'package:projectshitpost/story_page.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final String urlImage =
      'https://thumbs.gfycat.com/FemaleVictoriousIberianemeraldlizard-size_restricted.gif';
  final String assetImage = '';
  final List<String> listUrl = [
    'https://media1.giphy.com/media/fK7cvGCp0ytYb00xVm/giphy.gif?cid=ecf05e47jcxvn3xl4x7jxlxom5geeo1f49zrvpxv5liwudop&rid=giphy.gif&ct=g',
    'https://media3.giphy.com/media/XAyBIZzkfxKshDS7ks/giphy.gif?cid=ecf05e4735xk0fnflv15x88iauwu82dzud5pp0l6hnvl460q&rid=giphy.gif&ct=g',
    'https://media1.giphy.com/media/BxQKxzvfqsDOE/giphy.gif?cid=ecf05e47notik5lbw50qxdj5qady7htkrwevju1hhrlnpa8w&rid=giphy.gif&ct=g',
    'https://media4.giphy.com/media/Y8K0XaIY7WR9VBRSHe/giphy.gif?cid=ecf05e47ttg0b2vr0v1aavm0vpqesjy5gkfrvtvao2wy0zh1&rid=giphy.gif&ct=g'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hello'),
        centerTitle: true,
        leading: CircleAvatar(
          backgroundImage: NetworkImage(
              'https://www.francaisauthentique.com/wp-content/uploads/2019/05/Miniature-Au-pif.jpg'),
        ),
      ),
      backgroundColor: Colors.transparent,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          color: Colors.transparent,
          shape: BoxShape.rectangle,
        ),
        child: ListView.builder(
          itemCount: listUrl.length,
          itemBuilder: (context, index) {
            return BackgroundImage(urlImage: listUrl[index]);
          },
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

class BackgroundImage extends StatelessWidget {
  final String urlImage;
  const BackgroundImage({Key? key, required this.urlImage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.25,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.transparent,
        shape: BoxShape.rectangle,
        image: DecorationImage(
          fit: BoxFit.cover,
          filterQuality: FilterQuality.high,
          image: NetworkImage(urlImage),
        ),
      ),
    );
  }
}
