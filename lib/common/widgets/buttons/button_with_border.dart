import '../../../utils/constants/exports.dart';

// class ButtonWithBorderWidget extends StatelessWidget {
//   const ButtonWithBorderWidget({Key? key, required this.textButton, this.onTap}) : super(key: key);
//   final String textButton;
//   final VoidCallback? onTap;
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         width: 164.w,
//         height: 32.h,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(20.r),
//           border: Border.all(
//               width: 2.w,
//               color: OColors.primaryColor500
//           ),
//
//         ),
//         child: Center(
//           child: Text(textButton,style: OStyles.bodyMediumSemiBold),
//         ),
//       ),
//     );
//   }
// }

import '../../../utils/constants/exports.dart';

class ButtonWithBorderWidget extends StatelessWidget {
  const ButtonWithBorderWidget({Key? key, required this.textButton, this.onTap, required this.width, required this.height}) : super(key: key);
  final String textButton;
  final VoidCallback? onTap;
  final double width;
  final double height;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
              width: 2.w,
              color: OColors.primaryColor500
          ),

        ),
        child: Center(
          child: Text(textButton,style: OStyles.bodyMediumSemiBold),
        ),
      ),
    );
  }
}