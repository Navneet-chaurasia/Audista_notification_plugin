import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:voiceover_notification_plugin/voiceover_notification_plugin.dart';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';


void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {

  AudioPlayer player;
  String status = 'hidden';
   String coverImage = '';

  @override
  void initState() {
player = AudioPlayer();
player.setUrl("https://firebasestorage.googleapis.com/v0/b/voiceover-30c4d.appspot.com/o/audioClips%2FPaoqqjlmxRYYaabog3OztaayIN431588930874732?alt=media&token=14d335a9-13f8-4552-b3e3-70218ac49677");
    setup();
    super.initState();

    MediaNotification.setListener('pause', () {
      player.pause();
      setState(() => status = 'pause');
    });

    MediaNotification.setListener('play', () {
      player.resume();
      setState(() => status = 'play');
    });

    MediaNotification.setListener('next', () {});

    MediaNotification.setListener('prev', () {});

    MediaNotification.setListener('select', () {});
  }

  void setup()async{
     final dir = await getExternalStorageDirectory();

          String desiredPath = dir.parent.parent.parent.parent.path;

          //create directory for clips if not exist
          new Directory(desiredPath + "/voiceover/media/clips")
              .create(recursive: true);
              //create directory for coverImage if not exist
               new Directory(desiredPath + "/voiceover/media/coverImages")
              .create(recursive: true);

          setState(() {
                coverImage = File(
              '$desiredPath/voiceover/media/coverImages/Qu21589197.jpg').path;
          });
          
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: const Text('Plugin example app'),
        ),
        body: coverImage == ''? Text("loading..."): new Center(
            child: Container(
          height: 250.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[

              Row(children: <Widget>[
                RaisedButton(
                  child:Text("play"),
                  onPressed: (){
player.play("https://firebasestorage.googleapis.com/v0/b/voiceover-30c4d.appspot.com/o/audioClips%2FPaoqqjlmxRYYaabog3OztaayIN431588930874732?alt=media&token=14d335a9-13f8-4552-b3e3-70218ac49677");
                }),
                RaisedButton(
                  child:Text("pause"),
                  onPressed: (){
                    player.pause();
                  },
                )
              ],),
              FlatButton(
                  child: Text('Show notification'),
                  onPressed: () {
                    MediaNotification.showNotification(
                        title: 'Title', author: 'Song author');
                      
                    setState(() => status = 'play');
                  }),
              FlatButton(
                  child: Text('Update notification'),
                  onPressed: () {
                    MediaNotification.showNotification(
                        title: 'New Title',
                        author: 'New Song author',
                        coverArt: coverImage,
                        isPlaying: false);
                    setState(() => status = 'pause');
                  }),
              FlatButton(
                  child: Text('Hide notification'),
                  onPressed: () {
                    MediaNotification.hideNotification();
                    setState(() => status = 'hidden');
                  }),
                  Container(child:Image.file(File(coverImage)),
                  
                  
                  ),
              Text('Status: ' + status)
            ],
          ),
        )),
      ),
    );
  }
}
