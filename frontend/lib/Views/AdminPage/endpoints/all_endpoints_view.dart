import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Models/all_endpoints_provider.dart';
import '../../../Repository/AdminRepository/admin_endpoints_repository.dart';
import '../../../Widgets/AdminWidgets/admin_app_bar.dart';
import '../../../Widgets/AdminWidgets/admin_styles.dart';
import '../../../Widgets/SortingWidgets/sort_bar.dart';
import '../../../Widgets/common_widgets.dart';
import '../utils.dart';

class AllEndpointsView extends StatefulWidget {
  AllEndpointsView({Key? key}) : super(key: key);
  final AdminEndpointsRepository repository = AdminEndpointsRepository();

  @override
  State<AllEndpointsView> createState() => _AllEndpointsViewState();
}

class _AllEndpointsViewState extends State<AllEndpointsView> {
  late Future<List<EndpointAdminData>> future;

  @override
  void initState() {
    super.initState();
    future = widget.repository.getAllEndpoints();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: adminAppBar("Endpoints list", ""),
        backgroundColor: Colors.white,
        body: FutureBuilder<List<EndpointAdminData>>(
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
                            children: _buildEndpointsList(provider),
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

  Future<void> onRefresh() => future = widget.repository.getAllEndpoints();

  List<Widget> _buildEndpointsList(AllEndpointsProvider provider) =>
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
                onTap: () {
                  //todo: navigate to new view -> "Endpoint Admin View"
                },
              ),
            ),
          )
          .toList();

  Container _buildSortBar(AllEndpointsProvider provider) => Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: [
            ToggleButtons(
              isSelected: _selections,
              fillColor: Colors.transparent,
              renderBorder: false,
              children: [
                _buildToggleButton(
                  "NUMBER",
                  provider.numberIcon,
                  provider.numberColor,
                ),
                _buildToggleButton(
                  "LABEL",
                  provider.labelIcon,
                  provider.labelColor,
                ),
              ],
              onPressed: (int index) {
                provider.changeSorting(index);
              },
            )
          ],
        ),
      );

  Container _buildToggleButton(String buttonName, IconData icon, Color color) =>
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: buttonName,
                style: TextStyle(
                  fontFamily: 'SofiaSans',
                  fontSize: 25,
                  fontWeight: FontWeight.normal,
                  color: color,
                ),
              ),
              WidgetSpan(
                child: Icon(
                  icon,
                  color: color,
                ),
              ),
            ],
          ),
        ),
      );
}
