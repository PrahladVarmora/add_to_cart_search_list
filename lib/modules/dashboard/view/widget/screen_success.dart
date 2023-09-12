import 'package:darshan_vachhani_flutter_yudiz/modules/core/utils/core_import.dart';

class ScreenSuccess extends StatefulWidget {
  const ScreenSuccess({super.key});

  @override
  State<ScreenSuccess> createState() => _ScreenSuccessState();
}

class _ScreenSuccessState extends State<ScreenSuccess> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2)).whenComplete(() {
      if (mounted) {
        Navigator.pop(context);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
            padding: const EdgeInsets.all(Dimens.margin16),
            height: Dimens.margin100,
            width: Dimens.margin100,
            decoration:
                const BoxDecoration(color: Colors.teal, shape: BoxShape.circle),
            child: const Icon(
              Icons.check_outlined,
              size: Dimens.margin50,
              color: Colors.white,
            )),
      ),
    );
  }
}
