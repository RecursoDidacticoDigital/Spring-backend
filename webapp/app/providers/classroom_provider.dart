// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/http/subjects_response.dart';
class ClassroomProvider extends ChangeNotifier{
  List<TimeOfDay> startTimeblockIds = const [
    TimeOfDay(hour: 7, minute: 0),  //1
    TimeOfDay(hour: 8, minute: 30), //2
    TimeOfDay(hour: 10, minute: 30),//3
    TimeOfDay(hour: 12, minute: 0), //4
    TimeOfDay(hour: 13, minute: 30),//5
    TimeOfDay(hour: 15, minute: 0), //6
    TimeOfDay(hour: 16, minute: 30),//7
    TimeOfDay(hour: 18, minute: 30),//8
    TimeOfDay(hour: 20, minute: 0), //9
  ];

  List<TimeOfDay> endTimeblockIds = const [
    TimeOfDay(hour: 8, minute: 30), //1
    TimeOfDay(hour: 10, minute: 0), //2
    TimeOfDay(hour: 12, minute: 0), //3
    TimeOfDay(hour: 13, minute: 30),//4
    TimeOfDay(hour: 15, minute: 0), //5
    TimeOfDay(hour: 16, minute: 30),//6
    TimeOfDay(hour: 18, minute: 0), //7
    TimeOfDay(hour: 20, minute: 0), //8
    TimeOfDay(hour: 21, minute: 30),//9
  ];
// Checks if the classroom is available () or not ()
  Future<bool> classroomOccupied(List<Subject> materias) async {
    DateTime now = DateTime.now();
    int weekDay = getCurrentWeekdayNumber();
    TimeOfDay currentTime = TimeOfDay(hour: now.hour, minute: now.minute);

    for(Subject materia in materias){
      int dayId, timeBlockId;
      switch(weekDay){
        case 1: 
          dayId = materia.dayid1;
          timeBlockId = materia.timeblockid1;
          break;
        case 2:  
          dayId = materia.dayid2;
          timeBlockId = materia.timeblockid2;
          break;
        case 3:  
          dayId = materia.dayid3;
          timeBlockId = materia.timeblockid3;
          break;
        case 4:  
          dayId = materia.dayid4;
          timeBlockId = materia.timeblockid4;
          break;
        case 5:  
          dayId = materia.dayid5;
          timeBlockId = materia.timeblockid5;
          break;
        default: continue;
      }
      if(isOccupied(dayId, timeBlockId, now, currentTime)){
        print("DAY: $dayId, TIMEBLOCK: $timeBlockId, currentTime: $currentTime");
        notifyListeners();
        return true;
      }
    }
    notifyListeners();
    return false;
  }

  bool isOccupied(int dayId, int timeblockId, now, currentTime){
    if(timeblockId <= 0 || timeblockId > startTimeblockIds.length){
      return false;
    }

    if(DateFormat('E').format(now) != ['Mon', 'Tue', 'Wed', 'Thu', 'Fri'][dayId - 1]){
      return false;
    }

    TimeOfDay startTime = startTimeblockIds[timeblockId - 1];
    TimeOfDay endTime = endTimeblockIds[timeblockId - 1];
    //(timeblockId < startTimeblockIds.length) ? startTimeblockIds[timeblockId] : const TimeOfDay(hour: 21, minute: 30);

    return currentTime.hour >= startTime.hour &&
            (currentTime.hour < endTime.hour ||
            (currentTime.hour == endTime.hour && currentTime.minute < endTime.minute));
  }

  int getCurrentWeekdayNumber() {
  DateTime now = DateTime.now();
  String formattedDay = DateFormat('E', 'en_US').format(now);

  Map<String, int> dayToNumber = {
    'Mon': 1,
    'Tue': 2,
    'Wed': 3,
    'Thu': 4,
    'Fri': 5,
    // Add mappings for 'Sat' and 'Sun' if needed
    'lun': 1,
    'mar': 2,
    'mié': 3,
    'jue': 4,
    'vie': 5,
  };

  return dayToNumber[formattedDay] ?? 0; // Returns 0 if it's not a weekday
  }
}