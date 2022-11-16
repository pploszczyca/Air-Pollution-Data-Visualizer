import 'package:adpv_frontend/Repository/EndpointRepository/endpoint_gateway.dart';
import 'package:adpv_frontend/Views/endpoint_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../DataModels/endpoint_data.dart';
import '../DataModels/endpoint_summary.dart';
import '../Providers/endpoint_list_provider.dart';
import '../Widgets/common_widgets.dart';

BorderRadius basicBorderRadius = BorderRadius.circular(8);

const TextStyle endpointDataTextStyle = TextStyle(
  color: Color.fromARGB(255, 100, 100, 100),
  fontFamily: 'SofiaSans',
  fontSize: 20,
);

const int limit = 1;
const int offset = 0;

class EndpointListView extends StatefulWidget {
  const EndpointListView({required this.gateway, Key? key}) : super(key: key);

  final EndpointGateway gateway;

  @override
  State<EndpointListView> createState() => _EndpointListViewState();
}

class _EndpointListViewState extends State<EndpointListView> {

  late Future<List<EndpointSummary>> future;

  void onTapHandler(
    int id,
    EndpointGateway endpointGateway,
    EndpointListProvider endpointListProvider,
  ) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            EndpointView(endpointId: id, endpointGateway: endpointGateway),
      ),
    );
    if (result != null && result == true) {
      await _refresh(endpointListProvider);
    }
  }

  @override
  void initState() {
    super.initState();
    future = widget.gateway.getEndpointSummary();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: _buildAppBar(),
        body: _buildBody(),
      );

  PreferredSize _buildAppBar() => PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: AppBar(
          toolbarHeight: 100,
          automaticallyImplyLeading: false,
          flexibleSpace: Container(),
          centerTitle: false,
          title: const Text("Recent datasets"),
          backgroundColor: Colors.white,
          titleTextStyle: const TextStyle(
            color: Colors.pink,
            fontFamily: 'Ubuntu Condensed',
            fontSize: 40,
            fontWeight: FontWeight.w500,
          ),
          titleSpacing: 20,
        ),
      );

  FutureBuilder _buildBody() => FutureBuilder<List<EndpointSummary>>(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.none ||
              snapshot.data == null) {
            return loadingInCenter();
          }
          return ChangeNotifierProvider(
            create: (context) =>
                EndpointListProvider(snapshot.data!, widget.gateway),
            child: SingleChildScrollView(
              controller: ScrollController(),
              child: Container(
                height: MediaQuery.of(context).size.height,
                padding:
                    EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
                decoration: buildBackgroundBoxDecoration(),
                child: Consumer<EndpointListProvider>(
                  builder: (context, endpointListProvider, _) =>
                      RefreshIndicator(
                    onRefresh: () => _refresh(endpointListProvider),
                    child: _buildList(
                      endpointListProvider,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      );

  Container _buildList(
    EndpointListProvider endpointListProvider,
  ) =>
      Container(
        margin: const EdgeInsets.only(left: 10, right: 10),
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: endpointListProvider.endpointsList.length,
          itemBuilder: (context, i) => _buildEndpointCard(
            endpointListProvider.endpointsList[i],
            endpointListProvider,
          ),
        ),
      );

  Card _buildEndpointCard(
    ExpansionPanelEndpoint expansionPanelEndpoint,
    EndpointListProvider endpointListProvider,
  ) {
    final Future<EndpointData> dataFuture = widget.gateway.getEndpointData(
      expansionPanelEndpoint.id,
      null,
      null,
      true,
    );
    return Card(
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      shadowColor: Colors.transparent,
      child: ExpansionTile(
        title: _buildLabelButton(expansionPanelEndpoint, endpointListProvider),
        tilePadding: const EdgeInsets.all(20),
        childrenPadding: const EdgeInsets.all(0),
        children: <Widget>[
          FutureBuilder<EndpointData>(
            future: dataFuture,
            builder: (context, recentDataSnapshot) {
              if (recentDataSnapshot.connectionState == ConnectionState.none ||
                  recentDataSnapshot.data == null) {
                return loadingInCenter();
              } else {
                // line below temporary fixes always loading everything problem
                expansionPanelEndpoint.setRecentData(
                  EndpointData(
                    recentDataSnapshot.data!.dataList,
                    recentDataSnapshot.data!.technicalInfo,
                    recentDataSnapshot.data!.enableFieldsList,
                  ),
                );
                return ListView.builder(
                  padding: const EdgeInsets.only(top: 10),
                  shrinkWrap: true,
                  itemCount: expansionPanelEndpoint.fields.length,
                  itemBuilder: (context, i) => Container(
                    decoration: BoxDecoration(
                      borderRadius: basicBorderRadius,
                      color: Colors.white,
                    ),
                    height: 70,
                    margin: const EdgeInsets.only(
                      left: 0,
                      top: 10,
                      right: 0,
                      bottom: 10,
                    ),
                    padding: const EdgeInsets.all(17),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            expansionPanelEndpoint.fields[i],
                            textAlign: TextAlign.left,
                            style: endpointDataTextStyle,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            expansionPanelEndpoint.recentData[
                                        expansionPanelEndpoint.fields[i]]
                                    .toStringAsFixed(2) +
                                spacer +
                                expansionPanelEndpoint.units[i].name,
                            textAlign: TextAlign.right,
                            style: endpointDataTextStyle,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
            },
          )
        ],
      ),
    );
  }

  Container _buildLabelButton(
    ExpansionPanelEndpoint expansionPanelEndpoint,
    EndpointListProvider endpointListProvider,
  ) =>
      Container(
        width: 200,
        alignment: Alignment.centerLeft,
        child: OutlinedButton(
          style: ButtonStyle(
            side: MaterialStateProperty.all(
              const BorderSide(width: 2, color: Colors.pink),
            ),
            padding: MaterialStateProperty.all(const EdgeInsets.all(20)),
            backgroundColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) =>
                  states.contains(MaterialState.hovered)
                      ? Colors.pink
                      : Colors.white,
            ),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: basicBorderRadius),
            ),
            alignment: Alignment.centerLeft,
          ),
          onPressed: () {
            onTapHandler(
              expansionPanelEndpoint.id,
              widget.gateway,
              endpointListProvider,
            );
          },
          onHover: (hc) {
            setState(() {
              expansionPanelEndpoint.buttonColor =
                  hc ? Colors.white : Colors.pink;
            });
          },
          child: Text(
            expansionPanelEndpoint.label,
            style: TextStyle(
              fontFamily: 'SofiaSans',
              fontSize: 26,
              color: expansionPanelEndpoint.buttonColor,
            ),
          ),
        ),
      );

  Future<void> _refresh(EndpointListProvider endpointListProvider) async {
    endpointListProvider.makeEndpointsList(
      await widget.gateway.getEndpointSummary(needUpdate: true),
    );
  }
}
