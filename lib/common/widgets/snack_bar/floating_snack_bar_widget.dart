// import 'package:floating_snackbar/floating_snackbar.dart';
// import 'package:osta_user_app/utils/constants/exports.dart';
//
// class FloatingSnackBarWidget extends StatelessWidget {
//   const FloatingSnackBarWidget({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return FloatingSnackBar(
//       message: 'Hi GeeksforGeeks, we are back',
//       context: context,
//       textColor: Colors.black,
//       textStyle: const TextStyle(color: Colors.green),
//       duration: const Duration(milliseconds: 4000),
//       backgroundColor: Color.fromARGB(255, 220, 234, 236),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:floating_snackbar/floating_snackbar.dart';
import 'package:osta_user_app/utils/constants/exports.dart'; // Assuming necessary imports

class FloatingSnackBarWidget extends StatelessWidget {
  const FloatingSnackBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // Using WidgetsBinding to show the snackbar after the build method has completed.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // FloatingSnackBar(
      //   message: 'Hi GeeksforGeeks, we are back',
      //   context: context,
      //   textColor: Colors.black,
      //   textStyle: const TextStyle(color: Colors.green),
      //   duration: const Duration(milliseconds: 4000),
      //   backgroundColor: Color.fromARGB(255, 220, 234, 236),
      // );
    });

    // Return a placeholder widget. Replace this with your actual widget tree.
    return Container(); // Placeholder widget
  }
}
