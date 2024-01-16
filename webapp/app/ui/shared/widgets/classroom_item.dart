// ignore_for_file: avoid_print
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../../../api/subjectsApi.dart';
import '../../../providers/classroom_provider.dart';

class ClassroomItem extends StatefulWidget {
  const ClassroomItem({
    super.key,
    required this.label,
    this.icon = Icons.school, 
    required this.onPressed, 
    required this.classroom,
  });

  final String label;
  final String classroom;
  final IconData icon;
  final Function onPressed;

  @override
  State<ClassroomItem> createState() => _ClassroomItemState();
}

class _ClassroomItemState extends State<ClassroomItem> {
  Timer? _timer;
  bool? _cachedAvailable;
  Future<bool>? _availabilityFuture;

  @override
  void initState() {
    super.initState();
    _availabilityFuture = _checkOccupancy();
  }

  Future<bool> _checkOccupancy() async{
    if(!mounted) return Future.value(false);

    try {
      final classroomProvider = Provider.of<ClassroomProvider>(context, listen: false);
      print("OCCUPANCY1");
      final subjectsApi = Provider.of<SubjectsApi>(context, listen: false);
      print("OCCUPANCY2");
      await subjectsApi.getSubjectByString(widget.classroom);
      print("OCCUPANCY3");
      bool isOccupied = await classroomProvider.classroomOccupied(subjectsApi.materias);
      print("OCCUPANCY4");
      if(!mounted) return Future.value(false);
      print("OCCUPANCY5");
      setState((){
        print("OCCUPANCY6");
        _cachedAvailable = isOccupied;
      });
      print("OCCUPANCY7");
      return isOccupied;
    } catch (e) {
      print("ERROR EN OCCUPANCY: $e");
      return Future.value(false);
    }
  }

  void _startOccupancyCheckTimer() {
    _timer = Timer.periodic(const Duration(seconds: 10), (Timer t) async {
      if (_cachedAvailable == null) {
        setState(() {
          _availabilityFuture = _checkOccupancy();
        });
      }
    });
  }

  void _stopOccupancyCheckTimer(){
    _timer?.cancel();
  }

  @override
  void dispose(){
    _stopOccupancyCheckTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final subjectsApi = Provider.of<SubjectsApi>(context);
    return VisibilityDetector(
      key: Key(widget.classroom),
      onVisibilityChanged: (VisibilityInfo info){
        if(info.visibleFraction > 0.0){
          _startOccupancyCheckTimer();
        } else {
          _stopOccupancyCheckTimer();
        }
      },
      child: InkWell(
        onTap: ()=> widget.onPressed(),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
            color: Color.fromARGB(0, 2, 101, 250),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(widget.label, style: const TextStyle(color: Colors.white)),
              FutureBuilder<bool>(
                future: _availabilityFuture,
                builder: (BuildContext context, AsyncSnapshot<bool> snapshot){
                  if(snapshot.connectionState == ConnectionState.waiting){
                    return const CircularProgressIndicator();
                  } else if(snapshot.hasError){
                    return Icon(Icons.error, color: Colors.red.shade900);
                  } else if(snapshot.hasData){
                    return Icon(
                      widget.icon,
                      color: snapshot.data ?? false // Check if 'available' is not null and true
                          ? Colors.red.shade900
                          : Colors.green.shade700
                    );
                  } else {
                    return const Icon(Icons.help_outline);
                  }
                }
              )
            ],
          ),
        ),
      )
    );
  }
}
