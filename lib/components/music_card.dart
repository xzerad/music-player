import 'package:flutter/material.dart';
import 'package:music_player/constants.dart';

import '../models/music.dart';

class MusicCard extends StatelessWidget {
  const MusicCard({Key? key, required this.music, required this.prefix}) : super(key: key);
  final String prefix;
  final Music music;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, ),
      child: AspectRatio(
        aspectRatio: 4/5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                  Hero(
                    tag: "$prefix${music.id}",
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                      child: Image.asset(music.asset),
                    ),
                  ),
                  const Positioned(
                      bottom: 10,
                      right: 10,
                      child: CircleAvatar(
                          backgroundColor: kUnselectedIconColor,
                          radius: 13,
                          child: Icon(Icons.play_arrow, color: Colors.white, size: 20,)))
              ],
            ),
            const SizedBox(height: 5,),
            Text(music.title, style: Theme.of(context).textTheme.displaySmall,),
            Text(music.artist, style: Theme.of(context).textTheme.bodySmall,)
          ],
        ),
      ),
    );
  }
}
