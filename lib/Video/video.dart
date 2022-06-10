import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:islam_app/constants/constants.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:islam_app/dashboard/dashboard.dart';

import 'package:islam_app/zakat/zakat_silver.dart';
import 'package:location_permissions/location_permissions.dart';
import 'package:auto_size_text/auto_size_text.dart';

class Video extends StatefulWidget {
  String videoTitle;
  Video(String videoTitle){
    this.videoTitle=videoTitle;
  }
  @override
  _VideoState createState() => _VideoState();
}

class _VideoState extends State<Video> {
  double _value = 0.0;

  @override
  Widget build(BuildContext context) {
    YoutubePlayerController _controller = YoutubePlayerController(
      initialVideoId: 'l-M8yjw46g8',
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
        enableCaption: true,
        controlsVisibleAtStart: true,
      ),
    );
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: HexColor("#363838"),
        padding:
            EdgeInsets.only(top: 50.0,),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                   padding:  EdgeInsets.only(left: 12.0, right: 12.0),
                    //height: 120.0,
                    //   color: Colors.red,
                    alignment: Alignment.center,
                    child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          //  color: Colors.white70,
                        ),
                        child: Image.asset(
                          Constants.transparent_back,
                          height: 30.0,
                          color: Colors.white,
                        )),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width-80,
                    child: Center(
                        child: Text(
                          widget.videoTitle,
                  style: GoogleFonts.roboto(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500,
                      decoration: TextDecoration.none,
                    ),
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                ))),
                /*SizedBox(
                  width: 50.0,
                )*/
              ],
            ),
            Container(
              height: MediaQuery.of(context).size.height-200,
              child: Center(
                child: YoutubePlayer(
                  controller: _controller,
                  showVideoProgressIndicator: true,
                  progressIndicatorColor: Colors.amber,
                  onReady: () {
                    print("player ready..");
                  },
                ),
              ),
            ),
           /* Container(
              alignment: Alignment.bottomRight,
                child: Slider(
                    value: _value.toDouble(),
                    min: 0.0,
                    max: 16.5,

                    activeColor: HexColor("#f7070f"),
                    inactiveColor: Colors.white30,
                    onChanged: (double newValue) {
                      setState(() {
                        _value = newValue;
                      });
                    },
                    semanticFormatterCallback: (double newValue) {
                      return '${newValue.round()}';
                    }
                )
            ),*/
          ],
        ),
      ),
    );
  }
}
