import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osta_user_app/features/auth/managers/auth_cubit.dart';
import 'package:osta_user_app/features/home/managers/home_cubit.dart';
import 'package:osta_user_app/features/offer/managers/offers_orders_cubit.dart';
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
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => AuthCubit()..getAllCountriesFunction()),
            BlocProvider(create: (context) => HomeCubit()..getAllServicesFunction()..getAllCountriesFunction()..getAllAddressesFunction()),
            BlocProvider(create: (context) => OffersOrdersCubit()..getAllOrdersByMeFunction()),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            // theme: OAppTheme.lightTheme,
            // darkTheme: OAppTheme.darkTheme,
            navigatorKey: navigatorKey,
            onGenerateRoute: RouteGenerator.getRoute,
            initialRoute: ORoutesName.splashRoute,
            // initialRoute: ORoutesName.tilingAndPaintingRoute,
            // initialRoute: ORoutesName.homeAppSatelliteChannelAndSurveillanceCamerasSRoute,
          ),
        );
      },
    );
  }
}
