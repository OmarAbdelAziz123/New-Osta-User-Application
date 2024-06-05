import 'package:lottie/lottie.dart';
import 'package:osta_user_app/utils/constants/exports.dart';

class LottieWidget extends StatelessWidget {
  const LottieWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(OImages.pinIcon, height: 120.h, width: 120.w);
  }
}
