import 'package:evaluate_app_chart/bean/questionType.dart';
import 'package:evaluate_app_chart/data/ListSingleton.dart';
import 'package:evaluate_app_chart/screens/chart/drawer.dart';
import 'package:evaluate_app_chart/screens/chart/question/QuestionChartPage.dart';
import 'package:evaluate_app_chart/screens/chart/star/starChartPage.dart';
import 'package:evaluate_app_chart/screens/chart/utils/EvaluteUtils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import 'data/DataParse.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final _router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (_, __) =>
            const MyHomePage(title: 'Philips Avent Baby Monitor+'),
        routes: [
          GoRoute(
            path: 'starChart',
            builder: (_, __) => const StarChartPage(),
          ), GoRoute(
            path: 'questionChart',
            builder: (_, __) => const QuestionChartPage(),
          ),
        ],
      ),
    ],
  );

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp.router(
        title: 'Reviews',
        theme: ThemeData(
          useMaterial3: true,
          primarySwatch: Colors.amber,
          typography: Typography.material2018(),
        ),
        routerConfig: _router,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var listSingleton = ListSingleton();
  late String _selectedOsItem;
  late String _selectedStarItem;
  late String _selectedVersionItem;
  late String _selectedQuestionItem;

  @override
  void initState() {
    super.initState();
    _selectedOsItem = listSingleton.osFilterItems.first;
    _selectedStarItem = listSingleton.starFilterItems.first;
    _selectedVersionItem = listSingleton.versionFilterItems.first;
    _selectedQuestionItem = listSingleton.questionFilterItems.isEmpty
        ? "0"
        : listSingleton.questionFilterItems.first;
    fetchData();
  }

  void fetchData() {
    parseData();
  }

  void parseData() {
    Future<String> fetchData() async {
      decodeQuestion();
      await decodeAllComment(); // 模拟2秒延迟
      return 'Data loaded successfully';
    }

    fetchData().then((result) {
      // 任务完成后切换回主线程刷新UI
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    var data = listSingleton.filterList(
        os: _selectedOsItem,
        version: _selectedVersionItem,
        question: _selectedQuestionItem,
        star: _selectedStarItem);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      drawer: const CategoriesDrawer(),
      body: listSingleton.list.isEmpty
          ? const CircularProgressIndicator()
          : NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  SliverAppBar(
                    title: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        DropdownButton<String>(
                          value: _selectedOsItem,
                          onChanged: (value) => {
                            setState(() {
                              _selectedOsItem = value!;
                            })
                          },
                          items:
                              listSingleton.osFilterItems.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                        DropdownButton<String>(
                          value: _selectedStarItem,
                          onChanged: (value) => {
                            setState(() {
                              _selectedStarItem = value!;
                            })
                          },
                          items:
                              listSingleton.starFilterItems.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(listSingleton.starFilterMap[value]),
                            );
                          }).toList(),
                        ),
                        DropdownButton<String>(
                          value: _selectedVersionItem,
                          onChanged: (value) => {
                            setState(() {
                              _selectedVersionItem = value!;
                            })
                          },
                          items: listSingleton.versionFilterItems
                              .map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                        DropdownButton<String>(
                          value: _selectedQuestionItem,
                          onChanged: (value) => {
                            setState(() {
                              _selectedQuestionItem = value!;
                            })
                          },
                          items: listSingleton.questionFilterItems
                              .map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child:
                                  Text(listSingleton.questionFilterMap[value]),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                    leading: Container(), // 去除 leading 部分
                  ),
                  SliverAppBar(
                    leading: Container(), // 去除 leading 部分
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text("Review count",
                                  style: GoogleFonts.notoSans(
                                      textStyle:
                                          const TextStyle(fontSize: 16.0))),
                              Text("${data.length}",
                                  style: const TextStyle(
                                      fontSize: 19.0,
                                      fontWeight: FontWeight.bold))
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text("Selected average rating",
                                  style: GoogleFonts.notoSans(
                                      textStyle:
                                          const TextStyle(fontSize: 16.0))),
                              Text(getAverageRating(data),
                                  style: const TextStyle(
                                      fontSize: 19.0,
                                      fontWeight: FontWeight.bold))
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("cumulative average rating",
                                  style: GoogleFonts.notoSans(
                                      textStyle:
                                          const TextStyle(fontSize: 16.0))),
                              Text(listSingleton.averageRating,
                                  style: const TextStyle(
                                      fontSize: 19.0,
                                      fontWeight: FontWeight.bold))
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SliverAppBar(
                    flexibleSpace: Container(
                      child: Container(
                        color: Colors.black12,
                        child: SingleChildScrollView(
                            child: ListView(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              children: const <Widget>[
                                ListTile(
                                  title: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Expanded(
                                        flex: 1,
                                        child: Center(
                                          child: Text("OS",
                                              style: const TextStyle(
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.bold)),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Center(
                                          child: Text("Rating",
                                              style: const TextStyle(
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.bold)),
                                        ),
                                      ),
                                      // Expanded(
                                      //   flex: 1,
                                      //   child: Text(data[index].author,
                                      //       style: TextStyle(fontSize: 12.0)),
                                      // ),
                                      Expanded(
                                        flex: 3,
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Text("Reviews",
                                                style: const TextStyle(
                                                    fontSize: 14.0,
                                                    fontWeight: FontWeight.bold)),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Center(
                                          child: Text("Date",
                                              style: const TextStyle(
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.bold)),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Center(
                                          child: Text("Country/Region",
                                              style: const TextStyle(
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.bold)),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Center(
                                          child: Text("question classify",
                                              style: TextStyle(
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.bold)),
                                        ),
                                      ),
                                    ],
                                  ),
                                  trailing: Text('Version',
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold)),
                                )
                              ],
                            )),
                      ),
                    ),
                    leading: SizedBox.shrink(),
                    // 去除 leading 部分
                    actions: <Widget>[SizedBox.shrink()],
                    // 去除阴影
                  ),
                ];
              },
              body: Expanded(
                child: ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      contentPadding: EdgeInsets.all(10.0),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: Center(
                              child: Text(data[index].os,
                                  style: const TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Center(
                              child: Text(data[index].rating,
                                  style: const TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                          // Expanded(
                          //   flex: 1,
                          //   child: Text(data[index].author,
                          //       style: TextStyle(fontSize: 12.0)),
                          // ),
                          Expanded(
                            flex: 3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(data[index].title_translate,
                                    style: GoogleFonts.notoSans(
                                        textStyle: const TextStyle(
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.bold))),
                                Text(data[index].content_translate,
                                    style: const TextStyle(fontSize: 14.0))
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Center(
                              child: Text(data[index].updated,
                                  style: const TextStyle(fontSize: 14.0)),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Center(
                              child: Text(data[index].cc,
                                  style: const TextStyle(fontSize: 14.0)),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Center(
                              child: Text(
                                  typeString(data[index].ty_question_type),
                                  style: const TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                        ],
                      ),
                      trailing: Text(
                        data[index].version,
                        style: const TextStyle(fontSize: 16.0),
                      ),
                      onTap: () {
                        // 点击列表项时的操作
                      },
                    );
                  },
                ),
              ),
            ),
    );
  }
}
