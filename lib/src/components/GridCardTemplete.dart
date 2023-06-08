import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:gif_premiun_app/src/components/CardGif.dart';

class GridCardTemplete extends StatefulWidget {
  final String selectedValue;

  const GridCardTemplete(this.selectedValue, {Key? key}) : super(key: key);

  @override
  _GridCardTempleteState createState() => _GridCardTempleteState();
}

class _GridCardTempleteState extends State<GridCardTemplete> {
  List<dynamic> _gifs = [];
  String selectedValue = '';

  @override
  void initState() {
    super.initState();
    fetchGifs(widget.selectedValue);
  }

  void fetchGifs(String pattern) async {
    final apiKey = 'LIVDSRZULELA';
    final apiUrl = 'https://g.tenor.com/v1/search?q=$pattern&key=$apiKey';

    final dio = Dio();

    try {
      final response = await dio.get(apiUrl);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.data);
        final results = jsonData['results'] as List<dynamic>;

        setState(() {
          _gifs = results;
        });
      } else {
        throw Exception('Failed to fetch gifs');
      }
    } catch (e) {
      throw Exception('Failed to fetch gifs: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return _gifs.isEmpty
        ? const Center(
      child: CircularProgressIndicator(),
    )
        : GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemCount: _gifs.length,
      itemBuilder: (context, index) {
        final gif = _gifs[index];
        final id = gif['id'].toString();
        final gifUrl = gif['media'][0]['gif']['url'].toString();
        final previewUrl = gif['media'][0]['gif']['preview'].toString();

        return CardGif(
          id: id,
          url: gifUrl,
          preview: previewUrl,
        );
      },
    );
  }
}

