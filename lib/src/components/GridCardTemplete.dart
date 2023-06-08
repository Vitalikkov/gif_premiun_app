import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:gif_premiun_app/src/components/CardGif.dart';

class GridCardTemplete extends StatefulWidget {
  final String selectedValue;

  const GridCardTemplete(this.selectedValue, {Key? key}) : super(key: key);

  @override
  _GridCardTempleteState createState() => _GridCardTempleteState();
}

class _GridCardTempleteState extends State<GridCardTemplete> {
  Map<String, dynamic> _gifs ={};
  List<String> _id = [];
  List<String> _gifUrl = [];
  List<String> _previewUrl = [];
  List<String> _content_description = [];

  String selectedValue = '';

  @override
  void initState() {
    super.initState();
    fetchGifs(widget.selectedValue);
  }

  @override
  void didUpdateWidget(GridCardTemplete oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedValue != selectedValue) {
      selectedValue = widget.selectedValue;
      fetchGifs(selectedValue);
    }
  }

  void fetchGifs(String pattern) async {
    final apiKey = 'LIVDSRZULELA';
    final apiUrl = 'https://g.tenor.com/v1/search?q=$pattern&key=$apiKey';

    final dio = Dio();

    try {
      final response = await dio.get<Map<String, dynamic>>(apiUrl);

      if (response.statusCode == 200) {
        final jsonData = response.data as Map<String, dynamic>;
        final results = jsonData['results'] as List<dynamic>;
        setState(() {
          _gifs = jsonData;
          _id = results.map((gif) => gif['id'].toString()).toList();
          _content_description = results.map((gif) => gif['content_description'].toString()).toList();
          _gifUrl = results.map((gif) => gif['media'][0]['gif']['url'].toString()).toList();
          _previewUrl = results.map((gif) => gif['media'][0]['gif']['preview'].toString()).toList();
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
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
      ),
      itemCount: _id.length,
      itemBuilder: (context, index) {


        return CardGif(
          id: _id[index],
          url: _gifUrl[index],
          preview: _previewUrl[index],
          content_description: _content_description[index],
        );
      },
    );
  }
}

