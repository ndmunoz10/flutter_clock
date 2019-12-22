import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class WaveWidgetConfiguration extends StatelessWidget {

  final double width;
  final double height;
  final List<double> heightPercentages;
  final List<List<Color>> gradients;

  WaveWidgetConfiguration({
    @required this.width,
    @required this.height,
    @required this.heightPercentages,
    @required this.gradients
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
      child: WaveWidget(
        config: CustomConfig(
            gradients: gradients,
            durations: [35000, 19440, 10800, 6000],
            heightPercentages: heightPercentages,
            blur: MaskFilter.blur(BlurStyle.solid, 10),
            gradientBegin: Alignment.bottomLeft,
            gradientEnd: Alignment.topRight
        ),
        duration: 6000,
        waveAmplitude: 12,
        size: Size(
          width,
          height,
        ),
      ),
    );
  }
}