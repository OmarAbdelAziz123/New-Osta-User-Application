import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:osta_user_app/features/home/managers/home_cubit.dart';
import 'package:osta_user_app/features/home/presentation/screens/services_details/electricity_plumbing_aircondition_carpentry/one_time/choice_from_map/lottie_widget.dart';
import 'package:osta_user_app/features/offer/managers/offers_orders_cubit.dart';
import 'package:osta_user_app/utils/constants/exports.dart';
import 'package:osta_user_app/utils/constants/log_util.dart';

extension LatLngExtension on Position {
  LatLng toLatLng() {
    return LatLng(latitude, longitude);
  }
}

class ChoiceYourLocationScreen extends StatefulWidget {
  const ChoiceYourLocationScreen({super.key, required this.data});

  final Map data;

  @override
  State<ChoiceYourLocationScreen> createState() => _ChoiceYourLocationScreenState();
}

class _ChoiceYourLocationScreenState extends State<ChoiceYourLocationScreen> {
  String _currentAddress = '';
  Position? _currentPosition;
  final Set<Polyline> _polylines = {};
  Polyline? _routeLine;
  final Set<Marker> _markers = {};

  LatLng? _selectedLocation;
  GoogleMapController? _mapController;
  final TextEditingController _searchController = TextEditingController();


  TextEditingController countryController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  final FocusNode countryFocusNode = FocusNode();
  final FocusNode cityFocusNode = FocusNode();

  bool isCountryFieldFocused = false;
  bool isCityFieldFocused = false;

  String selectCountry = 'Select Country';
  String selectCity = 'Select City';

  List<String> uniqueCountries = [];

  List<String> uniqueCities = [];

  int? idSelectedForCountry;
  int? idSelectedForCity;

  bool isAddLocation = false;
  bool isChecked = false;
  int selectedAddress = 0;



  @override
  void dispose() {
    _mapController?.dispose();
    _searchController.dispose();
    /// Clean up the focus node and controller when the widget is disposed.
    countryFocusNode.dispose();
    cityFocusNode.dispose();
    countryController.dispose();
    cityController.dispose();
    super.dispose();
  }

  // Future<void> _getCurrentLocation() async {
  //   try {
  //     LocationPermission permission = await Geolocator.requestPermission();
  //     if (permission == LocationPermission.denied) {
  //       // Handle denied permission
  //       return;
  //     }
  //
  //     Position position = await Geolocator.getCurrentPosition(
  //       desiredAccuracy: LocationAccuracy.high,
  //     );
  //
  //     setState(() {
  //       _currentPosition = position;
  //     });
  //
  //     List<Placemark> placemarks = await placemarkFromCoordinates(
  //       position.latitude,
  //       position.longitude,
  //     );
  //
  //     if (placemarks.isNotEmpty) {
  //       Placemark placemark = placemarks.first;
  //       setState(() {
  //         _currentAddress =
  //         '${placemark.name}, ${placemark.locality}, ${placemark.postalCode}, ${placemark.country}';
  //       });
  //     }
  //
  //     _mapController?.animateCamera(
  //       CameraUpdate.newCameraPosition(
  //         CameraPosition(
  //           target: LatLng(position.latitude, position.longitude),
  //           zoom: 15.0,
  //         ),
  //       ),
  //     );
  //   } catch (e) {
  //     print(e.toString());
  //   }
  // }
  Future<void> _getCurrentLocation() async {
    try {
      LocationPermission permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Handle denied permission
        return;
      }

      Position newPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      setState(() {
        _currentPosition = newPosition;
      });

      List<Placemark> placemarks = await placemarkFromCoordinates(
        newPosition.latitude,
        newPosition.longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark placemark = placemarks.first;
        setState(() {
          _currentAddress =
          '${placemark.name}, ${placemark.locality}, ${placemark.postalCode}, ${placemark.country}';
        });
      }

      _mapController?.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(newPosition.latitude, newPosition.longitude),
            zoom: 15.0,
          ),
        ),
      );

      // Call updateLocationInformation with the new position
      updateLocationInformation(newPosition);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _selectPlace(LatLng position) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );

    if (placemarks.isNotEmpty) {
      Placemark placemark = placemarks.first;
      setState(() {
        _currentAddress =
        '${placemark.name}, ${placemark.locality}, ${placemark.postalCode}, ${placemark.country}';
        _selectedLocation = position;
      });
    }
  }

  void _goToCurrentLocation() {
    if (_currentPosition != null && _mapController != null) {
      _mapController!.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(
              _currentPosition!.latitude,
              _currentPosition!.longitude,
            ),
            zoom: 15.0,
          ),
        ),
      );
    }
  }

  Future<void> _searchPlace(String searchTerm) async {
    try {
      List<Location> locations =
      await GeocodingPlatform.instance!.locationFromAddress(searchTerm);
      if (locations.isNotEmpty) {
        Location location = locations.first;
        List<Placemark> placemarks =
        await GeocodingPlatform.instance!.placemarkFromCoordinates(
          location.latitude,
          location.longitude,
        );
        if (placemarks.isNotEmpty) {
          Placemark placemark = placemarks.first;
          LatLng destination = LatLng(location.latitude, location.longitude);
          _drawRoute(_currentPosition!.toLatLng(), destination);

          _mapController?.animateCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(
                target: destination,
                zoom: 15.0,
              ),
            ),
          );
          setState(() {
            _selectedLocation = destination;
            _currentAddress = placemark.street! +
                placemark.locality! +
                ', ' +
                placemark.administrativeArea! +
                ', ' +
                placemark.country!;
            _markers.clear();
            _markers.add(
              Marker(
                markerId: const MarkerId('selectedLocation'),
                position: _selectedLocation!,
                infoWindow: const InfoWindow(
                  title: 'Select Location',
                ),
              ),
            );
            _drawRoute(_currentPosition!.toLatLng(), destination);
          });
        }
      } else {
        setState(() {
          _selectedLocation = null;
          _currentAddress = 'No location found';
          _markers.clear();
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }

  void _drawRoute(LatLng origin, LatLng destination) {
    setState(() {
      _polylines.clear();
      _routeLine = Polyline(
        polylineId: const PolylineId('routeLine'),
        color: Colors.blue,
        width: 4,
        points: [origin, destination],
      );
      _polylines.add(_routeLine!);
    });
  }

  void _clearSearch() {
    _searchController.clear();
    setState(() {
      _getCurrentLocation();
      _selectedLocation = null;
      _currentAddress = '';
      _markers.clear();
      _polylines.clear();
    });
  }

  refreshLists() async {
    await HomeCubit.get(context).getAllAddressesFunction();
  }

  Future<String> getAddressFromCoordinates(double latitude, double longitude) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);
      if (placemarks != null && placemarks.isNotEmpty) {
        Placemark placemark = placemarks[0];
        return '${placemark.name}, ${placemark.locality}, ${placemark.administrativeArea}, ${placemark.country}';
      } else {
        return 'Address not found';
      }
    } catch (e) {
      print("Error: $e");
      return 'Error retrieving address';
    }
  }

  Future<LatLng> getCenterCoordinates() async {
    LatLngBounds bounds = await _mapController!.getVisibleRegion();
    double centerLat = (bounds.northeast.latitude + bounds.southwest.latitude) / 2;
    double centerLng = (bounds.northeast.longitude + bounds.southwest.longitude) / 2;
    String address = await getAddressFromCoordinates(centerLat, centerLng);

    print('-----------------');
    print('Center Coordinates: $centerLat, $centerLng');
    print('Address at center: $address');
    print('-----------------');



    // updateLocationInformation();
    return LatLng(centerLat, centerLng);
  }

  void _printCenterCoordinates() async {
    LatLng center = await getCenterCoordinates();
    print('Center Coordinates: ${center.latitude}, ${center.longitude}');
  }
  
  void updateLocationInformation(Position newPosition) async {
    if (newPosition != null) {
      double latitude = newPosition.latitude;
      double longitude = newPosition.longitude;

      // Retrieve the address from the coordinates
      String address = await getAddressFromCoordinates(latitude, longitude);

      // Retrieve the government from the address
      String government = await getGovernmentFromAddress(address);

      print('===========================');
      print(address);

      showLocationBottomSheet(
        context: context,
        addressName: government,
        location: address,
      );
      /// Show the bottom sheet with the government and address
      // showDraggable(
      //   context: context,
      //   addressName: government,
      //   location: address,
      // );
    }
  }

  Future<String> getGovernmentFromAddress(String address) async {
    List<String> addressParts = address.split(','); // Split the address by commas
    if (addressParts.length >= 3) {
      return addressParts[2].trim(); // Return the third part (index 2) as the government
    } else {
      return 'Unknown Government'; // Return a default value if the format doesn't match
    }
  }

  LatLng? lastMapPosition;
  
  void _onCameraMove(CameraPosition position) {
    lastMapPosition = position.target;
    print('------=======');
    logSuccess(lastMapPosition!.latitude.toString() + " , " + lastMapPosition!.longitude.toString());
    print('------=======');
  }
  
  



  @override
  void initState() {
    // print(HomeCubit.get(context).getAllAddressesModel.result!.length);
    super.initState();
    refreshLists();
    /// Add listener to focus node
    countryFocusNode.addListener(() => setState(() => isCountryFieldFocused = countryFocusNode.hasFocus));
    cityFocusNode.addListener(() => setState(() => isCityFieldFocused = cityFocusNode.hasFocus));
    _getCurrentLocation();
    /// To Open In Open Screen
    // _goToCurrentLocation();
    // WidgetsBinding.instance.addPostFrameCallback((_) async {
    //   if (_currentPosition != null) {
    //     double latitude = _currentPosition!.latitude;
    //     double longitude = _currentPosition!.longitude;
    //
    //     String address = await getAddressFromCoordinates(latitude, longitude);
    //
    //     print('===========================');
    //     print(address);
    //
    //     showLocationBottomSheet(
    //       context: context,
    //       addressName: 'Current Location',
    //       location: '$latitude, $longitude',
    //     );
    //   }
    // });

    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   showLocationBottomSheet(context: context, addressName: '....', location: '....');
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          if(state is MakeOrderSuccessState) {
            OffersOrdersCubit.get(context).getAllOrdersByMeFunction();
            context.pushNamedAndRemoveUntil(ORoutesName.navigationMenuRoute, predicate: (route) => false);
            ODeviceUtils.showSnackBar(context: context, message: 'Successfully', textStyle: OStyles.bodyLargeRegular, textColor: OColors.whiteColor, bgColor: OColors.success);
          } else if (state is MakeOrderErrorState) {
            ODeviceUtils.showSnackBar(context: context, message: 'You have an error in Make Order', textStyle: OStyles.bodyLargeRegular, textColor: OColors.whiteColor, bgColor: OColors.error);
          } if(state is AddDataForNewAddressesSuccessState) {
            setState(() {});
          }
        },
        builder: (context, state) {
          var countryIndexToMakeOrder = HomeCubit.get(context);

          uniqueCountries = countryIndexToMakeOrder.countries.toSet().toList();

          if (!uniqueCountries.contains(selectCountry)) {
            uniqueCountries.insert(0, selectCountry);
          }

          uniqueCities = countryIndexToMakeOrder.cities.toSet().toList();

          if (!uniqueCities.contains(selectCity)) {
            uniqueCities.insert(0, selectCity);
          }

          // return Padding(
          //   padding: EdgeInsets.only(left: 24.w, right: 24.w, top: 68.h),
          //   child: Column(
          //     children: [
                /// App Bar
                // AppBarWidget(leading: InkWellWidget(onTap: () => context.pop(), child: const Icon((Icons.arrow_back))), title: 'My Location', actions: SvgPicture.asset(OImages.moreIcon2), widthOfText: 280.w),
          //
          //       /// Make Space
          //       SizedBox(height: 24.h),
          //
          //       RefreshIndicator(
          //         onRefresh: () async {
          //           await countryIndexToMakeOrder.getAllAddressesFunction();
          //         },
          //         child: Column(
          //           children: [
          //             SizedBox(
          //               height: 41.h,
          //               width: double.infinity,
          //               child: Column(
          //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //                 children: [
          //                   Text('Choice Location for you', style: OStyles.bodyXLargeSemiBold.copyWith(color: OColors.primaryColor500)),
          //                   Container(
          //                     height: 4.h,
          //                     width: double.infinity,
          //                     decoration: BoxDecoration(
          //                       color: OColors.primaryColor500,
          //                       borderRadius: BorderRadius.circular(100.r),
          //                     ),
          //                   ),
          //                 ],
          //               ),
          //             ),
          //
          //             /// Make Space
          //             SizedBox(height: 34.h),
          //
          //
          //
          //             // Column(
          //             //   children: [
          //             //     InkWellWidget(
          //             //       onTap: () {
          //             //         context.pushNamed(ORoutesName.addDataForNewAddressRoute);
          //             //       },
          //             //       child: Container(
          //             //         padding: EdgeInsets.symmetric(vertical: 16.h),
          //             //         decoration: BoxDecoration(
          //             //           color: OColors.greyScale100,
          //             //           borderRadius: BorderRadius.circular(12.r),
          //             //         ),
          //             //         child: Row(
          //             //           mainAxisAlignment: MainAxisAlignment.center,
          //             //           children: [
          //             //             Text('Add Location For You', style: OStyles.bodyXLargeSemiBold),
          //             //             /// Make Space
          //             //             SizedBox(width: 14.h),
          //             //             SvgPicture.asset(OImages.addNewAddress),
          //             //           ],
          //             //         ),
          //             //       ),
          //             //     ),
          //             //
          //             //     /// Make Space
          //             //     SizedBox(height: 24.h),
          //             //
          //             //     /// Add Location For You
          //             //     AnimatedOpacity(
          //             //       duration: const Duration(milliseconds: 300),
          //             //       opacity: isAddLocation ? 1.0 : 0.0,
          //             //       child: isAddLocation
          //             //           ? Column(
          //             //         children: [
          //             //           /// County
          //             //           DropDownWidget(
          //             //             selectedItem: selectCountry,
          //             //             items: uniqueCountries,
          //             //             isInFillProfile: true,
          //             //             onItemSelected: (selected) {
          //             //               idSelectedForCountry = countryIndexToMakeOrder.countryNameToIdMap[selected];
          //             //               HomeCubit.get(context).getAllCitiesFunction(countryId: idSelectedForCountry!);
          //             //               selectCountry = selected!;
          //             //               selectCity = 'Select City';
          //             //               idSelectedForCity = 0;
          //             //             },
          //             //           ),
          //             //
          //             //           /// Make Space
          //             //           SizedBox(height: 20.h),
          //             //
          //             //           /// City
          //             //           Row(
          //             //             children: [
          //             //               Expanded(
          //             //                 child: DropDownWidget(
          //             //                   selectedItem: selectCity,
          //             //                   items: uniqueCities,
          //             //                   isInFillProfile: true,
          //             //                   onItemSelected: (selected) {
          //             //                     selectCity = selected!;
          //             //                     idSelectedForCity = countryIndexToMakeOrder.cityNameToIdMap[selected];
          //             //                     log('Selected Country ID: $idSelectedForCountry');
          //             //                     log('Selected Country NAME: $selectCountry');
          //             //                     log('Selected City ID: $idSelectedForCity');
          //             //                     log('Selected City NAME: $selectCity');
          //             //                   },
          //             //                 ),
          //             //               ),
          //             //               state is CityIndexLoadingState
          //             //                   ? LoadingWidget(iconColor: OColors.primaryColor500)
          //             //                   : Lottie.asset(OImages.successImage, width: 50.w),
          //             //             ],
          //             //           ),
          //             //         ],
          //             //       )
          //             //           : const SizedBox(),
          //             //     ),
          //             //
          //             //     /// Make Space
          //             //     SizedBox(height: 34.h),
          //             //
          //             //     Divider(thickness: .5.w),
          //             //
          //             //     /// Make Space
          //             //     SizedBox(height: 24.h),
          //             //
          //             //     Column(
          //             //       crossAxisAlignment: CrossAxisAlignment.start,
          //             //       children: [
          //             //         Row(
          //             //           children: [
          //             //             Text('Your Addresses', style: OStyles.bodyXLargeSemiBold),
          //             //           ],
          //             //         ),
          //             //
          //             //         countryIndexToMakeOrder.getAllAddressesModel == null || countryIndexToMakeOrder.getAllAddressesModel.result == null ?
          //             //         LoadingWidget(iconColor: OColors.primaryColor500)
          //             //             : countryIndexToMakeOrder.getAllAddressesModel.result!.isEmpty ?
          //             //         Container(
          //             //           padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 20.w),
          //             //           margin: EdgeInsets.symmetric(vertical: 24.h),
          //             //           decoration: BoxDecoration(
          //             //             color: OColors.greyScale100,
          //             //             borderRadius: BorderRadius.circular(12.r),
          //             //           ),
          //             //           child: Row(
          //             //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //             //             children: [
          //             //               SizedBox(
          //             //                 width: ODeviceUtils.getScreenHeight(context)/3.5,
          //             //                 child: Text('Don\'t have any Addresses yet', style: OStyles.bodyLargeRegular),
          //             //               ),
          //             //             ],
          //             //           ),
          //             //         )
          //             //             : SizedBox(
          //             //           width: double.infinity,
          //             //           height: ODeviceUtils.getScreenHeight(context)/3,
          //             //           // color: Colors.red,
          //             //           child: ListView.builder(
          //             //             shrinkWrap: true,
          //             //             itemCount: countryIndexToMakeOrder.getAllAddressesModel.result!.length,
          //             //             itemBuilder: (context, index) {
          //             //               var addressesList = countryIndexToMakeOrder.getAllAddressesModel.result;
          //             //
          //             //
          //             //               return Column(
          //             //                 children: [
          //             //                   InkWellWidget(
          //             //                       onTap: () {
          //             //                         setState(() {
          //             //                           selectedAddress = index+1;
          //             //                         });
          //             //                         print(selectedAddress);
          //             //                       },
          //             //                       child: Container(
          //             //                         padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 20.w),
          //             //                         decoration: BoxDecoration(
          //             //                           color: OColors.greyScale100,
          //             //                           borderRadius: BorderRadius.circular(12.r),
          //             //                           border: Border.all(
          //             //                             color: selectedAddress == index+1 ? OColors.primaryColor500 : Colors.transparent,
          //             //                           ),
          //             //                         ),
          //             //                         child: Row(
          //             //                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //             //                           children: [
          //             //                             SizedBox(
          //             //                               width: ODeviceUtils.getScreenHeight(context)/3.5,
          //             //                               child: Text('${addressesList![index].apartmentNumber!}, ${addressesList![index].floorNumber}, ${addressesList![index].name!}, ${addressesList![index].street}, ${addressesList![index].city!.name!}', style: OStyles.bodyLargeRegular),
          //             //                             ),
          //             //                             /// Make Space
          //             //                             SizedBox(width: 14.h),
          //             //                             SvgPicture.asset(OImages.addressIcon, color: OColors.blackColor, width: 20.w),
          //             //                           ],
          //             //                         ),
          //             //                       )),
          //             //
          //             //                   /// Make Space
          //             //                   SizedBox(height: 24.h),
          //             //
          //             //                   Row(
          //             //                     mainAxisAlignment: MainAxisAlignment.center,
          //             //                     children: [
          //             //                       InkWellWidget(
          //             //                         onTap: () {},
          //             //                         child: SvgPicture.asset(OImages.deleteIcon),
          //             //                       ),
          //             //                     ],
          //             //                   ),
          //             //
          //             //                   /// Make Space
          //             //                   SizedBox(height: 24.h),
          //             //                 ],
          //             //               );
          //             //               // return AddressesWidget(
          //             //               //   addressText: '${addressesList![index].apartmentNumber!}, ${addressesList![index].floorNumber}, ${addressesList![index].name!}, ${addressesList![index].street}, ${addressesList![index].city!.name!}',
          //             //               //   onTap: () {
          //             //               //
          //             //               //   },
          //             //               // );
          //             //             },
          //             //           ),
          //             //         ),
          //             //
          //             //         // InkWellWidget(
          //             //         //   onTap: () {},
          //             //         //   child:
          //             //         // ),
          //             //         //
          //             //         // /// Make Space
          //             //         // SizedBox(height: 24.h),
          //             //         //
          //             //         // Row(
          //             //         //   mainAxisAlignment: MainAxisAlignment.center,
          //             //         //   children: [
          //             //         //     InkWellWidget(
          //             //         //       onTap: () {},
          //             //         //       child: SvgPicture.asset(OImages.deleteIcon),
          //             //         //     ),
          //             //         //   ],
          //             //         // ),
          //             //
          //             //         /// Make Space
          //             //         SizedBox(height: 34.h),
          //             //
          //             //
          //             //         ContinueButtonInBottomWidget(
          //             //           onTap: () {
          //             //             // print(selectedAddress);
          //             //             countryIndexToMakeOrder.makeOrderFunction(
          //             //               category: widget.data['category'],
          //             //               warrantyId: widget.data['warrantyId'],
          //             //               serviceId: widget.data['serviceId'],
          //             //               locationId: selectedAddress,
          //             //               isSpace: widget.data['isSpace'],
          //             //               isSubServicesIds: widget.data['isSubServicesIds'],
          //             //               isSubServiceQuantities: widget.data['isSubServiceQuantities'],
          //             //               isWarrantyId: widget.data['isWarrantyId'],
          //             //               description: widget.data['description'],
          //             //               subServiceQuantities: widget.data['isSubServiceQuantities'] == false ? [] :  widget.data['subServiceQuantities'],
          //             //               subServicesIds: widget.data['isSubServicesIds'] == false ? [] : widget.data['subServicesIds'],
          //             //               unknownProblem: widget.data['unknownProblem'],
          //             //               space: widget.data['space'],
          //             //             );
          //             //           },
          //             //           centerWidget: state is MakeOrderLoadingState ? Padding(padding: EdgeInsets.all(3.sp), child: LoadingWidget(iconColor: OColors.whiteColor)) : Text('Continue', style: OStyles.bodyLargeBold.copyWith(color: OColors.whiteColor)),
          //             //         ),
          //             //
          //             //       ],
          //             //     ),
          //             //
          //             //   ],
          //             // ),
          //           ],
          //         ),
          //       )
          //     ],
          //   ),
          // );
          return Stack(
            children: [
              Column(
                children: [
                  /// App Bar
                  Padding(
                    padding: EdgeInsets.only(left: 24.w, right: 24.w, top: ODeviceUtils.getScreenHeight(context).h/16),
                    child: AppBarWidget(leading: InkWellWidget(onTap: () => context.pop(), child: const Icon((Icons.arrow_back))), title: 'My Location', actions: SvgPicture.asset(OImages.moreIcon2), widthOfText: 280.w),
                  ),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                    child: TextFormFieldWidget(
                      controller: _searchController,
                      textInputType: TextInputType.name,
                      focusNode: FocusNode(),
                      hintText: 'Search For Location',
                      hintColor: OColors.greyScale500,
                      fillColor:  OColors.greyScale50,
                      borderSide: BorderSide.none,
                      obscureText: false,
                      suffixIcon: IconButton(
                        onPressed: _clearSearch,
                        icon: const Icon(
                          Icons.close,
                        ),
                      ),
                      prefixIcon: IconButton(
                        onPressed: () {
                          String searchTerm = _searchController.text;
                          _searchPlace(searchTerm);
                        },
                        icon: Icon(Icons.search, size: 28.sp),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Stack(
                      children: [
                        GoogleMap(
                          onMapCreated: (controller) {
                            setState(() {
                              _mapController = controller;
                            });
                          },
                          onCameraIdle: getCenterCoordinates,
                          onCameraMove: _onCameraMove,
                          initialCameraPosition: const CameraPosition(
                            target: LatLng(0, 0),
                          ),
                          markers: const <Marker>{
                            // if (_currentPosition != null)
                            // Marker(
                            //   markerId: const MarkerId('currentLocation'),
                            //   position: LatLng(
                            //     _currentPosition!.latitude,
                            //     _currentPosition!.longitude,
                            //   ),
                            // ),
                            // if (_selectedLocation != null)
                            // Marker(
                            //   markerId: const MarkerId('selectedLocation'),
                            //   position: _selectedLocation!,
                            //   icon: BitmapDescriptor.defaultMarkerWithHue(
                            //       BitmapDescriptor.hueOrange),
                            // ),
                          },
                          onTap: (LatLng position) {
                            _selectPlace(position);
                          },
                        ),


                        if (_selectedLocation != null)
                          Positioned(
                            top: 16.0,
                            right: 16.0,
                            child: Container(
                              padding: EdgeInsets.all(1.sp),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50.r),
                                color: OColors.primaryColor500.withOpacity(0.8),
                              ),
                              child: IconButton(
                                onPressed: _goToCurrentLocation,
                                icon: Icon(
                                  Icons.location_searching,
                                  color: OColors.whiteColor,
                                  size: 20.sp,
                                ),
                              ),
                            ),
                          ),


                        const Center(
                          child: LottieWidget(),
                        )
                      ],
                    ),
                  ),
                  // _selectedLocation == null
                  //     ? Container()
                  //     : Positioned(
                  //   left: 20,
                  //   bottom: 20,
                  //   child: ThirdButtonWidget(
                  //     isRejected: false,
                  //     widgetInButton: const Text('Done'),
                  //     textStyle: const TextStyle(),
                  //     containerColor: OColors.primaryColor500,
                  //     width: double.infinity,
                  //     height: 40.h,
                  //     borderRadius: 10.r,
                  //     onTap: () {
                  //
                  //     },
                  //   ),
                  // ),
                  ////////////////////////////////////////////////////////////////
                  // _selectedLocation == null
                  //     ? Container()
                  //     : Container(
                  //   padding: EdgeInsets.all(16.sp),
                  //   decoration: BoxDecoration(
                  //     border: Border.all(
                  //       color: OColors.primaryColor500,
                  //     ),
                  //     borderRadius: BorderRadius.circular(8.r),
                  //   ),
                  //   child: Column(
                  //     children: [
                  //       const Row(
                  //         children: [
                  //           Text(
                  //             'Current Location',
                  //           ),
                  //         ],
                  //       ),
                  //       Row(
                  //         children: [
                  //           Text(
                  //             _currentPosition != null
                  //                 ? 'Latitude: ${_currentPosition!.latitude}, Longitude: ${_currentPosition!.longitude}'
                  //                 : 'Getting current location...',
                  //             textAlign: TextAlign.center,
                  //           ),
                  //         ],
                  //       ),
                  //       SizedBox(height: 20.h),
                  //       const Row(
                  //         children: [
                  //           Text(
                  //               'Lat & lng: '
                  //           ),
                  //         ],
                  //       ),
                  //       Row(
                  //         children: [
                  //           Text(
                  //             '${_selectedLocation?.latitude ?? ''}, ${_selectedLocation?.longitude ?? ''}',
                  //           ),
                  //         ],
                  //       ),
                  //       const Row(
                  //         children: [
                  //           Text(
                  //               'Address: '
                  //           ),
                  //         ],
                  //       ),
                  //       Row(
                  //         children: [
                  //           Expanded(
                  //             child: Text(
                  //               _currentAddress,
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //     ],
                  //   ),
                  // ),


                ],
              ),

              // showDraggable(context: context, addressName: 'Cairo', location: 'Cairo'),
            ],
          );
        },
      ),
    );
  }

  Widget showDraggable({required BuildContext context, required String addressName, required String location}) {
    return DraggableScrollableSheet(
      initialChildSize: .3,
      minChildSize: .1,
      maxChildSize: .7,
      builder: (context, scrollController) {
        return ShowAddNewAddressBottomSheet(addressName: addressName, location: location);
      },
    );
  }

  void showLocationBottomSheet({required BuildContext context, required String addressName, required String location}) {
    showModalBottomSheet(
      backgroundColor: Colors.white,
      barrierColor: Colors.white.withOpacity(0),
      isDismissible: false,
      enableDrag: false,
      showDragHandle: false,
      context: context,
      builder: (BuildContext context) {
        // return const ShowAddNewAddressBottomSheet(addressName: "Riyadh", location: "District 6960,RAJD6960,Ahmed bin Muhammad Al-Jazari,4214,Al-Narjis, Riyadh13339, Saudi Arabia");
        return ShowAddNewAddressBottomSheet(addressName: addressName, location: location);
      },
    );
  }
}


/// Show Address Bottom Sheet
class ShowAddNewAddressBottomSheet extends StatelessWidget {
  const ShowAddNewAddressBottomSheet({super.key, required this.addressName, required this.location});
  final String addressName, location;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: OColors.whiteColor,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 20.h),
        child: SizedBox(
          height: ODeviceUtils.getScreenHeight(context).h / 3.5,
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child:  Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Delivery location",style: OStyles.bodyLargeSemiBold.copyWith(color: OColors.greyScale500)),
                  SizedBox(height: 10.h),
                  Text(addressName,style: OStyles.bodyLargeBold),
                  SizedBox(height: 10.h),
                  SizedBox(
                      width: 350.w,
                      child: Text(location,style: OStyles.bodyMediumMedium,overflow: TextOverflow.clip,)),
                  SizedBox(height: 20.h),
                  ThirdButtonWidget(
                    isRejected: false,
                    widgetInButton: Text('Confirm location', style: OStyles.bodyLargeBold.copyWith(color: OColors.whiteColor)),
                    textStyle: OStyles.bodyLargeBold.copyWith(color: OColors.whiteColor),
                    containerColor: OColors.primaryColor500,
                    width: double.infinity,
                    height: 50.h,
                    borderRadius: 12.r,
                    onTap: () {},
                  ),
                ],
              )
          ),
        ),
      ),
    );
  }
}