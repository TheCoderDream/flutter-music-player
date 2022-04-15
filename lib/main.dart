import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MusicPlayer() ,
    )
  );
}

class MusicPlayer extends StatefulWidget {
  const MusicPlayer({Key? key}) : super(key: key);

  @override
  State<MusicPlayer> createState() => _MusicPlayerState();
}

class _MusicPlayerState extends State<MusicPlayer> {
  bool playing = false;

  IconData get playOrPauseIcon {
    return playing ? Icons.play_arrow : Icons.pause;
  }

  late AudioPlayer _player;
  late AudioCache _cache;

  Duration position = const Duration();
  Duration musicLength = const Duration();

  Widget slider() {
    return Slider(
      value: position.inSeconds.toDouble(),
      max: musicLength.inSeconds.toDouble(),
      onChanged: (value) {
        seekToSec(value.toInt());
      },
      activeColor: Colors.blue[800],
      inactiveColor: Colors.grey[350],
    );
  }

  void seekToSec(int sec) {
    _player.seek(Duration(seconds: sec));
  }

  @override
  void initState() {
    super.initState();
    _player = AudioPlayer();
    _cache = AudioCache(fixedPlayer: _player);

    // _player.getDuration().then((value) => musicLength = Dura)

    _player.onDurationChanged.listen((d) => {
      setState(() {
        musicLength = d;
      })
    });

    _player.onAudioPositionChanged.listen((d) => {
      setState(() {
        position = d;
      })
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration:  BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomCenter,
            colors: [
              Colors.blue[800] as Color,
              Colors.blue[200] as Color
            ]
          )
        ),
        child:  Padding(
          padding: const EdgeInsets.only(top: 48),
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children:  [
                const Padding(
                  padding: EdgeInsets.only(left: 12),
                  child: Text(
                    'Music Beats',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 38.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 12),
                  child: Text(
                    'Listen to your favorite Music',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                Center(
                  child: Container(
                    width: 280,
                    height: 280,
                    child: Image.asset('asset/images/img.png'),
                  ),
                ),
                const SizedBox(
                  height: 18.0,
                ),
                const Center(
                  child: Text(
                    'Eric Prydz - Opus',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 32.0,
                        fontWeight: FontWeight.w600
                    ),
                  ),
                ),
                const SizedBox(height: 30,),
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30)
                      )
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Text(
                                '${position.inMinutes}:${position.inSeconds.remainder(60)}',
                                style: const TextStyle(
                                    fontSize: 18.0
                                ),
                              ),
                              const SizedBox(width: 12,),
                              Expanded(child: slider()),
                              const SizedBox(width: 12,),
                              Text(
                                '${musicLength.inMinutes}:${musicLength.inSeconds.remainder(60)}',
                                style: const TextStyle(
                                    fontSize: 18.0
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 18,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.skip_previous),
                                onPressed: () {},
                                iconSize: 45,
                                color: Colors.blue,
                              ),
                              IconButton(
                                icon: Icon(playOrPauseIcon),
                                onPressed: () {
                                  if (!playing)  {
                                    _cache.play('opus.mp3');
                                    playing = true;
                                  } else {
                                    _player.stop();
                                    playing = false;
                                  }
                                },
                                iconSize: 45,
                                color: Colors.blue,
                              ),
                              IconButton(
                                icon: const Icon(Icons.skip_next),
                                onPressed: () {},
                                iconSize: 45,
                                color: Colors.blue,
                              )
                            ],
                          )
                        ],
                      )
                    )
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
