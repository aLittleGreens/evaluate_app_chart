// 读取 assets 文件夹中的 person.json 文件
import 'dart:convert';

import 'package:flutter/services.dart';

import '../bean/EvaluteBean.dart';
import 'ListSingleton.dart';

List<String> assetVersions = [
  'assets/comment/v1.0.7_comment.json',
  'assets/comment/v1.0.6_comment.json'
];

Future _loadPersonJson(String json) async {
  return await rootBundle.loadString(json);
}

Future decodeQuestion() async {
  String questionString = await _loadPersonJson('assets/question.json');
  List<dynamic> questionjsonData = json.decode(questionString);
  ListSingleton listSingleton = ListSingleton();
  for (var item in questionjsonData) {
    String questValue = item["value"];
    String questlabel = item["label"];
    // print('questValue: $questValue,questlabel:$questlabel');
    listSingleton.questionFilterItems.add(questValue);
    listSingleton.questionFilterMap[questValue] = questlabel;
  }
}

Future decodeAllComment() async {
  for (String assetPath in assetVersions) {
    await decodeComment(assetPath);
  }
  print("decodeAllComment Complete");
}

// 将 json 字符串解析为 Person 对象
Future decodeComment(String version) async {
// 获取本地的 json 字符串
  String jsonString = await _loadPersonJson(version);
  Map<String, dynamic> jsonDataMap = json.decode(jsonString);
  List<dynamic> jsonData = jsonDataMap['feed']['entry'];
  // List<dynamic> jsonData = json.decode(jsonString);
  ListSingleton listSingleton = ListSingleton();

  for (var item in jsonData) {
    String id = item['id']['label'];
    String author = item['author']['name']['label'];
    String updated = item['updated']['label'];
    String rating = item['im:rating']['label'].toString();
    String version = item['im:version']['label'];
    String os = item['os'] == null ? "IOS" : "Android";
    String title = item['title']['label'];
    String content = item['content']['label'];
    String cc = item['cc'] == null ? "unknow" : item['cc'];
    String title_translate = item['title_translate'];
    String content_translate = item['content_translate'];
    String ty_review_type = item['ty_review_type'];
    String ty_question_type = item['ty_question_type'];
    print('author: $author, rating: $rating,version:$version title:$title');
    var evalutebean = Evalutebean(
        id,
        author,
        updated,
        rating,
        version,
        os,
        title,
        content,
        cc,
        title_translate,
        content_translate,
        ty_review_type,
        ty_question_type);
    listSingleton.addItem(evalutebean);
  }
}
