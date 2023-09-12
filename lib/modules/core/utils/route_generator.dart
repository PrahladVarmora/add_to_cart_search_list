import 'package:darshan_vachhani_flutter_yudiz/modules/dashboard/view/screen_cart.dart';
import 'package:darshan_vachhani_flutter_yudiz/modules/dashboard/view/screen_home.dart';
import 'package:darshan_vachhani_flutter_yudiz/modules/dashboard/view/screen_splash.dart';
import 'package:darshan_vachhani_flutter_yudiz/modules/dashboard/view/widget/screen_success.dart';

import 'core_import.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    printWrapped('\x1B[32m${'Navigating to ----> ${settings.name}'}\x1B[0m');
    switch (settings.name) {
      case AppRoutes.routesSplash:
        return MaterialPageRoute(
            builder: (_) => const ScreenSplash(),
            settings: const RouteSettings(name: AppRoutes.routesSplash));

      case AppRoutes.routesHome:
        return MaterialPageRoute(
            builder: (_) => const ScreenHome(),
            settings: const RouteSettings(name: AppRoutes.routesHome));
      case AppRoutes.routesCart:
        return MaterialPageRoute(
            builder: (_) => const ScreenCart(),
            settings: const RouteSettings(name: AppRoutes.routesCart));
      case AppRoutes.routesSuccess:
        return MaterialPageRoute(
            builder: (_) => const ScreenSuccess(),
            settings: const RouteSettings(name: AppRoutes.routesSuccess));

      default:
        return MaterialPageRoute(
            builder: (_) => const ScreenSplash(),
            settings: const RouteSettings(name: AppRoutes.routesSplash));
    }
  }

  static String getRouteName(BuildContext context) {
    return ModalRoute.of(context)?.settings.name ?? '';
  }
}
