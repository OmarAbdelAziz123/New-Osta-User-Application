import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:osta/utils/constants/exports.dart';

extension LatLngExtension on Position {
  LatLng toLatLng() {
    return LatLng(this.latitude, this.longitude);
  }
}


class LocationDetailsScreen extends StatefulWidget {
  const LocationDetailsScreen({super.key});

  @override
  _LocationDetailsScreenState createState() => _LocationDetailsScreenState();
}

class _LocationDetailsScreenState extends State<LocationDetailsScreen> {
  String _currentAddress = '';
  Position? _currentPosition;
  final Set<Polyline> _polylines = {};
  Polyline? _routeLine;
  final Set<Marker> _markers = {};

  LatLng? _selectedLocation;
  GoogleMapController? _mapController;
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _mapController?.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    try {
      LocationPermission permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Handle denied permission
        return;
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      setState(() {
        _currentPosition = position;
      });

      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
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
            target: LatLng(position.latitude, position.longitude),
            zoom: 15.0,
          ),
        ),
      );
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

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: OColors.primaryColor500,
        title: const Text(
          'Choose Location',
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
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
                  initialCameraPosition: const CameraPosition(
                    target: LatLng(0, 0),
                  ),
                  markers: <Marker>{
                      if (_currentPosition != null)
                        Marker(
                          markerId: const MarkerId('currentLocation'),
                          position: LatLng(
                            _currentPosition!.latitude,
                            _currentPosition!.longitude,
                          ),
                        ),
                      if (_selectedLocation != null)
                        Marker(
                          markerId: const MarkerId('selectedLocation'),
                          position: _selectedLocation!,
                          icon: BitmapDescriptor.defaultMarkerWithHue(
                              BitmapDescriptor.hueOrange),
                        ),
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
          _selectedLocation == null
              ? Container()
              : Container(
            padding: EdgeInsets.all(16.sp),
            decoration: BoxDecoration(
              border: Border.all(
                color: OColors.primaryColor500,
              ),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Column(
              children: [
                const Row(
                  children: [
                    Text(
                      'Current Location',
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      _currentPosition != null
                          ? 'Latitude: ${_currentPosition!.latitude}, Longitude: ${_currentPosition!.longitude}'
                          : 'Getting current location...',
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                const Row(
                  children: [
                    Text(
                      'Lat & lng: '
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      '${_selectedLocation?.latitude ?? ''}, ${_selectedLocation?.longitude ?? ''}',
                    ),
                  ],
                ),
                const Row(
                  children: [
                    Text(
                      'Address: '
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        _currentAddress,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}