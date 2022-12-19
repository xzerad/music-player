import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:music_player/components/button_circular_splash.dart';
import 'package:music_player/pages/home/favorite_body.dart';
import 'package:collection/collection.dart';
import 'home/home_body.dart';
import 'home/music_body.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Widget> pages = const [
    HomeBody(),
    MusicBody(),
    FavoriteBody(),
    FavoriteBody(),

  ];

  int selectedPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body:  SafeArea(
          bottom: false,
          child: pages[selectedPage],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        onChange: (index){
          setState(() {
            selectedPage = index;
          });
        },
      ),

    );
  }
}



class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar({Key? key, this.onChange}) : super(key: key);

  final void Function(int)? onChange;

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

    return SizedBox(
      width: double.infinity,
      height: 60 + 70* (played?1:0),
      child: Column(
        children: [
          if(played)
          Material(
            color: Theme.of(context).bottomNavigationBarTheme.backgroundColor?.withOpacity(0.5),

            child: Stack(
              children: [
                ClipRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                    child: SizedBox(
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
                  ),
                ),
              ],
            ),
          ),
          Material(
            color: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
            child: SizedBox(
              height: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: icons.mapIndexed((index, icon) {
                  var theme = Theme.of(context).bottomNavigationBarTheme;
                  return ButtonCircularSplash(
                      onPress: (){
                        setState(() {
                          selectedIndex = index;
                          widget.onChange?.call(index);
                        });
                      },
                      icon: SizedBox(child: FaIcon(icon, color: (index == selectedIndex)?theme.selectedIconTheme?.color:theme.unselectedIconTheme?.color,)));
                  }).toList()
              ),
            ),
          ),
        ],
      ),
    );

  }
}
