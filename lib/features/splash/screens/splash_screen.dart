import 'package:osta/utils/constants/exports.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
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

  void navigationToHome() {
    Future.delayed(
      const Duration(seconds: 4),
          () {
        if (OCacheHelper.getString(key: CacheKeys.token) == '') {
          context.pushReplacementNamed(ORoutesName.onBoardingRoute);
        } else {
          context.pushReplacementNamed(ORoutesName.navigationMenuRoute, arguments: 0);
        }
      },
    );
  }
}
