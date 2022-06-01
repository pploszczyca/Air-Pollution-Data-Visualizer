import 'package:flutter/material.dart';

class CompareChartsView extends StatefulWidget {
  const CompareChartsView({Key? key}) : super(key: key);

  @override
  State<CompareChartsView> createState() => _CompareChartsViewState();
}

class _CompareChartsViewState extends State<CompareChartsView> {
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      AppBar(
        title: Text("Compare charts"),
      ),
      Container(
        child: Text("Great looking charts will be here soon"),
      ),
    ]);
  }
}
