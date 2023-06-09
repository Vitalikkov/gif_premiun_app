import 'package:flutter/material.dart';
import 'package:gif_premiun_app/src/db/db.dart';
import 'package:gif_premiun_app/src/components/CardGif.dart';
import 'package:gif_premiun_app/src/modal/CardGifsModal.dart';
import 'package:gif_premiun_app/src/components/ButtonFooter.dart';

class Saved extends StatefulWidget {
  const Saved({Key? key}) : super(key: key);

  @override
  State<Saved> createState() => _SavedState();
}

class _SavedState extends State<Saved> {
  List<SavedCard> _cards = [];
  List<String> ids = [];
  List<String> urls = [];
  List<String> previews = [];
  List<String> descriptions = [];

  @override
  void initState() {
    super.initState();
    _getSavedCard();
  }

  void _getSavedCard() async {
    List<SavedCard> cards = await DatabaseProvider.getSavedCards();


    for (var card in cards) {
      ids.add(card.id);
      urls.add(card.url);
      previews.add(card.preview);
      descriptions.add(card.contentDescription);
    }

    setState(() {
      _cards = cards;
    });


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        title: const Text(
          'Saved Gifs',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            Expanded(
              child: GridView.builder(
                padding: EdgeInsets.all(8.0),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                ),
                itemCount: ids.length,
                itemBuilder: (context, index) {
                  return CardGif(
                      id: ids[index],
                      url: urls[index],
                      preview: previews[index],
                      content_description: descriptions[index],
                      isSaved: true,
                  );
                },
              ),
            ),


          ],
        ),

      ),
      bottomNavigationBar: ButtonFooter(onPressedHome: (){}, onPressedSaves: (){}, onPressedSettings: (){},),
    );
  }
}
