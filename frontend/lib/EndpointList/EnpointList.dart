import 'package:adpv_frontend/EndpointView/EndpointView.dart';
import 'package:adpv_frontend/Repository/EndpointRepository.dart';
import 'package:flutter/material.dart';

class EndpointList extends StatefulWidget {
  const EndpointList({Key? key, required this.endpointRepository})
      : super(key: key);

  final EndpointRepository endpointRepository;

  @override
  State<EndpointList> createState() => _EndpointListState();
}

class _EndpointListState extends State<EndpointList> {
  final _biggerFont = const TextStyle(fontSize: 18);

  void onTapHandler(String id, EndpointRepository endpointRepository) {
    print("handle tap");
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              EndpointView(
                endpoint: endpointRepository.getEndpoint(id),
              ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Data Visualizer")),
      body: FutureBuilder<List<String>>(
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.none ||
              snapshot.data == null) {
            return Container();
          }
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, i) {
              final endpointName = snapshot.data![i];

              void onTap () {
                onTapHandler(endpointName, widget.endpointRepository);
              }

              return ListTile(
                title: Text(endpointName),
                onTap: onTap,
                trailing: IconButton(
                  icon: const Icon(Icons.arrow_forward_ios),
                  onPressed: onTap,
                ),
              );
            },
          );
        },
        future: widget.endpointRepository.getEndpointSummary(),
      ),
    );
  }
}
