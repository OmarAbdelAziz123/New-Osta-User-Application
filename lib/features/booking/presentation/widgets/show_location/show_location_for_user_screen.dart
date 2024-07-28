import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:osta_user_app/utils/constants/exports.dart';

class ShowLocationForUserScreen extends StatefulWidget {
  const ShowLocationForUserScreen({super.key, required this.map});
  final Map<String, dynamic> map;

  @override
  State<ShowLocationForUserScreen> createState() => _ShowLocationForUserScreenState();
}

class _ShowLocationForUserScreenState extends State<ShowLocationForUserScreen> {
  late LatLng _initialPosition;
  LatLng? _markerPosition;

  @override
  void initState() {
    super.initState();
    // Provide default values if 'lat' or 'lng' is null
    double latitude = double.tryParse(widget.map['lat']?.toString() ?? '0.0') ?? 0.0;
    double longitude = double.tryParse(widget.map['lng']?.toString() ?? '0.0') ?? 0.0;

    _initialPosition = LatLng(latitude, longitude);
    _markerPosition = _initialPosition;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                GoogleMap(
                  mapToolbarEnabled: true,
                  initialCameraPosition: CameraPosition(
                    target: _initialPosition,
                    zoom: 14.0, // Adjust the zoom level as needed
                  ),
                  markers: {
                    Marker(
                      markerId: const MarkerId('userLocation'),
                      position: _markerPosition!,
                      draggable: true,
                      onDragEnd: (newPosition) {
                        setState(() {
                          _markerPosition = newPosition;
                        });
                      },
                    ),
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
