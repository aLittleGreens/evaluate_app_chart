import 'dart:ui';

import 'package:evaluate_app_chart/bean/QuestionRankBean.dart';
import 'package:evaluate_app_chart/bean/StarRankBean.dart';
import 'package:evaluate_app_chart/bean/VersionBean.dart';

import '../../../bean/EvaluteBean.dart';
import '../../../bean/questionType.dart';
import '../../../data/ListSingleton.dart';
import '../../../resources/app_colors.dart';

List<StarRankBean> getSelectStar(List<Evalutebean> data) {
  var totalCount = data.length;
  var star1 = 0;
  var star2 = 0;
  var star3 = 0;
  var star4 = 0;
  var star5 = 0;
  for (var item in data) {
    switch (item.rating) {
      case "1":
        star1++;
        break;
      case "2":
        star2++;
        break;
      case "3":
        star3++;
        break;
      case "4":
        star4++;
        break;
      case "5":
        star5++;
        break;
    }
  }
  var starBean1 =
      StarRankBean("1 star", 100 * star1 ~/ totalCount, star1, colorRanking[0]);
  var starBean2 =
      StarRankBean("2 star", 100 * star2 ~/ totalCount, star2, colorRanking[1]);
  var starBean3 =
      StarRankBean("3 star", 100 * star3 ~/ totalCount, star3, colorRanking[2]);
  var starBean4 =
      StarRankBean("4 star", 100 * star4 ~/ totalCount, star4, colorRanking[3]);
  var starBean5 =
      StarRankBean("5 star", 100 * star5 ~/ totalCount, star5, colorRanking[4]);

  List<StarRankBean> starBeanList = [
    starBean1,
    starBean2,
    starBean3,
    starBean4,
    starBean5
  ];

  return starBeanList;
}

String getAverageRating(List<Evalutebean> data) {
  var totalCount = data.length;
  var totalRating = 0;

  for (var item in data) {
    totalRating += int.tryParse(item.rating)!;
  }
  return (totalRating / totalCount).toStringAsFixed(1);
}

List<QuestionRankBean> getSelectQuestionNoun(List<Evalutebean> data) {
  var totalCount = data.length;
  var listQuestionCountMap = {};
  for (var item in data) {
    var ty_question_type = item.ty_question_type;
    if (listQuestionCountMap.containsKey(ty_question_type)) {
      listQuestionCountMap[ty_question_type] =
          listQuestionCountMap[ty_question_type] + 1;
    } else {
      listQuestionCountMap[ty_question_type] = 1;
    }
  }
  List<QuestionRankBean> questionBeanList = [];
  for (var entry in listQuestionCountMap.entries) {
    var questionBean = QuestionRankBean(
        entry.key,
        typeString(entry.key),
        entry.value,
        100 * entry.value ~/ totalCount,
        AppColors.contentColorGreen);
    questionBeanList.add(questionBean);
  }
  questionBeanList.sort((a, b) => b.count.compareTo(a.count));

  for (var i = 0; i < questionBeanList.length; i++) {
    questionBeanList[i].color = colorRanking[i];
  }

  return questionBeanList;
}

// 版本->问题数量
List<VersionBean> getSelectVersionQuestionNoun(List<Evalutebean> data) {
  var listVersionMap = {};
  for (var item in data) {
    var version = item.version;

    if (listVersionMap.containsKey(version)) {
      listVersionMap[version] = (listVersionMap[version]! + 1);
    } else {
      listVersionMap[version] = 1;
    }
  }
  List<VersionBean> questionBeanList = [];
  for (var entry in listVersionMap.entries) {
    print("version:${entry.key} count:${entry.value}");
    var questionBean = VersionBean(
      entry.key,
      versionToCode(entry.key),
      entry.value,
    );
    questionBeanList.add(questionBean);
  }
  questionBeanList.sort((a, b) => a.versionCode.compareTo(b.versionCode));
  if (questionBeanList.isEmpty) {
    questionBeanList.add(VersionBean("1.0.6", 6, 0));
  }
  return questionBeanList;
}
