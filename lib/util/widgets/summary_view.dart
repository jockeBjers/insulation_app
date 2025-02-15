import 'package:flutter/material.dart';

class SummaryView extends StatelessWidget {
  const SummaryView({
    super.key,
    required this.total30,
    required this.total50,
    required this.total80,
  });

  final double total30;
  final double total50;
  final double total80;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(155, 158, 158, 158).withValues(),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Total 30mm: ${total30.ceil()} m²",
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(height: 10),
          Text(
            "Total 50mm: ${total50.ceil()} m²",
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(height: 10),
          Text(
            "Total 80mm: ${total80.ceil()} m²",
            style: TextStyle(fontSize: 20),
          ),
        ],
      ),
    );
  }
}
