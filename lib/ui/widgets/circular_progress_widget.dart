import 'package:expert_system/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class CircularProgressWidget extends StatelessWidget {
  final String title;
  final double percent;
  const CircularProgressWidget({Key? key, required this.title, required this.percent}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircularPercentIndicator(
      // reverse: true,
      radius: 50,
      lineWidth: 7,
      animation: true,
      // animateFromLastPercent: true,
      percent: 0.7,
      center: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
          ),
          const SizedBox(
            height: 2,
          ),
          Text('$percent%',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  color: Colors.grey.shade500)),
        ],
      ),
      backgroundColor: darkBlue.withOpacity(0.3),
      linearGradient: const LinearGradient(colors: [
        Color.fromARGB(255, 224, 139, 27),
        Colors.pink,
      ]),
      circularStrokeCap: CircularStrokeCap.round,
    );
  }
}
