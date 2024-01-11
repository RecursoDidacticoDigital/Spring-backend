import 'package:flutter/material.dart';

class ClassroomItem extends StatefulWidget {
  const ClassroomItem({
    super.key,
    required this.label,
    this.icon = Icons.school, 
    required this.onPressed, 
    this.available,
  });

  final String label;
  final IconData icon;
  final Function onPressed;
  final bool? available;

  @override
  State<ClassroomItem> createState() => _ClassroomItemState();
}

class _ClassroomItemState extends State<ClassroomItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
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
            Icon(
              widget.icon,
              color: widget.available ?? false // Check if 'available' is not null and true
                  ? Colors.green.shade700
                  : Colors.red.shade900,
            ),
          ],
        ),
      ),
    );
  }
}
