import 'package:flutter/material.dart';

import '../constants.dart';

class SelectedMusicCard extends StatelessWidget {
  const SelectedMusicCard({Key? key, required this.asset, required this.title}) : super(key: key);
  final String asset;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            child: Image.asset(asset),
          ),
           Positioned(
              bottom: 10,
              left: 10,
              right: 10,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(title, style: Theme.of(context).textTheme.displayMedium?.copyWith(color: Colors.white),),
                  const CircleAvatar(
                      backgroundColor: kUnselectedIconColor,
                      radius: 13,
                      child: Icon(Icons.play_arrow, color: Colors.white, size: 20,)),
                ],
              ))

        ],
      ),
    );
  }
}
