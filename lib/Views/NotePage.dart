import 'package:flutter/material.dart';
class notePAge extends StatelessWidget {
  final String? title,subtitle;
  const notePAge({
    super.key,
    this.subtitle,
    this.title
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("$title"),
        backgroundColor: Colors.greenAccent,

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.all(Radius.circular(20)),
        ),
      ),

      body: Center(
        child: Padding(
          padding: EdgeInsetsGeometry.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            spacing: 5,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(6),
                ),
                child:  Text(
                  "$subtitle",
                  style: TextStyle(fontSize: 16),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
