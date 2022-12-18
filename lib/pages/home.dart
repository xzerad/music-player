import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:music_player/components/music_card.dart';
import 'package:music_player/components/section_header.dart';
import 'package:music_player/configurations/no_scroll_indication.dart';
import 'package:music_player/services/theme_mode_cubit.dart';
import 'package:collection/collection.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body:  SafeArea(child: HomeBody()),
      bottomNavigationBar: CustomBottomNavigationBar(),

    );
  }
}

class HomeBody extends StatelessWidget {
  const HomeBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var inputDecoration = Theme.of(context).inputDecorationTheme;
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
                    Container(
                      height: 45,
                      decoration: BoxDecoration(
                        color: inputDecoration.fillColor!,
                        borderRadius: const BorderRadius.all(Radius.circular(25))
                      ),
                      child: TextField(
                        cursorColor: Theme.of(context).iconTheme.color,
                        textAlignVertical: TextAlignVertical.center,
                        decoration: InputDecoration(
                          hintText: "Artist, Track or Album",
                          hintStyle: Theme.of(context).textTheme.bodySmall,
                          border: inputDecoration.border,
                          prefixIcon: const Icon(Icons.search),
                          prefixIconColor: Theme.of(context).iconTheme.color,
                          prefixStyle: TextStyle(color: Theme.of(context).iconTheme.color)
                        ),
                      ),
                    ),
                    const SizedBox(height: 20,),
                    Text("Selections for you", style: Theme.of(context).textTheme.displayLarge,),
                    const SizedBox(height: 10,),
                  ],
                ),
              ),
              const Padding(
                padding:  EdgeInsets.all(10.0),
                child:  SectionHeader(sectionName: 'Recently played',),
              ),
              SizedBox(
                height: 200,
                child: ScrollConfiguration(
                  behavior: NoScrollIndication(),
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index){
                        return const MusicCard(
                          imageAsset: 'assets/Music App UI Design 2.png',
                          trackName: 'What a time',
                          artistName: 'xzerad',
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
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index){
                        return const MusicCard(
                          imageAsset: 'assets/Music App UI Design 2.png',
                          trackName: 'What a time',
                          artistName: 'xzerad',
                        );
                      }
                  ),
                ),
              ),
              const SizedBox(height: 10,),

              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      child: const Icon(Icons.shield_moon_outlined), onPressed: (){
                        context.read<ThemeModeCubit>().setDarkMode();
                    },
                    ),
                    ElevatedButton(
                      child: Icon(Icons.sunny), onPressed: (){
                      context.read<ThemeModeCubit>().setBrightMode();
                    },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar({Key? key}) : super(key: key);

  @override
  State<CustomBottomNavigationBar> createState() => _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  int selectedIndex = 0 ;

  List<IconData> icons = [
    FontAwesomeIcons.solidMoon,
    FontAwesomeIcons.music,
    FontAwesomeIcons.solidHeart,
    FontAwesomeIcons.solidUser,
  ];
  @override
  Widget build(BuildContext context) {
    bool played = true;

    return Container(
      width: double.infinity,
      height: 60 + 70* (played?1:0),
      color: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
      child: Column(
        children: [
          if(played)
          SizedBox(
            height: 70,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 2.0),
                    child: ClipRRect(
                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                        child: Image.asset("assets/Music App UI Design 2.png"),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("What a time", style: Theme.of(context).textTheme.displaySmall,),
                        Text("Xzerad", style: Theme.of(context).textTheme.bodySmall,)
                      ],
                    ),
                  ),
                  Row(
                    children:  [
                       Icon(Icons.pause, color: Theme.of(context).bottomNavigationBarTheme.selectedIconTheme?.color,),
                       Icon(Icons.skip_next, color: Theme.of(context).bottomNavigationBarTheme.selectedIconTheme?.color),
                    ],
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: icons.mapIndexed((index, icon) {
                var theme = Theme.of(context).bottomNavigationBarTheme;
                return InkWell(
                    onTap: (){
                      setState(() {
                        selectedIndex = index;

                      });
                    },
                    child: SizedBox(child: FaIcon(icon, color: (index == selectedIndex)?theme.selectedIconTheme?.color:theme.unselectedIconTheme?.color,)));}).toList()
            ),
          ),
        ],
      ),
    );

  }
}
