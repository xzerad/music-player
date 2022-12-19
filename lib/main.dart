import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:music_player/pages/home.dart';
import 'package:music_player/services/theme_mode_cubit.dart';

import 'constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ThemeModeCubit(), lazy: false,),
      ],
      child: Builder(
        builder: (context) {
          return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          themeMode: context.watch<ThemeModeCubit>().state.mode,
          theme: ThemeData(

            textTheme: const TextTheme(
              displayLarge: TextStyle(
                  color: kPrimaryBrightTextColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  fontFamily: "sf pro rounded"

              ),
              displayMedium: TextStyle(
                  color: kPrimaryBrightTextColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                  fontFamily: "sf pro rounded"

              ),
              displaySmall: TextStyle(
                  color: kPrimaryBrightTextColor,
                  fontWeight: FontWeight.normal,
                  fontSize: 15,
                  fontFamily: "sf pro rounded"

              ),
              bodySmall: TextStyle(
                  color: kUnselectedIconColor,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  fontFamily: "sf pro rounded"

              ),
              bodyMedium: TextStyle(
                  color: Color(0xCCFFFFFF),
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  fontFamily: "sf pro rounded"

              ),
            ),
            iconTheme: const IconThemeData(
              color: kUnselectedIconColor
            ),
            scaffoldBackgroundColor: kScaffoldBrightColor,
            bottomNavigationBarTheme: const BottomNavigationBarThemeData(
              backgroundColor: kScaffoldBrightColor,
              selectedIconTheme: IconThemeData(
                color: kBrightSelectedIconColor
              ),
              unselectedIconTheme: IconThemeData(
                color: kUnselectedIconColor
              )
            ),
            inputDecorationTheme: const InputDecorationTheme(
              fillColor: Color(0xCCe9e9e9),
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(Radius.circular(15)),

              )
            ),
            colorScheme: const ColorScheme.light(primary: kUnselectedIconColor),
            primaryColor: Colors.black
          ),
          darkTheme: ThemeData(
              textTheme:  const TextTheme(
                  displayLarge: TextStyle(
                      color: kPrimaryDarkTextColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      fontFamily: "sf pro rounded"
                  ),
                  displayMedium: TextStyle(
                      color: kPrimaryDarkTextColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                      fontFamily: "sf pro rounded"
                  ),
                  displaySmall: TextStyle(
                      color: kPrimaryDarkTextColor,
                      fontWeight: FontWeight.normal,
                      fontSize: 15,
                      fontFamily: "sf pro rounded"
                  ),
                  bodySmall: TextStyle(
                    color: kUnselectedIconColor,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    fontFamily: "sf pro rounded"

                  ),
                bodyMedium: TextStyle(
                    color: Color(0xCCFFFFFF),
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    fontFamily: "sf pro rounded"

                ),


              ),
              iconTheme: const IconThemeData(
                  color: kUnselectedIconColor
              ),
            scaffoldBackgroundColor: kScaffoldDarkColor,
              bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                  backgroundColor: kDarkBottomNavigationBarColor,
                  selectedIconTheme: IconThemeData(
                      color: kDarkSelectedIconColor
                  ),
                  unselectedIconTheme: IconThemeData(
                      color: kUnselectedIconColor
                  )
              ),
              inputDecorationTheme: const  InputDecorationTheme(
                  fillColor: Color(0x27e9e9e9),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),

              ),
              colorScheme: const ColorScheme.dark(primary: Color(0xff4f5668)),
              primaryColor: Colors.white
          ),
          home: const HomePage(),
          // home: const HomePage(path: "/storage/emulated/0/Music/Imagine Dragons - Sharks (Official Lyric Video).mp3"),
    );
        }
      ),
);
  }
}

