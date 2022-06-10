import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:islam_app/constants/constants.dart';
import 'package:islam_app/prayernew.dart';

class ViewAllScreen extends StatefulWidget {
  @override
  _ViewAllScreenState createState() => _ViewAllScreenState();
}

class _ViewAllScreenState extends State<ViewAllScreen> {
  var scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController questionController = new TextEditingController();
  void initState() {
    // TODO: implement initState
    super.initState();
    //  startTime();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          key: scaffoldKey,
          drawer: Drawer(),
          body: Stack(
            children: [
              Container(
                //  color: Colors.green,
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Image.asset(
                  Constants.dome_bg,
                  fit: BoxFit.fill,
                ),
              ),
              SizedBox.expand(
                child: Container(
                  //color: Colors.green,
                  margin: EdgeInsets.only(
                      top: 16.0, left: 16.0, right: 16.0, bottom: 16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [

                      Row(
                        children: [
                          Container(
                              height: 22.0,
                              //   color: Colors.red,
                              alignment: Alignment.center,
                              child: GestureDetector(
                                  onTap: (){
                                    Navigator.pop(context);
                                  },
                                  child: Image.asset(Constants.backoutline))),
                          Expanded(
                            child: Text(
                              "Q & A",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  decoration: TextDecoration.none,
                                  fontFamily: "Arial",
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.0),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(builder: (context) => Dashboard()),
                              // );
                            },
                            child: Container(
                                height: 22.0,
                                //   color: Colors.red,
                                alignment: Alignment.center,
                                child: Image.asset(Constants.share)),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => PrayerNewScreen()));
                        },
                        child: Container(
                          margin: EdgeInsets.only(top: 6, bottom: 50.0),
                          child: Column(
                            children: <Widget>[
                              Container(
                                //  color: Colors.white,
                                  margin: EdgeInsets.only(
                                      top: MediaQuery.of(context).size.height / 12),
                                  child: Center(
                                      child: Text(
                                        "(Now)",
                                        style: TextStyle(
                                          color: HexColor("#eb9c34"),
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14.0,
                                        ),
                                      ))),
                              Container(
                                  child: Center(
                                      child: Text(
                                        "Pray Maghrib",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 13.0,
                                        ),
                                      ))),

                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 7,
                        child: Column(
                          children: [

                            Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                      margin: EdgeInsets.only(top: 20.0, bottom: 20.0),
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "My Questions & Answers",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 17.0,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: "Arial"),
                                      )),
                                  Container(
                                      margin: EdgeInsets.only(top: 20.0, bottom: 20.0),
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "View All",
                                        style: TextStyle(
                                            color: HexColor("#eb9c34"),
                                            fontSize: 17.0,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: "Arial"),
                                      )),
                                ],
                              ),
                            ),
                           Expanded(child: StreamBuilder(

                             stream: FirebaseFirestore.instance.collection("questions").snapshots(),
                             builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {

                             if(snapshot.hasData){

                               List<QueryDocumentSnapshot> data = snapshot.data.docs;

                                 return ListView.builder(
                                   itemCount: data.length,
                                   itemBuilder: (BuildContext context, int index) {

                                   return Container(
                                     margin: EdgeInsets.all(5),
                                     decoration: BoxDecoration(
                                         color: HexColor('#0A4541'),
                                         borderRadius:
                                         BorderRadius.all(Radius.circular(15.0))),
                                     child:
                                     Row(
                                       crossAxisAlignment: CrossAxisAlignment.start,
                                       mainAxisSize: MainAxisSize.max,
                                       children: <Widget>[
                                         SizedBox(width: 10),
                                         Padding(
                                           padding: const EdgeInsets.only(top:8.0),
                                           child: Image.asset(
                                             Constants.girl,
                                           ),
                                         ),
                                         SizedBox(width: 10,),
                                         Expanded(
                                           child: Column(
                                             mainAxisAlignment: MainAxisAlignment.start,
                                             crossAxisAlignment: CrossAxisAlignment.start,
                                             children: <Widget>[
                                               Padding(
                                                 padding: const EdgeInsets.only(
                                                     top: 8.0, bottom: 5.0),
                                                 child: Text(
                                                   'Sandal',
                                                   style:
                                                   TextStyle(color: HexColor("#eb9c34")),
                                                 ),
                                               ),
                                               Container(
                                                 child: Padding(
                                                   padding: const EdgeInsets.only(bottom: 8.0),
                                                   child: Text(
                                                     data.elementAt(index).data()['question'],
                                                     style: TextStyle(color: Colors.white),
                                                   ),
                                                 ),
                                               ),
                                               Row(
                                                 mainAxisSize: MainAxisSize.max,
                                                 children: <Widget>[

                                                   Text('Reply',
                                                     style: TextStyle(
                                                         fontSize: 10,
                                                         color: HexColor("#eb9c34")
                                                     ),),
                                                   Spacer(),
                                                   Spacer(),
                                                   Spacer(),
                                                   Padding(
                                                     padding: const EdgeInsets.only(right:8.0),
                                                     child: Text( DateFormat('dd-MM-yyyy – kk:mm').format(DateTime.now()),
                                                       style: TextStyle(
                                                           fontSize: 10,
                                                           color: Colors.white,
                                                           letterSpacing: 1.5
                                                       ),),
                                                   ),


                                                 ],
                                               ),
                                               SizedBox(
                                                 height: 10,
                                               ),


                                             ],
                                           ),

                                         ),

                                         SizedBox(width: 5),
                                       ],
                                     ),
                                   );


                                 },)
                                   ;






                             }else{
                               return Container();
                             }



                           },),

                           )
                           /* Expanded(
                              child: ListView(
                                children: [
                                  ContainerView(),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  ContainerView(),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  ContainerView(),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  ContainerView(),
                                  SizedBox(
                                    height: 50,
                                  ),
                                ],
                              ),
                            ),*/

                          ],
                        ),
                      )

                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,

                      borderRadius: BorderRadius.all(Radius.circular(10.0))
                  ),
                  margin: EdgeInsets.only(left:20.0,right: 20.0,bottom: 10.0),
                  height: 50,
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          style: TextStyle(
                              color: Colors.black, fontSize: 16.0),
                          cursorColor: HexColor("#eb9c34"),
                          showCursor: true,
                          controller: questionController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            fillColor: Colors.white,
                            filled: true,
                            hintText: "Type Your Questions Here..",
                            hintStyle: TextStyle(color: Colors.black54),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(12.0)),
                              borderSide:
                              BorderSide(color: Colors.white),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(12.0)),
                              borderSide:
                              BorderSide(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                          onTap: (){
                            if(questionController.text.isNotEmpty){
                              FirebaseFirestore.instance.collection('questions').add({'question':questionController.text}).then((value) => {
                                questionController.clear()

                              });
                            }
                          },
                          child: Container(child: Image.asset(Constants.send))),
                      SizedBox(width: 5,)

                    ],
                  ),

                ),

              )
            ],
          ),
        ),
      ),
    );
  }
}
class ContainerView extends StatefulWidget {
  @override
  _ContainerViewState createState() => _ContainerViewState();
}

class _ContainerViewState extends State<ContainerView> {
  @override
  Widget build(BuildContext context) {
    return
      Container(
        decoration: BoxDecoration(
            color: HexColor('#0A4541'),
            borderRadius:
            BorderRadius.all(Radius.circular(15.0))),
        child:
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            SizedBox(width: 10),
            Padding(
              padding: const EdgeInsets.only(top:8.0),
              child: Image.asset(
                Constants.girl,
              ),
            ),
            SizedBox(width: 10,),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 8.0, bottom: 5.0),
                    child: Text(
                      'Sandal',
                      style:
                      TextStyle(color: HexColor("#eb9c34")),
                    ),
                  ),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        Constants.descnew,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Text('Like',
                        style: TextStyle(
                            fontSize: 10,
                            color: HexColor("#eb9c34")
                        ),),
                      Spacer(),
                      Text('Dislike',
                        style: TextStyle(
                            fontSize: 10,
                            color: Colors.white
                        ),),
                      Spacer(),
                      Text('Reply',
                        style: TextStyle(
                            fontSize: 10,
                            color: HexColor("#eb9c34")
                        ),),
                      Spacer(),
                      Spacer(),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(right:8.0),
                        child: Text('13-Jan-2021',
                          style: TextStyle(
                              fontSize: 10,
                              color: Colors.white,
                              letterSpacing: 1.5
                          ),),
                      ),


                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Image.asset(
                        Constants.john,

                      ),
                      SizedBox(width: 10,),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 8.0, bottom: 5.0),
                              child: Text(
                                'John Doe',
                                style:
                                TextStyle(color: HexColor("#eb9c34")),
                              ),
                            ),
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Text(
                                  Constants.descnew,
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),

                      ),

                      SizedBox(width: 5),
                    ],
                  ),


                ],
              ),

            ),

            SizedBox(width: 5),
          ],
        ),
      );
  }
}
