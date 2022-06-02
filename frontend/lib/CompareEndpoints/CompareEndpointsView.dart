import 'package:adpv_frontend/CompareEndpoints/TwoChartsDateTime.dart';
import 'package:adpv_frontend/Repository/EndpointRepository.dart';
import 'package:flutter/material.dart';

import '../Common/Common.dart';

class CompareChartsView extends StatefulWidget {
  const CompareChartsView({Key? key, required this.endpointRepository})
      : super(key: key);
  final EndpointRepository endpointRepository;

  @override
  State<CompareChartsView> createState() => _CompareChartsViewState();
}

class _CompareChartsViewState extends State<CompareChartsView> {
  String? _firstEndpoint;
  String? _secondEndpoint;
  Widget chart = Container();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Compare charts"),
      ),
      body: FutureBuilder<List<String>>(
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.none ||
              snapshot.data == null) {
            return LoadingInCenter();
          } else {
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    DropdownButton(
                      hint: const Text("SelectEndpoint"),
                      value: _firstEndpoint,
                      items: buildDropDownMenuItems(snapshot).toList(),
                      underline: Container(
                        height: 2,
                        color: Colors.blue,
                      ),
                      onChanged: (value) {
                        setState(() {
                          _firstEndpoint = value as String?;
                        });
                      },
                    ),
                    DropdownButton(
                      hint: const Text("SelectEndpoint"),
                      value: _secondEndpoint,
                      items: buildDropDownMenuItems(snapshot).toList(),
                      underline: Container(
                        height: 2,
                        color: Colors.red,
                      ),
                      onChanged: (value) {
                        setState(() {
                          _secondEndpoint = value as String?;
                        });
                      },
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.all(10.0),
                  child: ElevatedButton(
                      onPressed: () => {
                            this.chart = TwoChartsDateTime(endpoints: [
                              widget.endpointRepository
                                  .getEndpoint(_firstEndpoint!),
                              widget.endpointRepository
                                  .getEndpoint(_secondEndpoint!)
                            ])
                          },
                      child: const Text("Generate charts")),
                ),
                chart
              ],
            );
          }
        },
        future: widget.endpointRepository.getEndpointSummary(),
      ),
    );
  }

  Iterable<DropdownMenuItem<String>> buildDropDownMenuItems(
      AsyncSnapshot<List<String>> snapshot) {
    return snapshot.data!.map((item) => DropdownMenuItem<String>(
          child: Text(item),
          value: item,
        ));
  }

}
