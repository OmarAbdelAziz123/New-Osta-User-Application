// import 'package:geolocator/geolocator.dart';
import 'package:osta_user_app/utils/constants/exports.dart';

// class SplashScreen extends StatelessWidget {
//   const SplashScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//
//     void navigateToOnboardingScreen() {
//       Future.delayed(const Duration(seconds: 2), () => context.pushReplacementNamed(ORoutesName.onBoardingRoute));
//     }
//
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       navigateToOnboardingScreen();
//     });
//
//
//     return Scaffold(
//       body: Container(
//         width: double.infinity,
//         decoration: BoxDecoration(gradient: AppGradients.purpleGradient),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             /// App Logo
//             SvgPicture.asset(OImages.appLogo,  width: 124.w, height: 200.h),
//             /// Make Space
//             SizedBox(height: 190.h),
//             /// Loading
//             const LoadingWidget(),
//           ],
//         ),
//       ),
//     );
//   }
// }

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    // checkLocationPermission();
    navigationToHome();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(gradient: AppGradients.purpleGradient),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /// App Logo
            SvgPicture.asset(OImages.appLogo,  width: 124.w, height: 200.h),
            /// Make Space
            SizedBox(height: 190.h),
            /// Loading
            LoadingWidget(iconColor: OColors.whiteColor),
          ],
        ),
      ),
    );
  }

  // Future<void> checkLocationPermission() async {
  //   LocationPermission permission;
  //
  //   bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //   if (!serviceEnabled) {
  //     serviceEnabled = await Geolocator.openLocationSettings();
  //     if (!serviceEnabled) {
  //       return;
  //     }
  //   }
  //
  //   permission = await Geolocator.checkPermission();
  //   if (permission == LocationPermission.denied) {
  //     permission = await Geolocator.requestPermission();
  //     if (permission == LocationPermission.denied) {
  //       return;
  //     }
  //   }
  //
  //   navigationToHome();
  // }

  void navigationToHome() {
    Future.delayed(
      const Duration(seconds: 4),
          () {
        if (OCacheHelper.getString(key: CacheKeys.token) == '') {
          context.pushReplacementNamed(ORoutesName.onBoardingRoute);
        } else {
          context.pushReplacementNamed(ORoutesName.navigationMenuRoute);
        }
      },
    );
  }
}
