import 'package:darshan_vachhani_flutter_yudiz/modules/core/utils/core_import.dart';

///[printWrapped] this function is used to print only in debug mode
void printWrapped(String text) {
  final pattern = RegExp('.{1,800}');
  // ignore: avoid_print
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

///[getNavigatorKeyContext] is used to getting current context
BuildContext getNavigatorKeyContext() {
  return NavigatorKey.navigatorKey.currentContext ??
      NavigatorKey.navigatorKey.currentState!.context;
}
