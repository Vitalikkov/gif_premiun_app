import 'package:flutter/material.dart';
import 'package:gif_premiun_app/src/components/TextFieldAutocomplete.dart' show TextFieldAutocomplete;
import 'package:gif_premiun_app/src/components/GridCardTemplete.dart';
import 'package:gif_premiun_app/src/components/ButtonFooter.dart';

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
      body: Container(
        padding: EdgeInsets.all(12),
        child: Column(

          children: [
            TextFieldAutocomplete(
              onChanged: (value) {
                updateSelectedValue(value);
              },
            ),
            SizedBox(height: 12),
            Expanded(
              child: selectedValue.isEmpty
                  ? const Center(
                child: Text('Не знайдено жодної картинки'),
              )
                  : GridCardTemplete(selectedValue),
            ),


          ],
        ),

      ),
        bottomNavigationBar: ButtonFooter(onPressedHome: (){}, onPressedSaves: (){}, onPressedSettings: (){},),
    );
  }
}