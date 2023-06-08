import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class TextFieldAutocomplete extends StatefulWidget {
  final ValueChanged<String>? onChanged;

  const TextFieldAutocomplete({Key? key, this.onChanged}) : super(key: key);

  @override
  _TextFieldAutocompleteState createState() => _TextFieldAutocompleteState();
}

class _TextFieldAutocompleteState extends State<TextFieldAutocomplete> {
  final TextEditingController _textEditingController = TextEditingController();
  final Dio _dio = Dio();
  List<String> _suggestions = [];
  String _selectedSuggestion = '';

  void _fetchAutocomplete(String pattern) async {
    try {
      final response = await _dio.get('https://g.tenor.com/v1/autocomplete?key=LIVDSRZULELA&q=$pattern&limit=5');
      if (response.statusCode == 200) {
        final jsonResponse = response.data;
        final results = List<String>.from(jsonResponse['results']);
        setState(() {
          _suggestions = results;
        });
      }
    } catch (error) {
      print('Error fetching autocomplete: $error');
    }
  }


  void _selectSuggestion(String suggestion) {
    setState(() {
      _selectedSuggestion = suggestion;
      _textEditingController.text = suggestion;
      _suggestions = [];
    });

    if (widget.onChanged != null) {
      widget.onChanged!(suggestion);
    }
  }

  void _hideSuggestions() {
      setState(() {
        _suggestions = [];
      });

  }

  void _onSubmitted(String value) {
    _hideSuggestions();

    // Передача значення в наступний віджет або виконання іншої логіки
    // Ваш код тут
  }

  @override
  void initState() {
    super.initState();
    _textEditingController.addListener(() {
      final value = _textEditingController.text;
      if (value.isNotEmpty) {
        _fetchAutocomplete(value);
      } else {
        setState(() {
          _suggestions = [];
        });
      }
    });
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Enter the subject of the gif',
          ),
          controller: _textEditingController,
          onSubmitted: _onSubmitted,

        ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: _suggestions.length,
          itemBuilder: (BuildContext context, int index) {
            final suggestion = _suggestions[index];
            return ListTile(
              title: Text(suggestion),
              onTap: () {
                _selectSuggestion(suggestion);
                _hideSuggestions();
              }
            );
          },
        ),
      ],
    );
  }
}
