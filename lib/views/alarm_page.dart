import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:islam_app/alarm_helper.dart';
import 'package:islam_app/constants/theme_data.dart';
import 'package:islam_app/models/alarm_info.dart';

import '../main.dart';

class AlarmPage extends StatefulWidget {
  final DateTime namazTime;
  final String namazName;

  AlarmPage({
    this.namazTime,
    this.namazName
});
  @override
  _AlarmPageState createState() => _AlarmPageState();
}

class _AlarmPageState extends State<AlarmPage> {
  DateTime _alarmTime;
  String _alarmTimeString;
  AlarmHelper _alarmHelper = AlarmHelper();
  Future<List<AlarmInfo>> _alarms;
  List<AlarmInfo> _currentAlarms;

  @override
  void initState() {
    _alarmTime = widget.namazTime;
    _alarmHelper.initializeDatabase().then((value) {
      print('------database intialized');
      loadAlarms();
    });
    super.initState();
  }

  void loadAlarms() {
    _alarms = _alarmHelper.getAlarms();
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 32, vertical: 64),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                 'Set Alarm for ' + widget.namazName,
                style: TextStyle(
                    fontFamily: 'avenir',
                    fontWeight: FontWeight.w700,
                    color: CustomColors.primaryTextColor,
                    fontSize: 24),
              ),
              SizedBox(height: 10),
              DottedBorder(
                strokeWidth: 2,
                color: CustomColors.clockOutline,
                borderType: BorderType.RRect,
                radius: Radius.circular(24),
                dashPattern: [5, 4],
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: CustomColors.clockBG,
                    borderRadius:
                    BorderRadius.all(Radius.circular(24)),
                  ),
                  child: FlatButton(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 16),
                    onPressed: () {
                      _alarmTimeString =
                          DateFormat('HH:mm').format(widget.namazTime);
                      showModalBottomSheet(
                        useRootNavigator: true,
                        context: context,
                        clipBehavior: Clip.antiAlias,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(24),
                          ),
                        ),
                        builder: (context) {
                          return StatefulBuilder(
                            builder: (context, setModalState) {
                              return Container(
                                padding: const EdgeInsets.all(32),
                                child: Column(
                                  children: [
                                    FlatButton(
                                      onPressed: () async {
                                        var selectedTime =
                                        await showTimePicker(
                                          context: context,
                                          initialTime:
                                          TimeOfDay.fromDateTime(widget.namazTime),
                                        );
                                        if (selectedTime != null) {
                                          final now = widget.namazTime;
                                          var selectedDateTime =
                                          DateTime(
                                              now.year,
                                              now.month,
                                              now.day,
                                              selectedTime.hour,
                                              selectedTime
                                                  .minute);
                                          _alarmTime =
                                              selectedDateTime;
                                          setModalState(() {
                                            _alarmTimeString =
                                                DateFormat('HH:mm')
                                                    .format(
                                                    selectedDateTime);
                                          });
                                        }
                                      },
                                      child: Text(
                                        _alarmTimeString,
                                        style:
                                        TextStyle(fontSize: 32),
                                      ),
                                    ),
                                    ListTile(
                                      title: Text('Repeat'),
                                      trailing: Icon(
                                          Icons.arrow_forward_ios),
                                    ),
                                    ListTile(
                                      title: Text('Sound'),
                                      trailing: Icon(
                                          Icons.arrow_forward_ios),
                                    ),
                                    ListTile(
                                      title: Text('Title'),
                                      trailing: Icon(
                                          Icons.arrow_forward_ios),
                                    ),
                                    FloatingActionButton.extended(
                                      onPressed: onSaveAlarm,
                                      icon: Icon(Icons.alarm),
                                      label: Text('Save'),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                      );
                      // scheduleAlarm();
                    },
                    child: Column(
                      children: <Widget>[
                        Image.asset(
                          'assets/images/add_alarm.png',
                          scale: 1.5,
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Add Alarm',
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'avenir'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child:
                FutureBuilder<List<AlarmInfo>>(
                  future: _alarms,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      _currentAlarms = snapshot.data;
                      return ListView(
                        children: snapshot.data.map<Widget>((alarm) {
                          var alarmTime =
                              DateFormat('hh:mm aa').format(alarm.alarmDateTime);
                          var gradientColor = GradientTemplate
                          .gradientTemplate[alarm.gradientColorIndex].colors;
                          return Container(
                            margin: const EdgeInsets.only(bottom: 32),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: gradientColor,
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: gradientColor.last.withOpacity(0.4),
                                  blurRadius: 8,
                                  spreadRadius: 2,
                                  offset: Offset(4, 4),
                                ),
                              ],
                              borderRadius: BorderRadius.all(Radius.circular(24)),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Icon(
                                          Icons.label,
                                          color: Colors.white,
                                          size: 24,
                                        ),
                                        SizedBox(width: 8),
                                        Text(
                                          alarm.title,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: 'avenir'),
                                        ),
                                      ],
                                    ),
                                    Switch(
                                      onChanged: (bool value) {},
                                      value: true,
                                      activeColor: Colors.white,
                                    ),
                                  ],
                                ),
                                Text(
                                  'Mon-Fri',
                                  style: TextStyle(
                                      color: Colors.white, fontFamily: 'avenir'),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      alarmTime,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'avenir',
                                          fontSize: 24,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    IconButton(
                                        icon: Icon(Icons.delete),
                                        color: Colors.white,
                                        onPressed: () {
                                          deleteAlarm(alarm.id);
                                        }),
                                  ],
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      );
                    }
                    return Center(
                      child: Text(
                        'Loading..',
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void scheduleAlarm(
      DateTime scheduledNotificationDateTime, AlarmInfo alarmInfo) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'alarm_notif',
      'alarm_notif',
      'Channel for Alarm notification',
      icon: 'codex_logo',
      sound: RawResourceAndroidNotificationSound('a_long_cold_sting'),
      largeIcon: DrawableResourceAndroidBitmap('codex_logo'),
    );

    var iOSPlatformChannelSpecifics = IOSNotificationDetails(
        sound: 'a_long_cold_sting.wav',
        presentAlert: true,
        presentBadge: true,
        presentSound: true);
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.schedule(0, 'Prayer Time', alarmInfo.title,
        scheduledNotificationDateTime, platformChannelSpecifics);
  }

  void onSaveAlarm() {
    DateTime scheduleAlarmDateTime;
    if (_alarmTime.isAfter(DateTime.now()))
      scheduleAlarmDateTime = _alarmTime;
    else
      scheduleAlarmDateTime = _alarmTime.add(Duration(days: 1));

    var alarmInfo = AlarmInfo(
      alarmDateTime: scheduleAlarmDateTime,
      gradientColorIndex: _currentAlarms.length,
      title: widget.namazName,
    );
    _alarmHelper.insertAlarm(alarmInfo);
    scheduleAlarm(scheduleAlarmDateTime, alarmInfo);
    Navigator.pop(context);
    loadAlarms();
  }

  void deleteAlarm(int id) {
    _alarmHelper.delete(id);
    //unsubscribe for notification
    loadAlarms();
  }
  // getContainerColor(alarm) {
  //   if (widget.namazName =="Fajar"){
  //     return
  //       GradientTemplate.gradientTemplate[0].colors;
  //   }
  //   else if(widget.namazName == "Dhuhr"){
  //     return
  //       GradientTemplate.gradientTemplate[1].colors;
  //
  //   }else if(widget.namazName == "Asr"){
  //     return
  //       GradientTemplate.gradientTemplate[2].colors;
  //
  //   }else if(widget.namazName == "Maghrib"){
  //     return
  //       GradientTemplate.gradientTemplate[3].colors;
  //
  //   }else if(widget.namazName == "Isha"){
  //     return
  //       GradientTemplate.gradientTemplate[4].colors;
  //
  //   }
  //
  // }


}
