import 'package:adpv_frontend/Common/Common.dart';
import 'package:adpv_frontend/Models/EndpointData.dart';
import 'package:adpv_frontend/Models/EndpointSummary.dart';
import 'package:adpv_frontend/Providers/EndpointListModel.dart';
import 'package:adpv_frontend/Repository/AbstractEndpointRepository.dart';
import 'package:adpv_frontend/Routing.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:developer' as developer;

BorderRadius basicBorderRadius = BorderRadius.circular(8);
TextStyle endpointDataTextStyle = const TextStyle(
    color: Color.fromARGB(255, 100, 100, 100),
    fontFamily: 'SofiaSans',
    fontSize: 20);

class EndpointList extends StatefulWidget {
  const EndpointList({Key? key, required this.repository}) : super(key: key);

  final AbstractEndpointRepository repository;

  @override
  State<EndpointList> createState() => _EndpointListState();
}

class _EndpointListState extends State<EndpointList> {
  void onTapHandler(int id, AbstractEndpointRepository endpointRepository) {
    Navigator.pushNamed(context, endpointViewRoute + "/" + id.toString());
  }

  PreferredSize _buildAppBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(100.0),
      child: AppBar(
        toolbarHeight: 120.0,
        automaticallyImplyLeading: false,
        flexibleSpace: Container(),
        centerTitle: false,
        title: const Text("Recent datasets"),
        backgroundColor: Colors.white,
        titleTextStyle: const TextStyle(
            color: Colors.pink,
            fontFamily: 'Ubuntu Condensed',
            fontSize: 50,
            fontWeight: FontWeight.w500),
        titleSpacing: 20,
      ),
    );
  }

  _buildLabelButton(ExpansionPanelEndpoint expansionPanelEndpoint) {
    return Container(
        width: 200,
        alignment: Alignment.centerLeft,
        child: OutlinedButton(
          style: ButtonStyle(
            side: MaterialStateProperty.all(
                BorderSide(width: 2.0, color: Colors.pink)),
            padding: MaterialStateProperty.all(const EdgeInsets.all(20)),
            backgroundColor: MaterialStateProperty.resolveWith<Color>(
                (Set<MaterialState> states) {
              if (states.contains(MaterialState.hovered)) return Colors.pink;
              return Colors.white; // null throus error in flutter 2.2+.
            }),
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
  }

  Card _buildEndpointCard(ExpansionPanelEndpoint expansionPanelEndpoint) {
    return Card(
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
                  future: widget.repository
                      .getRecentData(expansionPanelEndpoint.id, 1, 0),
                  builder: (context, recentDataSnapshot) {
                    if (recentDataSnapshot.connectionState ==
                            ConnectionState.none ||
                        recentDataSnapshot.data == null) {
                      return LoadingInCenter();
                    } else {
                      expansionPanelEndpoint
                          .setRecentData(recentDataSnapshot.data!);
                      return ListView.builder(
                          padding: const EdgeInsets.only(top: 10.0),
                          shrinkWrap: true,
                          itemCount: expansionPanelEndpoint.fields.length,
                          itemBuilder: (context, i) {
                            return Container(
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
                                          expansionPanelEndpoint.fields[i]
                                              .toString(),
                                          textAlign: TextAlign.left,
                                          style: endpointDataTextStyle)),
                                  Expanded(
                                      child: Text(
                                          expansionPanelEndpoint.recentData[
                                                  expansionPanelEndpoint
                                                      .fields[i]
                                                      .toString()]
                                              .toStringAsFixed(2),
                                          textAlign: TextAlign.right,
                                          style: endpointDataTextStyle)),
                                ]));
                          });
                    }
                  },
                ))
          ],
        ));
  }

  Container _buildExpansionList(
      EndpointListProvider endpointListProvider, int itemCount) {
    return Container(
        margin: EdgeInsets.all(32),
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: itemCount,
            itemBuilder: (context, i) {
              return _buildEndpointCard(endpointListProvider.endpointsList[i]);
            }));
  }

  SingleChildScrollView _buildBody() {
    return SingleChildScrollView(
        child: Container(
            color: Colors.transparent,
            margin: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.03,
                right: MediaQuery.of(context).size.width * 0.03,
                top: 50.9),
            child: Wrap(children: [
              FutureBuilder<List<EndpointSummary>>(
                  future: widget.repository.getEndpointSummary(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.none ||
                        snapshot.data == null) {
                      return LoadingInCenter();
                    }
                    return ChangeNotifierProvider(
                        create: (context) =>
                            EndpointListProvider(snapshot.data!),
                        child: Consumer<EndpointListProvider>(
                            builder: (context, endpointListProvider, _) {
                          return _buildExpansionList(
                              endpointListProvider, snapshot.data!.length);
                        }));
                  })
            ])));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 127, 166, 168),
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }
}
