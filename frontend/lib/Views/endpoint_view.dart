import 'dart:async';

import 'package:adpv_frontend/Repository/EndpointRepository/endpoint_gateway.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../DataModels/endpoint_data.dart';
import '../Models/endpoint_view_provider.dart';
import '../Repository/UserRepository/user_gateway.dart';
import '../Widgets/EndpointView/endpoint_info_table.dart';
import '../Widgets/EndpointView/titled_line_chart.dart';
import '../Widgets/common_widgets.dart';

class EndpointView extends StatefulWidget {
  const EndpointView({
    required this.endpointId,
    required this.endpointGateway,
    Key? key,
  }) : super(key: key);
  final int endpointId;
  final EndpointGateway endpointGateway;

  @override
  State<EndpointView> createState() => _EndpointViewState();
}

TabBar _buildTabBar(
  EndpointViewProvider endpointViewProvider,
  BuildContext context,
) =>
    TabBar(
      isScrollable: true,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      unselectedLabelStyle: const TextStyle(
        color: Colors.pink,
        fontFamily: "SofiaSans",
        fontSize: 20,
      ),
      labelColor: Colors.pink,
      unselectedLabelColor: const Color.fromARGB(255, 127, 166, 168),
      labelStyle: const TextStyle(
        color: Colors.pink,
        fontFamily: "SofiaSans",
        fontSize: 25,
      ),
      tabs: endpointViewProvider.tabs
          .map(
            (data) => SizedBox(
              width: MediaQuery.of(context).size.width *
                  1 /
                  endpointViewProvider.tabs.length,
              child: Tab(text: data.typeName),
            ),
          )
          .toList(),
    );

SizedBox _buildBarView(
  EndpointViewProvider endpointViewProvider,
  BuildContext context,
  snapshot,
) =>
    SizedBox(
      height: MediaQuery.of(context).size.height * 0.5,
      child: TabBarView(
        children: endpointViewProvider.tabs
            .map(
              (dataKey) => TitledLineChart(
                chartName: dataKey.typeName +
                    spacer +
                    endpointViewProvider.getChartUnitName(
                      dataKey.typeName,
                      snapshot.data,
                    ),
                measureFnCallback: (Map<dynamic, dynamic> dataMap, _) =>
                    dataMap[dataKey.typeName],
                data: snapshot.data!,
              ),
            )
            .toList(),
      ),
    );

class _EndpointViewState extends State<EndpointView> {
  late Future<EndpointData> endpointData = widget.endpointGateway
      .getEndpointData(widget.endpointId, null, null, false)
      .onError(onError);

  FutureOr<EndpointData> onError<E extends Object>(E error, StackTrace stackTrace) {
    UserGateway().resetMemoryToken().then(
          (value) =>
              Navigator.pushNamedAndRemoveUntil(context, '/', (_) => false),
        );
    return Future.error(error.toString());
  }

  @override
  Widget build(BuildContext context) => FutureBuilder<EndpointData>(
        future: endpointData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.none ||
              snapshot.data == null) {
            return Scaffold(
              appBar: buildAppBar(endpointViewAppBar),
              body: loadingInCenter(),
            );
          }

          return Scaffold(
            appBar: buildAppBar(endpointViewAppBar),
            body: RefreshIndicator(
              onRefresh: () => _pullDownRefresh(),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    EndpointInfoTable(data: snapshot.data!.technicalInfo),
                    ChangeNotifierProvider(
                      create: (context) => EndpointViewProvider(snapshot.data!),
                      child: Consumer<EndpointViewProvider>(
                        builder: (context, endpointViewProvider, _) =>
                            DefaultTabController(
                          length: endpointViewProvider.tabs.length,
                          child: Column(
                            children: [
                              _buildTabBar(endpointViewProvider, context),
                              _buildBarView(
                                endpointViewProvider,
                                context,
                                snapshot,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );

  // ignore: always_declare_return_types
  _pullDownRefresh() async {
    endpointData = widget.endpointGateway
        .getEndpointData(widget.endpointId, null, null, true)
        .onError(onError);
  }
}
