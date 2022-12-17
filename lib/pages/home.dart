import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:music_player/services/theme_mode_cubit.dart';
import 'package:collection/collection.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body:  HomeBody(),
      bottomNavigationBar: CustomBottomNavigationBar()
    );
  }
}

class HomeBody extends StatelessWidget {
  const HomeBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("test", style: Theme.of(context).textTheme.displayLarge,),
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

    return Container(
      width: double.infinity,
      height: 60,
      color: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
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
    );

  }
}
