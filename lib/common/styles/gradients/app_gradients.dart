import 'package:osta_user_app/utils/constants/exports.dart';

class AppGradients {
  /// Purple Gradient
  static final LinearGradient purpleGradient = LinearGradient(
    colors: [
      OColors.gradientPurple2,
      OColors.gradientPurple1,
    ],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    stops: const [0, 1],
  );
}
