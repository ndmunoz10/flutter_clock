import 'package:digital_clock/src/vos/time_segment_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class TimeText extends StatelessWidget {

  final String timeText;
  final double fontSize;
  final FontWeight fontWeight;
  final TextAlign textAlign;

  TimeText({
    @required this.timeText,
    @required this.fontSize,
    @required this.fontWeight,
    this.textAlign = TextAlign.center
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<TimeModel>(
        builder: (context, timeModel, child) {
          return Text(
              timeText,
              textAlign: textAlign,
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  color: Colors.white
                ),
                  fontSize: fontSize,
                  fontWeight: fontWeight
              )
          );
        }
    );
  }
}