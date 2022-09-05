import 'package:flutter/material.dart';

import '../../Common/consts.dart';

class EndpointInfoTable extends StatelessWidget {
  const EndpointInfoTable({required this.data, Key? key}) : super(key: key);

  final List<Map<dynamic, dynamic>> data;

  @override
  Widget build(final BuildContext context) {
    final List<Map<dynamic, dynamic>> newest = data;

    data.sort(
      (a, b) => DateTime.parse(a[ignoreField])
          .compareTo(DateTime.parse(b[ignoreField])),
    );

    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(4),
      width: MediaQuery.of(context).size.width * 0.9,
      child: buildInfo(newest),
    );
  }

  Column buildInfo(final List<Map<dynamic, dynamic>> newest) => Column(
        children: newest.first.entries
            .map(
              (entry) => Container(
                margin: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            entry.key,
                            style: const TextStyle(
                              fontWeight: FontWeight.normal,
                              fontStyle: FontStyle.italic,
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Text(
                              entry.value,
                              style: const TextStyle(
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
            .toList(),
      );
}
