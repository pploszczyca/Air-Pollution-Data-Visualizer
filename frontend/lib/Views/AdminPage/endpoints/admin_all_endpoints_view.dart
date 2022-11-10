import 'package:adpv_frontend/Views/AdminPage/endpoints/admin_endpoint_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Providers/all_endpoints_provider.dart';
import '../../../Repository/AdminRepository/admin_endpoints_repository.dart';
import '../../../Widgets/AdminWidgets/admin_app_bar.dart';
import '../../../Widgets/AdminWidgets/admin_styles.dart';
import '../../../Widgets/SortingWidgets/sort_bar.dart';
import '../../../Widgets/common_widgets.dart';

class AdminAllEndpointsView extends StatefulWidget {
  AdminAllEndpointsView({Key? key}) : super(key: key);
  final AdminEndpointsRepository repository = AdminEndpointsRepository();

  @override
  State<AdminAllEndpointsView> createState() => _AdminAllEndpointsViewState();
}

class _AdminAllEndpointsViewState extends State<AdminAllEndpointsView> {
  late Future<EndpointComplexData> future;

  @override
  void initState() {
    super.initState();
    future = widget.repository.getComplexData();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: adminAppBar("Administrator panel", "Endpoints list"),
        backgroundColor: Colors.white,
        body: FutureBuilder<EndpointComplexData>(
          future: future,
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return loadingInCenter();
            } else {
              return ChangeNotifierProvider(
                create: (context) => AllEndpointsProvider(future),
                child: Consumer<AllEndpointsProvider>(
                  builder: (context, provider, _) => RefreshIndicator(
                    onRefresh: onRefresh,
                    child: Column(
                      children: [
                        buildSortBar(
                          provider.sortingModel,
                          () => provider.notify(),
                          provider.endpointsList,
                          provider.getters,
                        ),
                        Expanded(
                          child: ListView(
                            children: _buildEndpointsList(
                              provider,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
          },
        ),
      );

  Future<void> onRefresh() => future = widget.repository.getComplexData();

  List<Widget> _buildEndpointsList(
    AllEndpointsProvider provider,
  ) =>
      provider.endpointsList
          .map(
            (endpoint) => Container(
              padding: const EdgeInsets.only(left: 15),
              decoration: const BoxDecoration(
                border: Border.symmetric(
                  horizontal: BorderSide(color: Colors.black, width: 0.5),
                ),
              ),
              child: ListTile(
                leading: Flexible(
                  child: Text(
                    endpoint.endpointNumber.toString(),
                    style: defaultAdminTextStyle.copyWith(fontSize: 20),
                  ),
                ),
                title: Flexible(
                  child: Text(
                    endpoint.label,
                    style: defaultAdminTextStyle.copyWith(fontSize: 20),
                  ),
                ),
                trailing: const Icon(
                  Icons.arrow_forward_outlined,
                  color: Colors.teal,
                  size: 24,
                ),
                onTap: () async {
                  final changed = await Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => AdminEndpointView(
                        provider.enableFields,
                        provider.fieldParsers,
                        endpoint,
                      ),
                    ),
                  );
                  if (changed != null) {
                    await onRefresh();
                  }
                },
              ),
            ),
          )
          .toList();
}
