import 'package:darshan_vachhani_flutter_yudiz/modules/core/utils/core_import.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastController {
  static showToast(
    String message,
    BuildContext context,
    bool isSuccess, {
    int time = 2,
    VoidCallback? okBtnFunction,
    bool barrierDismissible = true,
  }) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 4,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  static removeToast(BuildContext context) {
    if (kIsWeb) {
      Fluttertoast.cancel();
    } else {
      ScaffoldMessenger.of(context).clearSnackBars();
    }
  }
}
