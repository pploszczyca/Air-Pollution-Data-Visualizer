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

  Container _buildBody() {
    return Container(
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
                    create: (context) => EndpointListProvider(snapshot.data!),
                    child: Consumer<EndpointListProvider>(
                        builder: (context, endpointListProvider, _) {
                      return Container(
                          margin: EdgeInsets.all(32),
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, i) {
                                return FutureBuilder<EndpointData>(
                                    future: widget.repository.getEndpointData(
                                        endpointListProvider
                                            .endpointsList[i]!.id),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                              ConnectionState.none ||
                                          snapshot.data == null) {
                                        return LoadingInCenter();
                                      } else {
                                        endpointListProvider.endpointsList[i]
                                            .setRecentData(snapshot.data!);
                                      }
                                      return Card(
                                          child: ExpansionTile(
                                        title: Text(endpointListProvider
                                            .endpointsList[i]!.label),
                                        children: <Widget>[
                                          ListTile(
                                              title: Text(
                                                  snapshot.data.toString())),
                                        ],
                                      ));
                                    });
                              }));
                    }));
              })
        ]));
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
