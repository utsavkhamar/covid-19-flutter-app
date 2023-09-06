import 'package:covid19/Models/WorldStatesModel.dart';
import 'package:covid19/Services/states_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

import 'countries_list.dart';

class WorldStateScreen extends StatefulWidget {
  const WorldStateScreen({super.key});

  @override
  State<WorldStateScreen> createState() => _WorldStateScreenState();
}

class _WorldStateScreenState extends State<WorldStateScreen>
    with TickerProviderStateMixin {
  late final AnimationController _animationController =
      AnimationController(duration: const Duration(seconds: 3), vsync: this)
        ..repeat();

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  final colorsList = <Color>[
    const Color(0xff4285F4),
    const Color(0xff1aa268),
    const Color(0xffde5246)
  ];

  @override
  Widget build(BuildContext context) {
    StatesServices statesServices = StatesServices();

    return Scaffold(
      body: SafeArea(
          child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .01,
                    ),
                    FutureBuilder(
                        future: statesServices.fetchWorldStatesData(),
                        builder: (context,
                            AsyncSnapshot<WorldStatesModel> snapshot) {
                          if (!snapshot.hasData) {
                            return SizedBox(
                                height: MediaQuery.of(context).size.height,
                                width: MediaQuery.of(context).size.width,
                                child: Center(
                                    child: SpinKitFadingCircle(
                                  color: Colors.white,
                                  controller: _animationController,
                                )));
                          } else {
                            return Column(
                              children: [
                                PieChart(
                                  dataMap: {
                                    "Total": double.parse(
                                        snapshot.data!.cases.toString()),
                                    "Recovered": double.parse(
                                        snapshot.data!.recovered.toString()),
                                    "Death": double.parse(
                                        snapshot.data!.deaths.toString()),
                                  },
                                  chartValuesOptions: const ChartValuesOptions(
                                      showChartValuesInPercentage: true),
                                  legendOptions: const LegendOptions(
                                    legendPosition: LegendPosition.left,
                                  ),
                                  chartType: ChartType.ring,
                                  animationDuration:
                                      const Duration(microseconds: 1200),
                                  colorList: colorsList,
                                ),
                                Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical:
                                            MediaQuery.of(context).size.height *
                                                .04),
                                    child: Card(
                                        elevation: 4,
                                        child: Column(children: [
                                          ReuseAbleRow(
                                              title: 'Total',
                                              value: snapshot.data!.cases
                                                  .toString()),
                                          ReuseAbleRow(
                                              title: 'Recover',
                                              value: snapshot.data!.recovered
                                                  .toString()),
                                          ReuseAbleRow(
                                              title: 'Deaths',
                                              value: snapshot.data!.deaths
                                                  .toString()),
                                          ReuseAbleRow(
                                              title: 'Critical',
                                              value: snapshot.data!.critical
                                                  .toString()),
                                          ReuseAbleRow(
                                              title: 'Today Total Recovered',
                                              value: snapshot
                                                  .data!.todayRecovered
                                                  .toString()),
                                          ReuseAbleRow(
                                              title: 'Today Total Deaths',
                                              value: snapshot.data!.todayDeaths
                                                  .toString()),
                                        ]))),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * .05,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const CountriesList()));
                                  },
                                  child: Container(
                                    height: MediaQuery.of(context).size.height *
                                        .06,
                                    decoration: BoxDecoration(
                                        color: const Color(0xff1aa260),
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: const Center(
                                      child: Text('Track Countries'),
                                    ),
                                  ),
                                )
                              ],
                            );
                          }
                        }),
                  ],
                ),
              ))),
    );
  }
}

// ignore: must_be_immutable
class ReuseAbleRow extends StatelessWidget {
  String title, value;

  ReuseAbleRow({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text(title), Text(value)],
          ),
          const SizedBox(height: 5),
          const Divider()
        ],
      ),
    );
  }
}
