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
  /// Green Gradient
  static final LinearGradient greenGradient = LinearGradient(
    colors: [
      OColors.gradientGreen1,
      OColors.gradientGreen2,
    ],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    stops: const [0, 1],
  );
  /// Red Gradient
  static final LinearGradient redGradient = LinearGradient(
    colors: [
      OColors.gradientRed1,
      OColors.gradientRed2,
    ],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    stops: const [0, 1],
  );
  /// White Gradient
  static final LinearGradient whiteGradient = LinearGradient(
    colors: [
      OColors.whiteColor,
      OColors.whiteColor,
    ],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    stops: const [0, 1],
  );
}
