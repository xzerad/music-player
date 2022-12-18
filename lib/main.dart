import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_media_metadata/flutter_media_metadata.dart';
import 'package:image/image.dart' as img;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
                fontSize: 24
              ),
              displayMedium: TextStyle(
                  color: kPrimaryBrightTextColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 18
              ),
              displaySmall: TextStyle(
                  color: kPrimaryBrightTextColor,
                  fontWeight: FontWeight.normal,
                  fontSize: 15
              ),
              bodySmall: TextStyle(
                  color: kUnselectedIconColor,
                  fontSize: 13,
                  fontWeight: FontWeight.w500
              )
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
            colorScheme: const ColorScheme.light(primary: kUnselectedIconColor)
          ),
          darkTheme: ThemeData(
              textTheme:  const TextTheme(
                  displayLarge: TextStyle(
                      color: kPrimaryDarkTextColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 24
                  ),
                  displayMedium: TextStyle(
                      color: kPrimaryDarkTextColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 18
                  ),
                  displaySmall: TextStyle(
                      color: kPrimaryDarkTextColor,
                      fontWeight: FontWeight.normal,
                      fontSize: 15
                  ),
                  bodySmall: TextStyle(
                    color: kUnselectedIconColor,
                    fontSize: 13,
                    fontWeight: FontWeight.w500
                  )


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
          ),
          home: const HomePage(),
          // home: const HomePage(path: "/storage/emulated/0/Music/Imagine Dragons - Sharks (Official Lyric Video).mp3"),
    );
        }
      ),
);
  }
}

class HomePage_ extends StatefulWidget {
  const HomePage_({Key? key, required this.path}) : super(key: key);
  final String path;
  @override
  State<HomePage_> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage_> {
  Color? color;
  Uint8List? albumArt;
  String? albumName;
  String? songName;
  int trackDuration = 0;

  double playingProgress = 0.0;
  
  int abgrToArgb(int argbColor) {
    int r = (argbColor >> 16) & 0xFF;
    int b = argbColor & 0xFF;
    return (argbColor & 0xFF00FF00) | (b << 16) | r;
  }
  getMetaData() {
    File file = File(widget.path);
    MetadataRetriever.fromFile(file).then((metadata){
      print(metadata);
      setState(() {
        albumArt = metadata.albumArt;
        albumName = metadata.albumName;
        songName = metadata.trackName;
        trackDuration = (metadata.trackDuration ?? 0) ~/ 1000;

      });
      if (albumArt != null) {
        setBackgroundFromAlbumArt( albumArt!);
      }
    });


  }

  setBackgroundFromAlbumArt(Uint8List bytes){
      img.Image? photo = img.decodeImage(bytes);
      if(photo == null){
        return;
      }

      List<Color> pixels = [];

      for(int i=0; i< photo.width; i += 100){
        for(int j = 0; j < photo.height; j += 100){
          int pixel = photo.getPixel(i, j);
          pixels.add(Color(abgrToArgb(pixel)));

        }
      }

      Map<Color, int> pixelCount = <Color, int>{};
      for(Color pixel in pixels){
        pixelCount[pixel] = (pixelCount[pixel]?? 0) + 1;
      }
      int maxRep = 0;
      Color dominateColor = const Color(0x00000000);
      pixelCount.forEach((k,v){
        if(v>maxRep) {
          maxRep = v;
          dominateColor = k;
        }
      });
      setState(() {
        color = dominateColor;
      });

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMetaData();

  }



  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: color,
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            (albumArt != null)?ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(15)),
              child:  Image.memory(albumArt!, ),
            ): const SizedBox(),
            const SizedBox(height: 5,),
            Text(albumName ?? "", style: const TextStyle(color: kTransparentWhite, fontSize: 14),),
            const SizedBox(height: 5,),
            Text(songName ?? "", style: const TextStyle(color: Color(0x88FFFFFF), fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 5,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Icon(Icons.favorite_border_rounded, color: kTransparentWhite,),
                  Icon(Icons.share, color: kTransparentWhite,)
                ],
              ),
            ),

           Slider(value: playingProgress, onChanged: (value){
            setState((){
              playingProgress = value;
            });
          }, min: 0, max: trackDuration.toDouble() , activeColor: Colors.white, inactiveColor: kTransparentWhite,),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("${(playingProgress ~/ 60).toString().padLeft(2, "0")}:${(playingProgress % 60).toInt().toString().padLeft(2, "0")}", style: TextStyle(color: kTransparentWhite),),
                  Text("${(trackDuration ~/ 60).toString().padLeft(2, "0")}:${(trackDuration % 60).toString().padLeft(2, "0")}", style: TextStyle(color: kTransparentWhite),)
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}
