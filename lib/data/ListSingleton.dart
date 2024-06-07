import 'package:evaluate_app_chart/bean/EvaluteBean.dart';

class ListSingleton {
  static final ListSingleton _instance = ListSingleton._internal();
  List<Evalutebean> _list = [];
  String averageRating = "";

  List<String> starFilterItems = ['0', '1', '2', '3', '4', '5'];
  List<String> osFilterItems = ["All OS", "IOS", "Android"];
  Map starFilterMap = {
    "0": "All Ratings",
    "1": "1 stars",
    "2": "2 stars",
    "3": "3 stars",
    "4": "4 stars",
    "5": "5 stars"
  };

  Set<String> versionFilterItems = <String>{'All Version'};
  List<String> questionFilterItems = [

  ];

  Map questionFilterMap = {

  };

  factory ListSingleton() {
    return _instance;
  }

  ListSingleton._internal();

  List<Evalutebean> get list => _list;

  void addItem(Evalutebean item) {
    versionFilterItems.add(item.version);
    _list.add(item);
  }

  void removeItem(Evalutebean item) {
    _list.remove(item);
  }

  List<Evalutebean> filterList(
      {String version = "All Version",
      String question = "0",
      String star = '0',
      String os = "All OS"}) {
    if (version == "All Version" &&
        os == "All OS" &&
        question == "0" &&
        star == "0") {
      return _list;
    }
    List<Evalutebean> filterList = _list;
    if (version != "All Version") {
      filterList = filterList
          .where((item) => item.version == version)
          .toList(growable: true);
    }
    if (question != "0") {
      filterList = filterList
          .where((item) => item.ty_question_type == question)
          .toList(growable: true);
    }

    if (star != "0") {
      filterList = filterList
          .where((item) => item.rating == star)
          .toList(growable: true);
    }

    if (os != "All OS") {
      filterList =
          filterList.where((item) => item.os == os).toList(growable: true);
    }
    print("filterList:${filterList.length}");

    return filterList;
  }
}
