import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:gif_premiun_app/src/modal/CardGifsModal.dart';
import 'package:gif_premiun_app/src/db/db.dart';


class CardGif extends StatefulWidget {
  final String id;
  final String url;
  final String preview;
  final String content_description;
  final bool isSaved;

  const CardGif({
    Key? key,
    required this.id,
    required this.url,
    required this.preview,
    required this.content_description,
    this.isSaved = false,
  }) : super(key: key);



  @override
  State<CardGif> createState() => _CardGifState();
}

class _CardGifState extends State<CardGif> {
  Map<String, bool> isPressedMap = {};


  @override
  void initState() {
    super.initState();
    isPressedMap[widget.id] = false;
  }

  void onPressed() {
    setState(() {
      if (isPressedMap[widget.id] != null) {
        isPressedMap[widget.id] = !isPressedMap[widget.id]!;

        if (isPressedMap[widget.id]!) {
          final savedCard = SavedCard(
            id: widget.id,
            url: widget.url,
            preview: widget.preview,
            contentDescription: widget.content_description,
          );
          DatabaseProvider.insertCard(savedCard);
        } else {
          deleteCardFromDatabase();
        }
      }
    });
  }

  void deleteCardFromDatabase() async {
    await DatabaseProvider.deleteCard(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    final isPressed = isPressedMap[widget.id] ?? false;
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
                          builder: (context) => GifScreen(preview: widget.preview, content_description: widget.content_description),
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
                    if (widget.isSaved)
                      IconButton(
                        onPressed: deleteCardFromDatabase,
                        icon: Icon(
                          Icons.delete,
                          color: Colors.redAccent,
                        ),
                      ),
                    if (!widget.isSaved)
                      IconButton(
                        onPressed: onPressed,
                        icon: Icon(
                          isPressed ? Icons.star : Icons.star_border,
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
  final String content_description;

  const GifScreen({Key? key, required this.preview, required this.content_description}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(content_description),
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