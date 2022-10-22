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

const appBarLabel = 'Endpoint Details';

const pinkTextStyle = TextStyle(
  fontFamily: "Sofia Sans",
  decoration: TextDecoration.underline,
  color: Colors.pink,
);

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

class _EndpointViewState extends State<EndpointView> {
  late Future<EndpointData> endpointData = widget.endpointGateway
      .getEndpointData(widget.endpointId, null, null, true)
      .onError(onError);

  FutureOr<EndpointData> onError<E extends Object>(
    E error,
    StackTrace stackTrace,
  ) {
    UserGateway().resetMemoryToken().then(
          (value) =>
              Navigator.pushNamedAndRemoveUntil(context, '/', (_) => false),
        );
    return Future.error(error.toString());
  }

  SizedBox _buildBarView(
    EndpointViewProvider endpointViewProvider,
    BuildContext context,
    snapshot,
    int endpointId,
  ) =>
      SizedBox(
        height: MediaQuery.of(context).size.height * 0.7,
        child: TabBarView(
          children: endpointViewProvider.tabs
              .map(
                (dataKey) => Column(
                  children: [
                    TitledLineChart(
                      chartName: dataKey.typeName +
                          spacer +
                          endpointViewProvider.getChartUnitName(
                            dataKey.typeName,
                            snapshot.data,
                          ),
                      measureFnCallback: (Map<dynamic, dynamic> dataMap, _) =>
                          dataMap[dataKey.typeName],
                      data: endpointViewProvider.endpointData,
                    ),
                    const Divider(
                      height: 25,
                      color: Colors.pink,
                      thickness: 3,
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      height: MediaQuery.of(context).size.height * 0.3,
                      child: ListView.separated(
                        separatorBuilder: (context, index) => const Divider(
                          color: Colors.black,
                          thickness: 1,
                          height: 0,
                        ),
                        addAutomaticKeepAlives: true,
                        itemCount:
                            endpointViewProvider.endpointData.dataList.length +
                                1,
                        itemBuilder: (context, i) {
                          if (i <
                              endpointViewProvider
                                  .endpointData.dataList.length) {
                            return endpointViewProvider.makeListElement(
                              dataKey.typeName,
                              i,
                            );
                          } else {
                            if (endpointViewProvider.loadedAll) {
                              return const ListTile(
                                title: Text(
                                  "No more data",
                                  style: pinkTextStyle,
                                ),
                              );
                            }
                            return ListTile(
                              title: const Text(
                                "Load more data",
                                style: pinkTextStyle,
                              ),
                              onTap: () {
                                endpointViewProvider.loadMore(endpointId);
                                setState(() {});
                              },
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              )
              .toList(),
        ),
      );
}
