import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  final String urlImage = 'https://images4.alphacoders.com/738/73806.jpg';
  final String assetImage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: Colors.transparent,
          shape: BoxShape.rectangle,
          image: DecorationImage(
            image: urlImage.isNotEmpty
                ? NetworkImage(urlImage)
                : AssetImage(assetImage) as ImageProvider,
          ),
        ),
      ),
    );
  }
}
