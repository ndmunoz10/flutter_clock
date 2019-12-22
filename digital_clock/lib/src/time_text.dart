import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:digital_clock/src/vos/time_segment_model.dart';
import 'package:flutter/cupertino.dart';
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
              isHour ? timeModel.hour : timeModel.minute,
              style: GoogleFonts.anton(
                  fontSize: 250,
                  fontWeight: FontWeight.bold
              )
          );
        }
    );
  }
}