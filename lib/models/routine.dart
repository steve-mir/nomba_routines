import 'dart:async';

import 'package:flutter/foundation.dart';

class Routine with ChangeNotifier {
  static const int SEC1 = 1000;
  static const int MIN1 = 60000;
  static const int HR1 = 3600000;
  static const int DAY1 = HR1 * 24;

  final int? id;
  String title;
  int frequency;
  String tag;
  String desc;
  var time;
  var nextTime;

  Routine(
      this.id, this.title, this.desc, this.tag, this.frequency, this.nextTime)
      : time = DateTime.now().millisecondsSinceEpoch {
    nextTime = (time + (SEC1 * 10));

    startTimer();
    print(DateTime.fromMillisecondsSinceEpoch(time + DAY1));
  }

  void increaseAge() {
    title = "Just change";
    notifyListeners();
  }

  /*bool resume() {
    (frequency > 0);
    notifyListeners();
  }*/

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    Timer _timer;
    int _start = 10;

    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (time == nextTime) {
          print("done");
          timer.cancel();
        } else {
          if (freq > 0 && time == nextTime - SEC1) {
            print("resset");
            time = nextTime;
            nextTime = (time + (SEC1 * 10));
            _start = 10;

            _start--;
            time += SEC1;
            print('Reset Start time is $time end is $nextTime');
          }
          _start--;
          time += SEC1;
          print('Start time is $time end is $nextTime');
        }
      },
    );

    //resume();
  }

  //Getters

  String get name => title;
  int get freq => frequency;
  String get _tag => tag;
  String get _dsc => desc;
  get _nextTime => nextTime;
  //String get _time => DateTime.fromMillisecondsSinceEpoch(time).toString();

  //Setters

  set _title(String _title) => title = _title;
  set freq(int freq) => frequency = freq;
  set _tag(String _tag) => tag = _tag;
  set _desc(String _desc) => desc = _desc;
  set _nextTime(var _nextTime) => nextTime = _nextTime;

  factory Routine.fromMap(Map<String, dynamic> json) => new Routine(
      json['id'],
      json['title'],
      json['desc'],
      json['tag'],
      json['frequency'],
      json['nextTime']);

  Map<String, dynamic> toMap() {
    return {'id': id, 'title': title, 'description': desc};
  }
}
