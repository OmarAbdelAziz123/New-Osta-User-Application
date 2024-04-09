import 'package:osta_user_app/utils/constants/exports.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ODeviceUtils.initCacheHelper();
  await OCacheHelper.init();
  ODeviceUtils.setStatusBarColor(Colors.transparent);
  ODeviceUtils.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const OstaUserApp());
}