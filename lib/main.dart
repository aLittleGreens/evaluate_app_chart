import 'package:evaluate_app_chart/bean/questionType.dart';
import 'package:evaluate_app_chart/data/ListSingleton.dart';
import 'package:evaluate_app_chart/screens/RatingChart.dart';
import 'package:evaluate_app_chart/screens/chart/starChartPage.dart';
import 'package:evaluate_app_chart/screens/chart/drawer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

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

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
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
    compute(parseData, "");
  }

  void parseData(String ss) {
    decodeQuestion();
    decodeAllComment();
    setState(() {});
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
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
      body: Center(
          child: data.isEmpty
              ? const CircularProgressIndicator()
              : Column(
                  children: [
                    Row(
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
                    Container(
                      color: Colors.black12,
                      child: SingleChildScrollView(
                          padding: EdgeInsets.all(10),
                          child: ListView(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            children: const <Widget>[
                              ListTile(
                                contentPadding: EdgeInsets.all(10.0),
                                title: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                    Expanded(
                      child: ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          // return ListTile(
                          //   title: Text(data[index].author),
                          // );
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(data[index].title_translate,
                                          style: const TextStyle(
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.bold)),
                                      Text(data[index].content_translate,
                                          style:
                                              const TextStyle(fontSize: 14.0))
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
                                        typeString(
                                            data[index].ty_question_type),
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
                    )
                  ],
                )),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
