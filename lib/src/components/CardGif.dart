import 'package:flutter/material.dart';



class CardGif extends StatelessWidget {
  final String id;
  final String url;
  final String preview;


  const CardGif({Key? key, required this.id, required this.url, required this.preview}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Column(
          children: [
            Image.network(url),
          ],
        ),
    );
  }
}
