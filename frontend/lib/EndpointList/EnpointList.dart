import 'package:adpv_frontend/Common/Common.dart';
import 'package:adpv_frontend/Models/EndpointSummary.dart';
import 'package:adpv_frontend/Repository/AbstractEndpointRepository.dart';
import 'package:adpv_frontend/Routing.dart';
import 'package:flutter/material.dart';

class EndpointList extends StatefulWidget {
  const EndpointList({Key? key, required this.repository})
      : super(key: key);

  final AbstractEndpointRepository repository;

  @override
  State<EndpointList> createState() => _EndpointListState();
}

class _EndpointListState extends State<EndpointList> {
  void onTapHandler(int id, AbstractEndpointRepository endpointRepository) {
    Navigator.pushNamed(context, endpointViewRoute + "/" + id.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Data Visualizer")),
      body: FutureBuilder<List<EndpointSummary>>(
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.none ||
              snapshot.data == null) {
            return LoadingInCenter();
          }
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, i) {
              final endpointSumary = snapshot.data![i];

              void onTap () {
                onTapHandler(endpointSumary.id, widget.repository);
              }

              return ListTile(
                title: Text(endpointSumary.label),
                onTap: onTap,
                trailing: IconButton(
                  icon: const Icon(Icons.arrow_forward_ios),
                  onPressed: onTap,
                ),
              );
            },
          );
        },
        future: widget.repository.getEndpointSummary(),
      ),

    );
  }
}
