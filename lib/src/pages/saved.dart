import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gif_premiun_app/src/data/db/db.dart';
import 'package:gif_premiun_app/src/components/CardGif.dart';
import 'package:gif_premiun_app/src/data/models/savedCard_model.dart';
import 'package:gif_premiun_app/src/components/ButtonFooter.dart';

class Saved extends StatefulWidget {
  const Saved({Key? key}) : super(key: key);

  @override
  State<Saved> createState() => _SavedState();
}

class _SavedState extends State<Saved> {
  List<SavedCardModal> _cards = [];
  List<String> ids = [];
  List<String> urls = [];
  List<String> previews = [];
  List<String> descriptions = [];

  @override
  void initState() {
    super.initState();
    // _getSavedCard();
  }

  // void _getSavedCard() async {
  //   List<SavedCardModal> cards = await DatabaseSql.getSavedCards();


  //   for (var card in cards) {
  //     ids.add(card.id);
  //     urls.add(card.gifUrl);
  //     previews.add(card.previewUrl);
  //     descriptions.add(card.contentDescription);
  //   }

  //   setState(() {
  //     _cards = cards;
  //   });


  // }

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
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('SaveCard').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if(!snapshot.hasData)
            return const Center( child: Text('Немає записів'),);
          return Container(
            padding: EdgeInsets.all(12),
            child: Expanded(
              child: GridView.builder(
                padding: EdgeInsets.all(8.0),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                ),
                //itemCount: ids.length,
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  return CardGif(
                    key: Key(snapshot.data!.docs[index].id),
                    id: snapshot.data!.docs[index].get('id'),
                    url: snapshot.data!.docs[index].get('gifUrl'),
                    preview: snapshot.data!.docs[index].get('previewUrl'),
                    contentDescription: snapshot.data!.docs[index].get('contentDescription'),
                    isFavorite: true,
                  );
                },
              ),
            ),
      
          );
        }
      ),
      bottomNavigationBar: ButtonFooter(onPressedHome: (){}, onPressedSaves: (){}, onPressedSettings: (){},),
    );
  }
}
