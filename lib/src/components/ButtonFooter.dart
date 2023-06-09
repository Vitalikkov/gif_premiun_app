import 'package:flutter/material.dart';

class ButtonFooter extends StatelessWidget {
  final VoidCallback onPressedHome;
  final VoidCallback onPressedSaves;
  final VoidCallback onPressedSettings;

  const ButtonFooter({
    required this.onPressedHome,
    required this.onPressedSaves,
    required this.onPressedSettings,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      color: Theme.of(context).colorScheme.primary,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            icon: Icon(
                Icons.home_outlined,
                color: Colors.white,
            ),
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/' ,
                 (route) => false,
              );
              onPressedHome;
            },
          ),
          IconButton(
            icon: Icon(
                Icons.star_border,
                color: Colors.white,
            ),
            onPressed: () {
              Navigator.pushNamed(
                context,
                '/saves' ,
              );
              onPressedSaves;
            },
          ),
          IconButton(
            icon: Icon(
                Icons.settings,
                color: Colors.white,
            ),
            onPressed: onPressedSettings,
          ),
        ],
      ),
    );
  }
}