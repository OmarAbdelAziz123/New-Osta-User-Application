import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osta/utils/constants/bloc_observer.dart';
import 'package:osta/utils/constants/exports.dart';
import 'package:osta/app/osta_user_app.dart';


final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  ODeviceUtils.initCacheHelper();
  await OCacheHelper.init();
  ODeviceUtils.setStatusBarColor(Colors.white);
  ODeviceUtils.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const OstaUserApp());
}