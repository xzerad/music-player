import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image/image.dart' as img;
import 'package:flutter/material.dart';
import 'package:music_player/components/button_circular_splash.dart';
import '../constants.dart';
import '../models/music.dart';

class MusicPlayer extends StatefulWidget {
  const MusicPlayer({Key? key, required this.music, required this.prefix}) : super(key: key);
  final Music music;
  final String prefix;
  @override
  State<MusicPlayer> createState() => _MusicPlayerState();
}

class _MusicPlayerState extends State<MusicPlayer> {
  Color? color;
  String? albumName;
  String? songName;
  double playingProgress = 0.0;

  int abgrToArgb(int argbColor) {
    int r = (argbColor >> 16) & 0xFF;
    int b = argbColor & 0xFF;
    return (argbColor & 0xFF00FF00) | (b << 16) | r;
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
    rootBundle.load(widget.music.asset).then((value){
      setBackgroundFromAlbumArt(value.buffer.asUint8List());
    });


  }



  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Music music = widget.music;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: GestureDetector(
            onTap: Navigator.of(context).pop,
            child: const Icon(Icons.keyboard_arrow_left)),
        title: Text(widget.music.category, style: Theme.of(context).textTheme.bodyMedium,),
        centerTitle: true,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 18.0),
            child: Icon(Icons.more_horiz_outlined),
          )
        ],
      ),
      backgroundColor: color,
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Hero(
                tag: "${widget.prefix}${music.id}",
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                  child: Image.asset(music.asset),
                ),
              ),
              const SizedBox(height: 5,),
              Text(music.artist, style: const TextStyle(color: kTransparentWhite, fontSize: 15),),
              const SizedBox(height: 5,),
              Text(music.title, style: const TextStyle(color: Color(0xFFFFFFFF), fontSize: 24, fontWeight: FontWeight.bold, fontFamily: "sf pro rounded")),
              const SizedBox(height: 5,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    StatefulBuilder(
                      builder: (context, setState) {
                        return GestureDetector(
                            onTap: (){
                              setState((){
                                  music.favorite = !music.favorite;
                              });
                            },
                            child: (music.favorite)?const Icon(Icons.favorite, color: Color(0xffb625a8),):const Icon(Icons.favorite_border_rounded, color: kTransparentWhite,));
                      }
                    ),
                    const Icon(Icons.share, color: kTransparentWhite,)
                  ],
                ),
              ),

              Slider(value: playingProgress, onChanged: (value){
                setState((){
                  playingProgress = value;
                });
              }, min: 0, max: music.trackDuration.toDouble() , activeColor: Colors.white, inactiveColor: kTransparentWhite,),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("${(playingProgress ~/ 60).toString().padLeft(2, "0")}:${(playingProgress % 60).toInt().toString().padLeft(2, "0")}", style: const TextStyle(color: kTransparentWhite),),
                        Text("${(music.trackDuration ~/ 60).toString().padLeft(2, "0")}:${(music.trackDuration % 60).toString().padLeft(2, "0")}", style: const TextStyle(color: kTransparentWhite),)
                      ],
                    ),
                    const SizedBox(height: 20,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Icon(Icons.shuffle, size: 20,),
                        ButtonCircularSplash(
                            icon: Icon(Icons.skip_previous, size: 50,)
                        ),
                        ButtonCircularSplash(icon: Icon(Icons.pause, size: 50, color: Colors.white,)),
                        ButtonCircularSplash(icon: Icon(Icons.skip_next, size: 50, color: Colors.white,)),
                        Icon(Icons.repeat_rounded, size: 20,)
                      ],
                    ),
                    const SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        FaIcon(FontAwesomeIcons.solidClock),
                        SizedBox(width: 40,),
                        Icon(Icons.lyrics_outlined),
                        SizedBox(width: 40,),
                        FaIcon(FontAwesomeIcons.share)
                      ],
                    )
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
