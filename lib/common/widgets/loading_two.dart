import 'package:lottie/lottie.dart';
import 'package:osta_user_app/utils/constants/exports.dart';

class LoadingTwo extends StatelessWidget {
  const LoadingTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(OImages.loadingTwo);
  }
}
