import 'package:adpv_frontend/Common/Common.dart';
import 'package:adpv_frontend/Models/EndpointData.dart';
import 'package:adpv_frontend/Models/EndpointSummary.dart';
import 'package:adpv_frontend/Providers/EndpointListModel.dart';
import 'package:adpv_frontend/Repository/AbstractEndpointRepository.dart';
import 'package:adpv_frontend/Routing.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:developer' as developer;

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

  Card _buildEndpointCard(ExpansionPanelEndpoint expansionPanelEndpoint) {
    return Card(
        margin: const EdgeInsets.only(top: 10, bottom: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        color: Colors.white,
        child: ExpansionTile(
          title: TextButton(


            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
            ),
            onPressed: () {
              onTapHandler(expansionPanelEndpoint.id, widget.repository);
            },
            child:
              Container(
                width: ,
                alignment: Alignment.centerLeft,
                child: Text(expansionPanelEndpoint.label,
                    style: const TextStyle(
                      fontFamily: 'SofiaSans',
                      fontSize: 26,
                    )),
              )
          ),
          tilePadding: const EdgeInsets.all(20),
          collapsedTextColor: Colors.black,
          textColor: Colors.pink,
          collapsedIconColor: Colors.black,
          iconColor: Colors.pink,
          childrenPadding: const EdgeInsets.all(0),
          collapsedBackgroundColor: Colors.white,
          children: <Widget>[
            Container(
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 127, 166, 168),
                ),
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: expansionPanelEndpoint.fields.length,
                    itemBuilder: (context, i) {
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        height: 70,
                        alignment: Alignment.centerLeft,
                        margin: const EdgeInsets.only(
                            left: 0, top: 10, right: 0, bottom: 10),
                        padding: const EdgeInsets.all(17),
                        child: Text(expansionPanelEndpoint.fields[i].toString(),
                            style: const TextStyle(
                              color: Colors.grey,
                              fontFamily: 'SofiaSans',
                              fontSize: 20,
                            )),
                      );
                    }))
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
              return FutureBuilder<EndpointData>(
                  future: widget.repository.getEndpointData(
                      endpointListProvider.endpointsList[i]!.id),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.none ||
                        snapshot.data == null) {
                      return LoadingInCenter();
                    } else {
                      endpointListProvider.endpointsList[i]
                          .setRecentData(snapshot.data!);
                    }
                    return _buildEndpointCard(
                        endpointListProvider.endpointsList[i]);
                  });
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
