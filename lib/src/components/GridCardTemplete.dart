import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:gif_premiun_app/src/api/api.dart';
import 'package:gif_premiun_app/src/api/models/gifs_model.dart';
import 'package:gif_premiun_app/src/components/CardGif.dart';

class GridCardTemplete extends StatefulWidget {
  final String selectedValue;

  const GridCardTemplete(this.selectedValue, {Key? key}) : super(key: key);

  @override
  _GridCardTempleteState createState() => _GridCardTempleteState();
}

class _GridCardTempleteState extends State<GridCardTemplete> {
  
  List<String> _id = [];
  List<String> _gifUrl = [];
  List<String> _previewUrl = [];
  List<String> _contentDescription = [];
  String selectedValue = '';


  void _fetchGifs(String value) async {
      try {
      final gifsData = await Api.fetchGifs(selectedValue);
      
      setState(() {
          _id = gifsData.id;
          _gifUrl = gifsData.gifUrl;
          _previewUrl = gifsData.previewUrl;
          _contentDescription = gifsData.contentDescription;
        });
    } catch (error) {
      print('Error fetching gifs: $error');
    }
  }

 
  Future<bool> isCardSaved(String id) async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('SaveCard')
        .where('id', isEqualTo: id)
        .get();

    return querySnapshot.docs.isNotEmpty;
  }

  

  @override
  void initState() {
    super.initState();
    _fetchGifs(widget.selectedValue);
  }

  @override
  void didUpdateWidget(GridCardTemplete oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedValue != selectedValue) {
      selectedValue = widget.selectedValue;
      _fetchGifs(selectedValue);
    }
  }


  @override
  Widget build(BuildContext context) {
    return _id.isEmpty
        ? const Center(
      child: CircularProgressIndicator(),
    )
        : GridView.builder(
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
      ),
      itemCount: _id.length,
      itemBuilder: (context, index) {
        return FutureBuilder<bool>(
                future: isCardSaved(_id[index]),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    final isSaved = snapshot.data ?? false;
                    return CardGif(
                      id: _id[index],
                      url: _gifUrl[index],
                      preview: _previewUrl[index],
                      contentDescription: _contentDescription[index],
                      isSaved: isSaved,
                    );
                  }
                },
              );
            },
          );
  }
}
