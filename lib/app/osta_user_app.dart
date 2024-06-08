import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:osta_user_app/features/auth/managers/auth_cubit.dart';
import 'package:osta_user_app/features/booking/managers/booking_cubit.dart';
import 'package:osta_user_app/features/home/managers/home_cubit.dart';
import 'package:osta_user_app/features/map1.dart';
import 'package:osta_user_app/features/offer/managers/offers_orders_cubit.dart';
import 'package:osta_user_app/features/offer/managers/socket_cubit/socket_cubit.dart';
import 'package:osta_user_app/utils/constants/exports.dart';

class OstaUserApp extends StatelessWidget {
  const OstaUserApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(428, 926),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => AuthCubit()..getAllCountriesFunction()),
            BlocProvider(create: (context) => HomeCubit()..getAllServicesFunction()..getAllCountriesFunction()..getAllAddressesFunction()),
            BlocProvider(create: (context) => OffersOrdersCubit()..getAllOrdersByMeFunction()),
            BlocProvider(create: (context) => BookingCubit()),
            BlocProvider(create: (context) => SocketCubit()),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            // theme: OAppTheme.lightTheme,
            // darkTheme: OAppTheme.darkTheme,
            navigatorKey: navigatorKey,
            // home: LocationDetailsScreen(),
            onGenerateRoute: RouteGenerator.getRoute,
            initialRoute: ORoutesName.splashRoute,
            // initialRoute: ORoutesName.tilingAndPaintingRoute,
            // initialRoute: ORoutesName.homeAppSatelliteChannelAndSurveillanceCamerasSRoute,
          ),
        );
      },
    );
  }
}





// class MyDialog extends StatefulWidget {
//   final Map<String, bool> values;
//   final void Function(Map<String, bool>) onChanged;
//
//   MyDialog({required this.values, required this.onChanged});
//
//   @override
//   _MyDialogState createState() => _MyDialogState();
// }
//
// class _MyDialogState extends State<MyDialog> {
//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       title: const Text('Choose Service'),
//       content: SizedBox(
//         height: 400.h, // Adjust this height as necessary
//         width: 300.w, // Adjust this width as necessary
//         child: ListView(
//           children: widget.values.keys.map((String key) {
//             return CheckboxListTile(
//               title: Text(key),
//               value: widget.values[key],
//               onChanged: (bool? value) {
//                 setState(() {
//                   widget.values[key] = value!;
//                 });
//                 widget.onChanged(widget.values);
//               },
//             );
//           }).toList(),
//         ),
//       ),
//       actions: <Widget>[
//         TextButton(
//           child: const Text('Close'),
//           onPressed: () {
//             Navigator.of(context).pop();
//           },
//         ),
//         TextButton(
//           child: const Text('Ok'),
//           onPressed: () {
//             Navigator.of(context).pop();
//           },
//         ),
//       ],
//     );
//   }
// }
//
// class AuthProviderScreen extends StatefulWidget {
//   const AuthProviderScreen({Key? key}) : super(key: key);
//
//   @override
//   State<AuthProviderScreen> createState() => _AuthProviderScreenState();
// }
//
// class _AuthProviderScreenState extends State<AuthProviderScreen> {
//   Map<String, bool> values = {
//     'cleaning': false,
//     'repairing': false,
//     'painting': false,
//     'laundry': false,
//     'appliance': false,
//     'plumbing': false,
//     'shifting': false,
//     'beauty': false,
//     'vehicle': false,
//     'electronics': false,
//   };
//
//   Future<void> _showMyDialog() async {
//     Map<String, bool> valuesCopy = Map.from(values); // Make a copy of the original map
//     await showDialog<void>(
//       context: context,
//       barrierDismissible: true, // Allow dismissing by tapping outside the dialog
//       builder: (BuildContext context) {
//         return MyDialog(
//           values: valuesCopy,
//           onChanged: (newValues) {
//             setState(() {
//               values = newValues; // Update the original map with the changes
//             });
//           },
//         );
//       },
//     );
//   }
//
//
//   String? _getSelectedServicesText() {
//
//     List<String> selectedServices = values.entries
//         .where((entry) => entry.value)
//         .map((entry) => '✓ ${entry.key}')
//         .toList();
//
//     if (selectedServices.isEmpty) {
//       return null;
//     } else {
//       return selectedServices.join("\n");
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             GestureDetector(
//               onTap: _showMyDialog,
//               child: Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
//                 decoration: BoxDecoration(
//                   color: Colors.grey[200],
//                   borderRadius: BorderRadius.circular(15),
//                 ),
//                 child: Column(
//                   children: [
//                     Row(
//                       children: [
//                         Icon(Icons.design_services_outlined, color: OColors.greyScale500),
//                         SizedBox(width: 15.w),
//                         Text(
//                           'Choose Service',
//                           style: OStyles.bodyLargeRegular.copyWith(color: OColors.greyScale500),
//                         ),
//                       ],
//                     ),
//                     _getSelectedServicesText() == null ? const SizedBox() : SizedBox(height: 8.h),
//
//                     /// Checked
//                     _getSelectedServicesText() == null ? const SizedBox() : Row(
//                       children: [
//                         Text(_getSelectedServicesText()!,
//                           style: OStyles.bodyMediumSemiBold.copyWith(color: OColors.greyScale900))
//                       ],
//                     )
//                   ],
//                 )
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }