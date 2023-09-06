import 'package:covid19/view/world_states.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  String name;
  String image;
  int totalCase,
      totalDeaths,
      active,
      critical,
      totalRecovered,
      test,
      todayRecovered;

  DetailScreen(
      {super.key,
      required this.name,
      required this.todayRecovered,
      required this.critical,
      required this.active,
      required this.image,
      required this.test,
      required this.totalCase,
      required this.totalDeaths,
      required this.totalRecovered});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * .067),
                child: Card(
                  child: Column(
                    children: [
                      SizedBox(
                          height: MediaQuery.of(context).size.height * .06),
                      ReuseAbleRow(
                          title: 'Cases', value: widget.totalCase.toString()),
                      ReuseAbleRow(
                          title: 'totalDeaths',
                          value: widget.totalDeaths.toString()),
                      ReuseAbleRow(
                          title: 'active', value: widget.active.toString()),
                      ReuseAbleRow(
                          title: 'critical', value: widget.critical.toString()),
                      ReuseAbleRow(
                          title: 'totalRecovered',
                          value: widget.totalRecovered.toString()),
                      ReuseAbleRow(
                          title: 'test', value: widget.test.toString()),
                      ReuseAbleRow(
                          title: 'todayRecovered',
                          value: widget.totalRecovered.toString()),
                    ],
                  ),
                ),
              ),
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(
                  widget.image,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
