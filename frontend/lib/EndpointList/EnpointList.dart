import 'package:adpv_frontend/Common/Common.dart';
import 'package:adpv_frontend/Repository/EndpointRepository.dart';
import 'package:adpv_frontend/Routing.dart';
import 'package:flutter/material.dart';

class EndpointList extends StatefulWidget {
  const EndpointList({Key? key, required this.endpointRepository})
      : super(key: key);

  final EndpointRepository endpointRepository;

  @override
  State<EndpointList> createState() => _EndpointListState();
}

class _EndpointListState extends State<EndpointList> {
  void onTapHandler(String id, EndpointRepository endpointRepository) {
    Navigator.pushNamed(context, endpointViewRoute + "/" + id);
  }

  @override
  Widget build(BuildContext context) {
    int? _activeMeterIndex;
    //provider
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 127, 166, 168),
      appBar: PreferredSize(
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
          )),
      body: FutureBuilder<List<String>>(
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.none ||
              snapshot.data == null) {
            return LoadingInCenter();
          }
          return Container(
            height: 600,
              margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.03 , right: MediaQuery.of(context).size.width * 0.03, top: 50.9),

            child: ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, i) {
              final endpointName = snapshot.data![i];

              void onTap() {
                onTapHandler(endpointName, widget.endpointRepository);
              }

              return Card(
                margin: const EdgeInsets.only( top: 50.0, bottom: 10.0),
                  // decoration: const BoxDecoration(color: Colors.white),
                  child: ExpansionPanelList(
                      expansionCallback: (int index, bool status) {
                        setState(() {
                          _activeMeterIndex = _activeMeterIndex == i ? null : i;
                          print(_activeMeterIndex);
                        });
                      },
                      children: [
                        //consumer
                      ExpansionPanel(
                      isExpanded: true,
                      headerBuilder: (BuildContext context, bool isExpanded) =>
                      Container(
                          padding:
                          const EdgeInsets.only(left: 15.0),
                          alignment: Alignment.centerLeft,
                          child: const Text(
                            'lololololo',
                          )),
                  body: Container(
                    child: ListTile(
                      title: Text(endpointName),
                      onTap: onTap,
                      trailing: IconButton(
                        icon: const Icon(Icons.arrow_forward_ios),
                        onPressed: onTap,
                      ),
                    ),
                  )
                  )
                  ]
                  )
              );
            },
          )
          );
        },
        future: widget.endpointRepository.getEndpointSummary(),
      ),
    );
  }
}
