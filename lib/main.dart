import 'package:darshan_vachhani_flutter_yudiz/modules/core/utils/core_import.dart';

import 'bloc_generator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  BlocGenerator.load();
  runApp(const MyApp());
}
