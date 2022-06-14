import 'package:adpv_frontend/Common/Common.dart';
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

  ExpansionPanel _buildExpansionPanel(ExpansionPanelEndpoint item) {
    return ExpansionPanel(
        isExpanded: item.isExpanded,
        canTapOnHeader: true,
        headerBuilder: (ctx, bool) {

          return ListTile(
            title: Text(item.headerValue),

          );
        },
        body: ListTile(
          title: Text(item.expandedValue),
        ));
  }

  ExpansionPanelList _buildExpansionPanelList(
      EndpointListProvider endpointListProvider, snapshot) {
    return ExpansionPanelList(
        animationDuration: const Duration(milliseconds: 200),
        expansionCallback: (int index, bool isExpanded) {
          setState(() {
            endpointListProvider.updateState(snapshot.data![index].label);
          });
        },
        children: endpointListProvider.endpointsList
            .map<ExpansionPanel>((ExpansionPanelEndpoint item) {
          return _buildExpansionPanel(item);
        }).toList());
  }

  Container _buildBody() {
    return Container(
        height: 600,
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
                      return _buildExpansionPanelList(
                          endpointListProvider, snapshot);
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
