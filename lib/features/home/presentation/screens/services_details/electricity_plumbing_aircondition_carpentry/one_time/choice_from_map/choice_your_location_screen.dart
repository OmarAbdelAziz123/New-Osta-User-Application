import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:osta/common/widgets/loading_two.dart';
import 'package:osta/features/home/managers/home_cubit.dart';
import 'package:osta/features/home/presentation/screens/services_details/electricity_plumbing_aircondition_carpentry/one_time/choice_from_map/lottie_widget.dart';
import 'package:osta/features/home/presentation/widgets/home/coice_your_location_widgets/component_save_this_location_for_later.dart';
import 'package:osta/features/offer/managers/offers_orders_cubit.dart';
import 'package:osta/utils/constants/exports.dart';
import 'package:osta/utils/constants/log_util.dart';
import 'package:permission_handler/permission_handler.dart';

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
  String? _previousGovernment;
  String? _previousAddress;

  String _currentAddress = '';
  String _currentGovernment = '';
  Position? _currentPosition;
  final Set<Polyline> _polylines = {};
  Polyline? _routeLine;
  final Set<Marker> _markers = {};

  LatLng? _selectedLocation;
  GoogleMapController? _mapController;
  final TextEditingController _searchController = TextEditingController();
  Completer<GoogleMapController> _controller = Completer();

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
  bool isMakeOrder = false;

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

          _currentAddress = '${placemark.name}, ${placemark.locality}, ${placemark.postalCode}, ${placemark.country}';
          _previousAddress = _currentAddress;
          _previousGovernment = _currentGovernment;
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

      /// Call updateLocationInformation with the new position
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
        _previousAddress = _currentAddress;
        _previousGovernment = _currentGovernment;
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
            _previousAddress = _currentAddress;
            _previousGovernment = _currentGovernment;
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

  Future<String> getAddressFromCoordinates(double latitude, double longitude) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);
      if (placemarks.isNotEmpty) {
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

  double centerLat = 0;
  double centerLng = 0;

  Future<LatLng> getCenterCoordinates() async {
    LatLngBounds bounds = await _mapController!.getVisibleRegion();
    centerLat = (bounds.northeast.latitude + bounds.southwest.latitude) / 2;
    centerLng = (bounds.northeast.longitude + bounds.southwest.longitude) / 2;
    String address = await getAddressFromCoordinates(centerLat, centerLng);
    String government = await getGovernmentFromAddress(address);

    setState(() {
      _currentAddress = address;
      _currentGovernment = government;
    });

    print('-----------------');
    print('Center Coordinates: $centerLat, $centerLng');
    print('Address at center: $address');
    print('-----------------');



    // updateLocationInformation();
    return LatLng(centerLat, centerLng);
  }

  String? address;
  
  void updateLocationInformation(Position newPosition) async {
    double latitude = newPosition.latitude;
    double longitude = newPosition.longitude;

    // Retrieve the address from the coordinates
    String address = await getAddressFromCoordinates(latitude, longitude);

    // Retrieve the government from the address
    String government = await getGovernmentFromAddress(address);

    setState(() {
      _previousAddress = _currentAddress;
      _previousGovernment = _currentGovernment;
    });

    print('===========================');
    print(address);
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
  bool isPinnedMoved = false;
  int checkVal = -1;

  Future<void> _onCameraMove(CameraPosition position) async {
    lastMapPosition = position.target;
    print('------=======');
    logSuccess(lastMapPosition!.latitude.toString() + " , " + lastMapPosition!.longitude.toString());
    print('------=======');
    setState(() {
      checkVal = 1;
    });
    if(checkVal == 1) {
      setState(() {
        checkVal = 2;
      });
    }
  }

  Future<void> _animateCamera(Position position)async{
    final GoogleMapController controller = await _controller.future;
    CameraPosition _cameraPosition = CameraPosition(
        target: LatLng(position.latitude, position.longitude),
        zoom: 15,
    );
    controller.animateCamera(CameraUpdate.newCameraPosition(_cameraPosition));
    setState(() {
      isPinnedMoved = true;
    });
  }

  bool showDetails = false;

  Future<bool> handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      permission = await Geolocator.requestPermission();
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
      return false;
    }
    return true;

  }


  @override
  void initState() {
    super.initState();
    _previousGovernment = _currentGovernment;
    _previousAddress = _currentAddress;

    // _getCurrentLocation();
    // handleLocationPermission().then((value) {
    //   Geolocator.getCurrentPosition().then((value) {
    //     setState(() {
    //       _animateCamera(value);
    //     });
    //   });
    // });
    // Request location permission and get the current location if permission is granted
    handleLocationPermission().then((permissionGranted) {
      if (permissionGranted) {
        _getCurrentLocation();
      } else {
        // Handle permission not granted scenario (optional)
        print("Location permission not granted");
        openLocationSettings();
      }
    });
    /// Add listener to focus node
    countryFocusNode.addListener(() => setState(() => isCountryFieldFocused = countryFocusNode.hasFocus));
    cityFocusNode.addListener(() => setState(() => isCityFieldFocused = cityFocusNode.hasFocus));
    /// To Open In Open Screen
  }

  bool _isAddressOrGovernmentChanged(String newGovernment, String newAddress) {
    return newGovernment != _previousGovernment || newAddress != _previousAddress;
  }

  /// Function to open the location settings
  void openLocationSettings() async {
    await Geolocator.openLocationSettings().then((value) {
      _getCurrentLocation();
    });
  }

  @override
  Widget build(BuildContext context) {
    String? locationDesc = '';
    String? nameOfPlace = 'home';
    bool? makeStore = true;

    return Scaffold(
      body: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          if(state is MakeOrderSuccessState) {
            setState(() {
              isMakeOrder = false;
            });
            if(state.message == 'order created successfully') {
              OffersOrdersCubit.get(context).getAllOrdersByMeFunction();
              ODeviceUtils.showDialogFunction(context: context, imagePath: OImages.congratulationProfile);
              Future.delayed(const Duration(seconds: 2), () {
                // context.pushNamed(ORoutesName.navigationMenuRoute);
                context.pushNamedAndRemoveUntil(ORoutesName.navigationMenuRoute, arguments: 0, predicate: (route) => false);
              });
              ODeviceUtils.showSnackBar(context: context, message: 'Successfully', textStyle: OStyles.bodyLargeRegular, textColor: OColors.whiteColor, bgColor: OColors.success);
            }
            else {
              ODeviceUtils.showSnackBar(
                context: context,
                message: state.message!,
                textStyle: OStyles.bodyLargeRegular,
                textColor: OColors.whiteColor,
                bgColor: OColors.success,
              );
            }
          } else if (state is MakeOrderErrorState) {
            setState(() {
              isMakeOrder = false;
            });
            ODeviceUtils.showSnackBar(
              context: context,
              message: state.message!,
              textStyle: OStyles.bodyLargeRegular,
              textColor: OColors.whiteColor,
              bgColor: OColors.error,
            );
            // ODeviceUtils.showSnackBar(context: context, message: 'You have an error in Make Order', textStyle: OStyles.bodyLargeRegular, textColor: OColors.whiteColor, bgColor: OColors.error);
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
                          mapToolbarEnabled: true,
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
                          markers: const <Marker>{},
                          onTap: (LatLng position) {
                            _selectPlace(position);
                          },
                        ),

                        const Center(child: LottieWidget())
                      ],
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
      bottomSheet: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          if(state is SetValueState) {
            locationDesc = state.locationDec;
          }
          if(state is SetNameOfPlaceValueState) {
            nameOfPlace = state.nameOfPlace;
          }
          if(state is MakeStoreValueState) {
            makeStore = state.makeStore;
          }
          if(state is MakeOrderSuccessState) {

          }
          },
        builder: (context, state) {
          var countryIndexToMakeOrder = HomeCubit.get(context);
          return ShowAddNewAddressBottomSheet(
            addressName: _currentGovernment == 'Unknown Government' ? '...' : _currentGovernment,
            location: _currentAddress == 'Error retrieving address' ? '...' : _currentAddress,
            isPinChanged: showDetails,
            isSaveLocation: makeStore!,
            onSubmitted: (val) {
              locationDesc = val;
            },
            onTap:(_currentGovernment == 'Unknown Government' || _currentGovernment == '...' || _currentGovernment.isEmpty) && (_currentAddress == 'Error retrieving address' || _currentAddress == '...' || _currentAddress.isEmpty)
                ? () {}
                : showDetails
                ? () {
              setState(() {
                getCenterCoordinates();
              });
              if(!isMakeOrder) {
                if(makeStore!) {
                  isMakeOrder = true;
                  /// Is Make Edit to Location
                  if(widget.data['isEdit'] == true) {
                    logWarning(widget.data['isEdit'].toString());
                    logError(makeStore.toString() + '===========================');
                    countryIndexToMakeOrder.makeOrderFunction(
                      category: "null",
                      warrantyId: widget.data['warrantyId'] == '0' ? null : widget.data['warrantyId'],
                      serviceId: widget.data['serviceId'],
                      description: widget.data['description'],
                      subServicesIds: widget.data['subServicesIds'],
                      subServiceQuantities: widget.data['subServiceQuantities'],
                      unknownProblem: widget.data['unknownProblem'],
                      space: widget.data['space'],
                      isSpace: widget.data['isSpace'],
                      isSubServicesIds: widget.data['isSubServicesIds'],
                      isSubServiceQuantities: widget.data['isSubServiceQuantities'],
                      isWarrantyId: widget.data['isWarrantyId'],
                      locationLatitude: centerLat,
                      locationLongitude: centerLng,
                      locationDesc: locationDesc,
                      name: nameOfPlace,
                      // id: widget.data['locationId'],
                    );

                    countryIndexToMakeOrder.storeOrUpdateLocationFunction(
                      id: widget.data['locationId'],
                      name: nameOfPlace,
                      locationLatitude: centerLat,
                      locationLongitude: centerLng,
                      locationDesc: locationDesc,
                    );
                  }
                  /// Is Add New Location
                  else {
                    logWarning(widget.data['isEdit'].toString());
                    logError(makeStore.toString() + '-------------------------------');
                    countryIndexToMakeOrder.makeOrderFunction(
                      category: widget.data['category'],
                      warrantyId: widget.data['warrantyId'] == '0' ? null : widget.data['warrantyId'],
                      serviceId: widget.data['serviceId'],
                      description: widget.data['description'],
                      subServicesIds: widget.data['subServicesIds'],
                      subServiceQuantities: widget.data['subServiceQuantities'],
                      unknownProblem: widget.data['unknownProblem'],
                      space: widget.data['space'],
                      isSpace: widget.data['isSpace'],
                      isSubServicesIds: widget.data['isSubServicesIds'],
                      isSubServiceQuantities: widget.data['isSubServiceQuantities'],
                      isWarrantyId: widget.data['isWarrantyId'],
                      locationLatitude: centerLat,
                      locationLongitude: centerLng,
                      locationDesc: locationDesc,
                      name: nameOfPlace,
                      // id: widget.data['locationId'],
                    );

                    countryIndexToMakeOrder.storeOrUpdateLocationFunction(
                      // id: widget.data['locationId'],
                      name: nameOfPlace,
                      locationLatitude: centerLat,
                      locationLongitude: centerLng,
                      locationDesc: locationDesc,
                    );
                  }
                }
                else {
                  logWarning('In Make Store Location Description: $locationDesc, Make Store is $makeStore');
                  logError(makeStore.toString() + '000000000000000000000000000000000000000');
                  isMakeOrder = true;
                  countryIndexToMakeOrder.makeOrderFunction(
                    category: widget.data['category'],
                    warrantyId: widget.data['warrantyId'] == '0' ? null : widget.data['warrantyId'],
                    serviceId: widget.data['serviceId'],
                    description: widget.data['description'],
                    subServicesIds: widget.data['subServicesIds'],
                    subServiceQuantities: widget.data['subServiceQuantities'],
                    unknownProblem: widget.data['unknownProblem'],
                    space: widget.data['space'],
                    isSpace: widget.data['isSpace'],
                    isSubServicesIds: widget.data['isSubServicesIds'],
                    isSubServiceQuantities: widget.data['isSubServiceQuantities'],
                    isWarrantyId: widget.data['isWarrantyId'],
                    locationLatitude: centerLat,
                    locationLongitude: centerLng,
                    locationDesc: locationDesc,
                    name: nameOfPlace,
                    // id: widget.data['locationId'],
                  );
                }
              }
            }
            : () {
              setState(() {
                showDetails = true;
                logWarning(nameOfPlace.toString());
              });
            },
          );
        },
      ),
    );
  }
}


/// Show Address Bottom Sheet
class ShowAddNewAddressBottomSheet extends StatefulWidget {
  ShowAddNewAddressBottomSheet({super.key, required this.addressName, required this.location, required this.isPinChanged, required this.isSaveLocation, required this.onTap, required this.onSubmitted});
  final String addressName;
  final String location;
  final bool isPinChanged;
  bool isSaveLocation;
  final TextEditingController controller = TextEditingController();
  final void Function() onTap;
  final void Function(String val) onSubmitted;

  @override
  State<ShowAddNewAddressBottomSheet> createState() => _ShowAddNewAddressBottomSheetState();
}

class _ShowAddNewAddressBottomSheetState extends State<ShowAddNewAddressBottomSheet> {
  int isChecked = 0;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        color: OColors.whiteColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25.r),
          topRight: Radius.circular(25.r),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: SizedBox(
          height: widget.isPinChanged
              ? ODeviceUtils.getScreenHeight(context).h / 2.4
              : ODeviceUtils.getScreenHeight(context).h / 3.5,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Delivery location",
                      style: OStyles.bodyLargeSemiBold
                          .copyWith(color: OColors.greyScale500)),
                  SizedBox(height: 10.h),
                  Text(widget.addressName, style: OStyles.bodyLargeBold),
                  SizedBox(height: 10.h),
                  SizedBox(
                      width: 350.w,
                      child: Text(widget.location,
                          style: OStyles.bodyMediumMedium,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2)),
                  SizedBox(height: 10.h),

                  AnimatedOpacity(
                    opacity: widget.isPinChanged ? 1 : 0.0,
                    duration: const Duration(milliseconds: 550),
                    child: Visibility(
                      visible: widget.isPinChanged,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Divider(),
                          SizedBox(height: 10.h),
                          Text('Address details',
                              style: OStyles.bodyLargeBold),
                          SizedBox(height: 10.h),
                          Text("Address details will help us reach you",
                              style: OStyles.bodyLargeSemiBold
                                  .copyWith(color: OColors.greyScale500)),
                          SizedBox(height: 10.h),
                          TextFormField(
                            controller: widget.controller,
                            // onFieldSubmitted: (value) {
                            //   // value = widget.controller.text;
                            //   HomeCubit.get(context).setValueFunc(value: value);
                            // },
                            onFieldSubmitted: widget.onSubmitted,
                            decoration: InputDecoration(
                              labelText:
                              'Example: building number, villa number, apartment number',
                              labelStyle: OStyles.bodyMediumMedium
                                  .copyWith(color: OColors.greyScale400),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: .4.w,
                                  color: OColors.greyScale300,
                                ),
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: .4.w,
                                  color: OColors.greyScale300,
                                ),
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: .4.w,
                                  color: OColors.greyScale300,
                                ),
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: .4.w,
                                  color: OColors.greyScale300,
                                ),
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: .4.w,
                                  color: OColors.greyScale300,
                                ),
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 16.w, vertical: 12.h),
                            ),
                          ),
                          SizedBox(height: 20.h),
                          const Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Save this site for later",
                                  style: OStyles.bodyXLargeSemiBold),
                              // SwitchWidget(valueData: widget.isSaveLocation)
                              Switch(
                                value: widget.isSaveLocation,
                                onChanged: (bool value) {
                                  setState(() => widget.isSaveLocation = value); // Call the onChanged callback
                                  HomeCubit.get(context).setMakeStoreValueFunc(value: widget.isSaveLocation);
                                },
                                activeColor: OColors.primaryColor500,
                                activeTrackColor: OColors.primaryColor500,
                                inactiveTrackColor: OColors.greyScale200,
                                trackOutlineWidth: MaterialStateProperty.all(0.w),
                                trackColor: MaterialStateProperty.all(widget.isSaveLocation ? OColors.primaryColor500 : OColors.greyScale200),
                                trackOutlineColor: MaterialStateProperty.all(widget.isSaveLocation ? OColors.primaryColor500 : OColors.greyScale200),
                                thumbColor: MaterialStateProperty.all(OColors.whiteColor),
                                thumbIcon: MaterialStateProperty.all(Icon(Icons.circle, color: OColors.whiteColor)),
                              )
                              // SwitchWidget(onChanged: (value) {
                              //    widget.isSaveLocation = value;
                              //   HomeCubit.get(context).setMakeStoreValueFunc(value: widget.isSaveLocation);
                              // }, valueData:  widget.isSaveLocation),
                            ],
                          ),
                          SizedBox(height: 10.h),

                          SizedBox(
                            width: ODeviceUtils.getScreenWidth(context).w,
                            height: ODeviceUtils.getScreenHeight(context).h / 6,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemCount: OConstants.placesIcons.length,
                              itemBuilder: (context ,index) {
                                return SizedBox(
                                  width: ODeviceUtils.getScreenWidth(context).w / 4,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                isChecked = index;
                                              });
                                              logWarning(isChecked.toString());
                                              HomeCubit.get(context).setNameOfPlaceValueFunc(value: isChecked == 0 ? 'home' : isChecked == 1 ? 'work' : isChecked == 2 ? 'friend' : 'rest');
                                            },
                                            child: CircleAvatar(
                                              radius: 25.r,
                                              backgroundColor: isChecked == index ? OColors.primaryColor500 : OColors.greyScale100,
                                              child: SvgPicture.asset(OConstants.placesIcons[index], color: isChecked == index ? OColors.whiteColor : OColors.blackColor, width: OConstants.placesIcons[index] == OImages.homeIcon ? 42.w : 35.w, height: OConstants.placesIcons[index] == OImages.homeIcon ? 32.h : 26.h),
                                            ),
                                          ),
                                          SizedBox(height: 5.h),
                                          Text(OConstants.placesNames[index],style: OStyles.bodyMediumRegular)
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  BlocListener<HomeCubit, HomeState>(
                    listener: (context, state) {
                      if(state is MakeOrderErrorState) {
                        isLoading = false;
                        setState(() {});
                      }
                    },
                    child: ThirdButtonWidget(
                      isRejected: false,
                      widgetInButton: isLoading ? const Center(child: LoadingTwo()) : Text(widget.isPinChanged ? 'Save and continue' : 'Confirm location',
                          style: OStyles.bodyLargeBold
                              .copyWith(color: OColors.whiteColor)),
                      textStyle: OStyles.bodyLargeBold
                          .copyWith(color: OColors.whiteColor),
                      containerColor: widget.addressName == '' && widget.location == '' ? OColors.disabledButton : OColors.primaryColor500,
                      width: double.infinity,
                      height: 50.h,
                      borderRadius: 12.r,
                      onTap: () {
                        if(!isLoading) widget.onTap.call();
                        if(widget.isPinChanged) {
                          setState(() {
                            isLoading = true;
                          });
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

