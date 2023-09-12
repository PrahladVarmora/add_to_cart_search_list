import 'package:darshan_vachhani_flutter_yudiz/bloc_generator.dart';
import 'package:darshan_vachhani_flutter_yudiz/modules/core/utils/core_import.dart';
import 'package:provider/provider.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: BlocGenerator.generateBloc(),
      child: MaterialApp(
        title: APPStrings.appName,
        theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            progressIndicatorTheme:
                const ProgressIndicatorThemeData(color: Colors.deepPurple),
            useMaterial3: true),
        onGenerateRoute: RouteGenerator.generateRoute,
        navigatorKey: NavigatorKey.navigatorKey,
      ),
    );
  }
}
