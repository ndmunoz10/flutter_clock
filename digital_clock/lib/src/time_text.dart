import 'package:digital_clock/src/vos/time_segment_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class TimeText extends StatelessWidget {

  final isHour;

  TimeText({@required this.isHour});

  @override
  Widget build(BuildContext context) {
    return Consumer<TimeModel>(
        builder: (context, timeModel, child) {
          return Text(
              isHour ? "${timeModel.hour}:" : timeModel.minute,
              style: GoogleFonts.openSans(
                textStyle: TextStyle(
                  color: Colors.white
                ),
                  fontSize: 170,
                  fontWeight: isHour ? FontWeight.bold : FontWeight.normal
              )
          );
        }
    );
  }
}