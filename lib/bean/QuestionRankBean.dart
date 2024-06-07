import 'dart:ui';

class QuestionRankBean {
  String type;
  String title;//title 文案
  int count;//数量
  int value;//百分比
  Color color;

  QuestionRankBean(this.type,this.title, this.count,this.value,this.color);
}
