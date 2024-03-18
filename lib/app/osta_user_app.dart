import 'package:osta_user_app/utils/constants/exports.dart';

class OstaUserApp extends StatelessWidget {
  const OstaUserApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(428, 926),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          // theme: OAppTheme.lightTheme,
          // darkTheme: OAppTheme.darkTheme,
          navigatorKey: navigatorKey,
          onGenerateRoute: RouteGenerator.getRoute,
          initialRoute: ORoutesName.splashRoute,
        );
      },
    );
  }
}
