import 'package:darshan_vachhani_flutter_yudiz/modules/core/utils/core_import.dart';

class ScreenSplash extends StatefulWidget {
  const ScreenSplash({super.key});

  @override
  State<ScreenSplash> createState() => _ScreenSplashState();
}

class _ScreenSplashState extends State<ScreenSplash> {
  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 500)).whenComplete(() {
      Navigator.pushNamedAndRemoveUntil(
          context, AppRoutes.routesHome, (route) => false);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(APPStrings.appName,
            style: TextStyle(fontSize: Dimens.textSize30)),
      ),
    );
  }
}
