import 'package:clinicx_patient/providers/branches_provider.dart';
import 'package:clinicx_patient/providers/global_controller.dart';
import 'package:clinicx_patient/providers/location_provider.dart';
import 'package:clinicx_patient/screens/initial_loading.dart';
import 'package:clinicx_patient/utils/network/connection_util.dart';
import 'package:clinicx_patient/utils/network/http_client.dart';
import 'package:clinicx_patient/utils/network/preferences.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await httpClient.initialize();
  await preferences.initialize();

  ConnectionUtil connectionStatus = ConnectionUtil.getInstance();
  connectionStatus.initialize();

  runApp(MyApp(
    connectionStatus: connectionStatus,
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key, required this.connectionStatus});
  final ConnectionUtil connectionStatus;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    globalController.initialize();

    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => globalController),
        ChangeNotifierProvider(create: (context) => LocationProvider()),
        ChangeNotifierProvider(create: (context) => BranchProvider()),
      ],
      child: MaterialApp(
          title: 'ClinicX',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            fontFamily: 'Intel',
          ),
          home: const InitialLoadingScreen()),
    );
  }
}
