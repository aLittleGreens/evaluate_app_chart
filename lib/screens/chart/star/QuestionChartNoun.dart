import 'package:evaluate_app_chart/bean/QuestionRankBean.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../bean/EvaluteBean.dart';
import '../../../bean/StarRankBean.dart';
import '../../../resources/app_colors.dart';
import '../../../widgets/indicator.dart';
import '../utils/EvaluteUtils.dart';

class QuestionChartNoun extends StatefulWidget {
  List<Evalutebean> data;
  bool min = false;

  QuestionChartNoun(this.data, {super.key, required this.min});

  @override
  State<StatefulWidget> createState() => _QuestionChartNounState();
}

class _QuestionChartNounState extends State<QuestionChartNoun> {
  int touchedIndex = -1;
  List<QuestionRankBean>? starList;

  @override
  Widget build(BuildContext context) {
    starList = getSelectQuestionNoun(widget.data);
    return AspectRatio(
      aspectRatio: 1,
      child: starList == null
          ? const CircularProgressIndicator()
          : Row(
              children: <Widget>[
                Expanded(
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: PieChart(
                      PieChartData(
                        pieTouchData: PieTouchData(
                          touchCallback:
                              (FlTouchEvent event, pieTouchResponse) {
                            setState(() {
                              if (!event.isInterestedForInteractions ||
                                  pieTouchResponse == null ||
                                  pieTouchResponse.touchedSection == null) {
                                touchedIndex = -1;
                                return;
                              }
                              touchedIndex = pieTouchResponse
                                  .touchedSection!.touchedSectionIndex;
                            });
                          },
                        ),
                        borderData: FlBorderData(
                          show: true,
                        ),
                        sectionsSpace: 2,
                        centerSpaceRadius: widget.min ? 20 : 50,
                        sections: showingSections(widget.min),
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  // List

  List<PieChartSectionData> showingSections(bool min) {
    double screenWidth = MediaQuery.of(context).size.width;
    return List.generate(starList!.length > 6 ? 6 : starList!.length, (i) {
      final fontSize = min ? 10.0 : 20.0;
      final radius = min ? 40.0 : screenWidth/6.5;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
      var starBean = starList![i];
      return PieChartSectionData(
        color: starBean.color,
        value: starBean.value.toDouble(),
        title: '${starBean.title}:\n${starBean.count}(${starBean.value}%)',
        radius: radius,
        titleStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: AppColors.mainTextColor1,
          shadows: shadows,
        ),
      );
    });
  }
}
