import 'package:flutter/material.dart';
import 'package:music_player/components/music_list_tile.dart';
import 'package:music_player/configurations/no_scroll_indication.dart';
import 'package:music_player/constants.dart';

import '../../components/search_bar.dart';

class FavoriteBody extends StatelessWidget {
  const FavoriteBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
      return SizedBox(
        height: size.height,
        width: size.width,
        child: ScrollConfiguration(
          behavior: NoScrollIndication(),
          child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.all(10.0),
              sliver: SliverToBoxAdapter(child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:  [
                  const SearchBar(),
                  const SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("My media library", style: Theme.of(context).textTheme.displayLarge,),
                      CircleAvatar(
                          backgroundColor: kUnselectedIconColor.withAlpha(99),
                          child: Icon(Icons.add, color: Theme.of(context).primaryColor))
                    ],
                  ),
                  const SizedBox(height: 20,),
                  Text("My first playlist", style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 17),),

                ],
              ),),
            ),
            SliverList(delegate: SliverChildBuilderDelegate((context, index){
              return const SizedBox(
                child: MusicListTile(),
              );
            }))



          ],
      ),
        ),
    );
  }
}
