import 'package:flutter/material.dart';
import 'package:music_player/components/search_bar.dart';

import '../../components/music_card.dart';
import '../../components/section_header.dart';
import '../../components/selected_music_card.dart';
import '../../configurations/no_scroll_indication.dart';
import '../../models/music.dart';
import '../../music_list.dart';
import '../music_player.dart';

class MusicBody extends StatelessWidget {
  const MusicBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SizedBox(
      width: size.width,
      height: size.height,
      child: ScrollConfiguration(
        behavior: NoScrollIndication(),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SearchBar(),
                    const SizedBox(height: 20,),
                    Text("New collections", style: Theme.of(context).textTheme.displayLarge,),
                    const SizedBox(height: 5,),
                  ],
                ),
              ),
              SizedBox(
                height: 150,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index){
                      return const SelectedMusicCard(
                        asset: "assets/images.jpg",
                        title: "Nature",
                      );
                    }),
              ),
              const SizedBox(height: 10,),
              const Padding(
                padding:  EdgeInsets.all(10.0),
                child:  SectionHeader(sectionName: 'Recently played',),
              ),
              SizedBox(
                height: 200,
                child: ScrollConfiguration(
                  behavior: NoScrollIndication(),
                  child: ListView.builder(
                      itemCount: musicList.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index){
                        Music music = musicList[index];
                        return GestureDetector(
                          onTap: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (context){
                              return MusicPlayer(music: music, prefix: "recently");
                            }));
                          },
                          child: MusicCard(
                            prefix: "recently",
                            music: music,
                          ),
                        );
                      }
                  ),
                ),
              ),
              const SizedBox(height: 10,),
              const Padding(
                padding:  EdgeInsets.all(10.0),
                child:  SectionHeader(sectionName: 'Trending music',),
              ),
              SizedBox(
                height: 200,
                child: ScrollConfiguration(
                  behavior: NoScrollIndication(),
                  child: ListView.builder(
                      itemCount: musicList.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index){
                        Music music = musicList[index];
                        return GestureDetector(
                          onTap: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (context){
                              return MusicPlayer(music: music, prefix: "trend",);
                            }));
                          },
                          child: MusicCard(
                            prefix: "trend",
                            music: music,
                          ),
                        );
                      }
                  ),
                ),
              ),

              const SizedBox(height: 150,)
            ],
          ),
        ),
      ),
    );
  }
}