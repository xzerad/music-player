import 'package:flutter/material.dart';
import 'package:music_player/constants.dart';

class MusicCard extends StatelessWidget {
  const MusicCard({Key? key, required this.imageAsset, required this.trackName,
    required this.artistName}) : super(key: key);

  final String imageAsset, trackName, artistName;
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
                  ClipRRect(
                     borderRadius: const BorderRadius.all(Radius.circular(15)),
                      child: Image.asset(imageAsset)),
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
            Text(trackName, style: Theme.of(context).textTheme.displaySmall,),
            Text(artistName, style: Theme.of(context).textTheme.bodySmall,)
          ],
        ),
      ),
    );
  }
}
