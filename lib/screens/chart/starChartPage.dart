import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../bean/questionType.dart';
import '../../data/ListSingleton.dart';
import '../RatingChart.dart';

class StarChartPage extends ConsumerStatefulWidget {
  const StarChartPage({Key? key}) : super(key: key);

  @override
  ConsumerState<StarChartPage> createState() => _ChartPageState();
}

class _ChartPageState extends ConsumerState<StarChartPage> {
  var listSingleton = ListSingleton();
  late String _selectedOsItem;
  late String _selectedStarItem;
  late String _selectedVersionItem;

  @override
  void initState() {
    super.initState();
    _selectedOsItem = listSingleton.osFilterItems.first;
    _selectedStarItem = listSingleton.starFilterItems.first;
    _selectedVersionItem = listSingleton.versionFilterItems.first;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var data = listSingleton.filterList(
        os: _selectedOsItem,
        version: _selectedVersionItem,
        star: _selectedStarItem);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('star'),
      ),
      body: Center(
          child: data.isEmpty
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
                      ],
                    ),
                    const Expanded(child: RatingChart())
                  ],
                )),
    );
  }
}
