import 'package:adpv_frontend/Repository/EndpointRepository/EndpointGateway.dart';
import 'package:adpv_frontend/Views/EndpointView.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../DataModels/Endpoint/EndpointData.dart';
import '../DataModels/Endpoint/EndpointSummary.dart';
import '../Models/EndpointListProvider.dart';
import '../Widgets/CommonWidgets.dart';

BorderRadius basicBorderRadius = BorderRadius.circular(8);

const TextStyle endpointDataTextStyle = TextStyle(
    color: Color.fromARGB(255, 100, 100, 100),
    fontFamily: 'SofiaSans',
    fontSize: 20);

const int limit = 1;
const int offset = 0;

class EndpointListView extends StatefulWidget {
  const EndpointListView({required this.repository, Key? key})
      : super(key: key);

  final EndpointGateway repository;

  @override
  State<EndpointListView> createState() => _EndpointListViewState();
}

class _EndpointListViewState extends State<EndpointListView> {
  void onTapHandler(int id, EndpointGateway endpointRepository) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => EndpointView(
              endpointId: id, endpointGateway: endpointRepository)),
    );
  }

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
              fontWeight: FontWeight.w500),
          titleSpacing: 20,
        ),
      );

  Container _buildLabelButton(ExpansionPanelEndpoint expansionPanelEndpoint) =>
      Container(
          width: 200,
          alignment: Alignment.centerLeft,
          child: OutlinedButton(
            style: ButtonStyle(
              side: MaterialStateProperty.all(
                  const BorderSide(width: 2, color: Colors.pink)),
              padding: MaterialStateProperty.all(const EdgeInsets.all(20)),
              backgroundColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) =>
                      states.contains(MaterialState.hovered)
                          ? Colors.pink
                          : Colors.white),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(borderRadius: basicBorderRadius),
              ),
              alignment: Alignment.centerLeft,
            ),
            onPressed: () {
              onTapHandler(expansionPanelEndpoint.id, widget.repository);
            },
            onHover: (hc) {
              setState(() {
                expansionPanelEndpoint.buttonColor =
                    hc ? Colors.white : Colors.pink;
              });
            },
            child: Text(expansionPanelEndpoint.label,
                style: TextStyle(
                    fontFamily: 'SofiaSans',
                    fontSize: 26,
                    color: expansionPanelEndpoint.buttonColor)),
          ));

  Card _buildEndpointCard(ExpansionPanelEndpoint expansionPanelEndpoint) =>
      Card(
          margin: const EdgeInsets.only(top: 10, bottom: 10),
          shadowColor: Colors.transparent,
          child: ExpansionTile(
            title: _buildLabelButton(expansionPanelEndpoint),
            tilePadding: const EdgeInsets.all(20),
            childrenPadding: const EdgeInsets.all(0),
            children: <Widget>[
              Container(
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 127, 166, 168),
                  ),
                  child: FutureBuilder<EndpointData>(
                    future: widget.repository.getEndpointData(
                        expansionPanelEndpoint.id, null, null, false),
                    builder: (context, recentDataSnapshot) {
                      if (recentDataSnapshot.connectionState ==
                              ConnectionState.none ||
                          recentDataSnapshot.data == null) {
                        return loadingInCenter();
                      } else {
                        // line below temporary fixes always loading everything problem
                        expansionPanelEndpoint.setRecentData(EndpointData(
                            [recentDataSnapshot.data!.dataList.first],
                            [recentDataSnapshot.data!.technicalInfo.first],
                            [recentDataSnapshot.data!.enableFieldsList.first]));
                        return ListView.builder(
                            physics: const AlwaysScrollableScrollPhysics(),
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
                                    left: 0, top: 10, right: 0, bottom: 10),
                                padding: const EdgeInsets.all(17),
                                child: Row(children: <Widget>[
                                  Expanded(
                                      child: Text(
                                          expansionPanelEndpoint.fields[i],
                                          textAlign: TextAlign.left,
                                          style: endpointDataTextStyle)),
                                  Expanded(
                                      child: Text(
                                          expansionPanelEndpoint.recentData[
                                                  expansionPanelEndpoint
                                                      .fields[i]]
                                              .toStringAsFixed(2),
                                          textAlign: TextAlign.right,
                                          style: endpointDataTextStyle)),
                                ])));
                      }
                    },
                  ))
            ],
          ));

  Container _buildExpansionList(
          EndpointListProvider endpointListProvider, int itemCount) =>
      Container(
          margin: const EdgeInsets.only(left: 10, right: 10),
          child: ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: itemCount,
              itemBuilder: (context, i) =>
                  _buildEndpointCard(endpointListProvider.endpointsList[i])));

  SingleChildScrollView _buildBody() => SingleChildScrollView(
      child: Container(
          color: Colors.transparent,
          margin: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.03,
              right: MediaQuery.of(context).size.width * 0.03,
              top: 50.9),
          child: FutureBuilder<List<EndpointSummary>>(
              future: widget.repository.getEndpointSummary(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.none ||
                    snapshot.data == null) {
                  return loadingInCenter();
                }
                return ChangeNotifierProvider(
                    create: (context) =>
                        EndpointListProvider(snapshot.data!, widget.repository),
                    child: Consumer<EndpointListProvider>(
                        builder: (context, endpointListProvider, _) =>
                            _buildExpansionList(
                                endpointListProvider, snapshot.data!.length)));
              })));

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: const Color.fromARGB(255, 127, 166, 168),
        appBar: _buildAppBar(),
        body: _buildBody(),
      );
}
