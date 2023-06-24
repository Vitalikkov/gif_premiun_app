import 'package:flutter/material.dart';
import 'package:gif_premiun_app/src/api/api.dart';

class TextFieldAutocomplete extends StatefulWidget {
  final ValueChanged<String>? onChanged;

  const TextFieldAutocomplete({Key? key, this.onChanged}) : super(key: key);

  @override
  _TextFieldAutocompleteState createState() => _TextFieldAutocompleteState();
}


class _TextFieldAutocompleteState extends State<TextFieldAutocomplete> {
  final TextEditingController _textEditingController = TextEditingController();
  
  List<String> _suggestions = [];
  String _selectedSuggestion = '';

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
    setState(() {
      _selectedSuggestion = '';
    });
    if (widget.onChanged != null) {
      widget.onChanged!(value);
    }
  }

   void _fetchAutocompleteData(String value) async {
    if (value.isNotEmpty) {
      final autocompleteData = await Api.fetchAutocomplete(value);
      setState(() {
        _suggestions = autocompleteData?.results ?? [];
      });
    } else {
      setState(() {
        _suggestions = [];
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _textEditingController.addListener(() {
      final value = _textEditingController.text;
      if (value.isNotEmpty) {
        _fetchAutocompleteData(value);
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
            hintText: 'Введіть назву картинки',
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
