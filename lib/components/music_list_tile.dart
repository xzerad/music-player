import 'package:flutter/material.dart';

class MusicListTile extends StatelessWidget {
  const MusicListTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
      child: Container(

        decoration: const BoxDecoration(
          color: Color(0xffdfdfe1),
          borderRadius: BorderRadius.all(Radius.circular(15))
        ),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: ClipRRect(
                  borderRadius: const BorderRadius.only(topLeft:Radius.circular(15), bottomLeft: Radius.circular(15)),
                  child: Image.asset("assets/Music App UI Design.png",)),
            ),
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  Text("Return to faery land", style: Theme.of(context).textTheme.displayMedium?.copyWith(fontWeight: FontWeight.bold, color: Colors.black) ,),
                  Text("Music magika, dulcamara",style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 15, color: Colors.grey)),
                ],
              ),
            ),
            const Expanded(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Icon(Icons.more_horiz),
                ))
          ],

        ),
      ),
    );
  }
}
