// import 'package:osta_user_app/utils/constants/exports.dart';
//
// class ThirdButtonWidget extends StatelessWidget {
//   const ThirdButtonWidget({super.key, required this.isRejected, required this.buttonText, required this.textStyle, required this.containerColor});
//
//   final bool isRejected;
//   final String buttonText;
//   final TextStyle textStyle;
//   final Color containerColor;
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 115.w,
//       height: 24.h,
//       decoration: BoxDecoration(color: containerColor, borderRadius: BorderRadius.circular(6.r)),
//       child: Center(
//         child: isRejected ? ShaderMask(
//           shaderCallback: (bounds) => LinearGradient(
//             colors: [OColors.gradientRed1, OColors.gradientRed2],
//             tileMode: TileMode.mirror,
//           ).createShader(bounds),
//           blendMode: BlendMode.srcIn,
//           child: Text(
//             buttonText,
//             style: textStyle,
//           ),
//         ) : Text(
//           buttonText,
//           style: textStyle,
//         ),
//       ),
//     );
//   }
// }
import 'package:osta_user_app/utils/constants/exports.dart';

class ThirdButtonWidget extends StatelessWidget {
  const ThirdButtonWidget({super.key, required this.isRejected, required this.buttonText, required this.textStyle, required this.containerColor,required this .width,required this.height, required this.borderRadius});

  final bool isRejected;
  final String buttonText;
  final TextStyle textStyle;
  final Color containerColor;
  final double width;
  final double height;
  final double borderRadius;


  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(color: containerColor, borderRadius: BorderRadius.circular(borderRadius)),
      child: Center(
        child: isRejected ? ShaderMask(
          shaderCallback: (bounds) => LinearGradient(
            colors: [OColors.gradientRed1, OColors.gradientRed2],
            tileMode: TileMode.mirror,
          ).createShader(bounds),
          blendMode: BlendMode.srcIn,
          child: Text(
            buttonText,
            style: textStyle,
          ),
        ) : Text(
          buttonText,
          style: textStyle,
        ),
      ),
    );
  }
}