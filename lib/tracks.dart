import 'package:flutter/material.dart';
import 'body.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';

List<SongInfo> songs;
bool gotpath = false;
String url;

class Tracks extends StatefulWidget {
  @override
  _TracksState createState() => _TracksState();
}

class _TracksState extends State<Tracks> {
  FlutterAudioQuery audioQuery = FlutterAudioQuery();
  AssetsAudioPlayer assetsAudioPlayer = AssetsAudioPlayer();

  @override
  void initState() {
    super.initState();
    initaudio().whenComplete(() {
      setState(() {
        gotpath = true;
      });
    });
  }

  AlbumInfo album;
  List art;
  Future<void> initaudio() async {
    // getting all songs available on device storage
    songs = await audioQuery.getSongs();
    // getting all albumart available on device storage
    //art = await audioQuery.getArtwork(type: ResourceType.ALBUM, id: album.id);
  }

  @override
  Widget build(BuildContext context) {
    if (gotpath == true) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Tracks'),
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: <Color>[
                  Colors.teal[600],
                  Colors.teal[500],
                  Colors.teal[300]
                ])),
          ),
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: ListView.builder(
              itemCount: songs.length,
              itemBuilder: (context, int index) {
                return ListTile(
                  leading: Icon(Icons.account_balance),
                  title: Text(songs[index].displayName),
                  onTap: () {

                    url = null;
                    setState(() {
                      url = songs[index].uri;
                    });
                    playAudio(url);
                    setState(() {
                      return isPlaying = true;
                    });
                    Navigator.pop(context,isPlaying);
                  },
                );
              }),
        ),
      );
    } else {
      return Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Image.asset('images/2.gif'),
        ),
      );
    }
  }
}
