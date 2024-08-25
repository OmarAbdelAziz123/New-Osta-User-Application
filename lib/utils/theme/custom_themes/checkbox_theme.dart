// import 'package:osta/utils/constants/exports.dart';
//
// class DCheckBoxTheme {
//   DCheckBoxTheme._();
//
//   /// Customizable Light Text Theme
//   static CheckboxThemeData lightCheckboxTheme = CheckboxThemeData(
//     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
//     checkColor: MaterialStateProperty.resolveWith((states) {
//       if(states.contains(MaterialState.selected)) {
//         return Colors.white;
//       } else {
//         return Colors.black;
//       }
//     }),
//     fillColor: MaterialStateProperty.resolveWith((states) {
//       if(states.contains(MaterialState.selected)) {
//         return OColors.primaryColor500;
//       } else {
//         return Colors.transparent;
//       }
//     }),
//   );
//
//   /// Customizable Dark Text Theme
//   static CheckboxThemeData darkCheckboxTheme = CheckboxThemeData(
//     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
//     checkColor: MaterialStateProperty.resolveWith((states) {
//       if(states.contains(MaterialState.selected)) {
//         return Colors.primaryColor500;
//       } else {
//         return Colors.black;
//       }
//     }),
//     fillColor: MaterialStateProperty.resolveWith((states) {
//       if(states.contains(MaterialState.selected)) {
//         return Colors.blueGrey.withOpacity(.8);
//       } else {
//         return Colors.transparent;
//       }
//     }),
//   );
// }

import 'package:osta/utils/constants/exports.dart';

class DCheckBoxTheme {
  DCheckBoxTheme._();

  /// Customizable Light Text Theme
  static CheckboxThemeData lightCheckboxTheme = CheckboxThemeData(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
    checkColor: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.selected)) {
        return Colors.white;
      }
      return null; // Returning null will use the default
    }),
    fillColor: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.selected)) {
        return OColors.primaryColor500;
      } else {
        // Not selected, transparent background to show the border
        return Colors.white;
      }
    }),
    side: BorderSide(
      color: OColors.primaryColor500,
      width: 3.w,
    ),
  );

  /// Customizable Dark Text Theme
  static CheckboxThemeData darkCheckboxTheme = CheckboxThemeData(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
    checkColor: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.selected)) {
        return Colors.white;
      }
      return null; // Returning null will use the default
    }),
    fillColor: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.selected)) {
        return OColors.primaryColor500;
      } else {
        return Colors.white;
      }
    }),
    side: BorderSide(
      color: OColors.primaryColor500,
      width: 3.w,
    ),
  );
}
