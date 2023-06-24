
import 'package:flutter/material.dart';
import 'package:gif_premiun_app/src/data/models/savedCard_model.dart';
import 'package:share_plus/share_plus.dart';
import 'package:gif_premiun_app/src/data/db/db.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';


class CardGif extends StatefulWidget {
  final String id;
  final String url;
  final String preview;
  final String contentDescription;
  final bool isFavorite;
  final bool isSaved;

  const CardGif({
    Key? key,
    required this.id,
    required this.url,
    required this.preview,
    required this.contentDescription,
    this.isFavorite = false,
    this.isSaved = false,
  }) : super(key: key);



  @override
  State<CardGif> createState() => _CardGifState();
}

class _CardGifState extends State<CardGif> {
  bool isSaved = false;

  Future<void> toggleSavedStatus() async {
    setState(() {
      isSaved = !isSaved;
    });

    if (isSaved) {
      await saveCard();
    } else {
      await deleteCard();
    }
  }

  Future<void> saveCard() async {
    await FirebaseFirestore.instance.collection('SaveCard').add({
      'id': widget.id,
      'gifUrl': widget.url,
      'previewUrl': widget.preview,
      'contentDescription': widget.contentDescription,
    });
  }

  Future<void> deleteCard() async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('SaveCard')
        .where('id', isEqualTo: widget.id)
        .get();

    querySnapshot.docs.forEach((doc) {
      doc.reference.delete();
    });
  }
  

  @override
  void initState() {
    super.initState();

    isSaved = widget.isSaved;
   
  }

  

 

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                // flex: 4,
                child: Container(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => GifScreen(preview: widget.preview, contentDescription: widget.contentDescription),
                        ),
                      );
                    },
                    child: Image.network(
                      widget.url,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () { Share.share(widget.url); },
                      icon: Icon(
                          Icons.share_sharp,
                          color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    if (widget.isFavorite)
                      IconButton(
                        onPressed: () {deleteCard();},
                        icon: Icon(
                          Icons.delete,
                          color: Colors.redAccent,
                        ),
                      ),
                    if (!widget.isFavorite)
                      IconButton(
                        onPressed: toggleSavedStatus,
                        icon: Icon(
                          isSaved ? Icons.star : Icons.star_border,
                          color: Colors.amber,
                        ),
                      ),

                  ],
                ),
              ),
            ],
          ),
        ),
    );
  }
}


class GifScreen extends StatelessWidget {
  final String preview;
  final String contentDescription;

  const GifScreen({Key? key, required this.preview, required this.contentDescription}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(contentDescription),
        centerTitle: true,
      ),
      body: Container(
        child: Center(
          child: Image.network(
            preview,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}