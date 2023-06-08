import 'package:flutter/material.dart';
import 'package:gif_premiun_app/src/components/TextFieldAutocomplete.dart' show TextFieldAutocomplete;
import 'package:gif_premiun_app/src/components/GridCardTemplete.dart';
import 'package:gif_premiun_app/src/components/CardGif.dart';

class Home extends StatefulWidget {
  @override

  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String selectedValue = '';

  void updateSelectedValue(String value) {
    setState(() {
      selectedValue = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
          title: const Text(
              'Gifanator 3000',
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
          centerTitle: true,
      ),
      body: Column(
        children: [
          TextFieldAutocomplete(
            onChanged: (value) {
              updateSelectedValue(value);
            },
          ),
          GridCardTemplete(selectedValue),
          //CardGif(id: "23521077", url: "https://media.tenor.com/wL59aqQiwzAAAAAC/cat-kitty.gif", preview: "https://media.tenor.com/wL59aqQiwzAAAAAD/cat-kitty.png"),


          // GridView.builder(
          //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          //     crossAxisCount: 2,
          //   ),
          //   itemCount: photos.length,
          //   itemBuilder: (context, index) {
          //   return Image.network(photos[index].thumbnailUrl);
          //   },
          // ),

        ],
      ),
    );
  }
}