import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/ListSingleton.dart';
import 'QuestionChart.dart';

class QuestionChartPage extends ConsumerStatefulWidget {
  const QuestionChartPage({Key? key}) : super(key: key);

  @override
  ConsumerState<QuestionChartPage> createState() => _ChartPageState();
}

class _ChartPageState extends ConsumerState<QuestionChartPage> {
  var listSingleton = ListSingleton();
  late String _selectedOsItem;
  late String _selectedQuestionItem;

  @override
  void initState() {
    super.initState();
    _selectedOsItem = listSingleton.osFilterItems.first;
    _selectedQuestionItem = listSingleton.questionFilterItems.isEmpty
        ? "0"
        : listSingleton.questionFilterItems.first;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var data = listSingleton.filterList(
        os: _selectedOsItem,
        question: _selectedQuestionItem);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('star'),
      ),
      body: Center(
          child: listSingleton.list.isEmpty
              ? const CircularProgressIndicator()
              : Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
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
                    QuestionChart(data)
                  ],
                )),
    );
  }
}
