import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ateam/helper/globalfunction.dart';
import 'package:ateam/helper/config.dart';
import 'package:ateam/helper/controller.dart';
import 'package:ateam/utils/colors/colors.dart';
import 'package:ateam/utils/reusable_widgets/reusable_buttons.dart';
import 'package:ateam/utils/reusable_widgets/reusable_widgets.dart';
import 'package:ateam/utils/reusable_widgets/reused_text.dart';
import 'package:ateam/utils/spacing/spacing.dart';
import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({
    super.key,
    required this.startLat,
    required this.startLong,
    required this.endLat,
    required this.endLong,
    required this.endlocation,
    required this.startlocation,
  });
  final double startLat;
  final double startLong;
  final double endLat;
  final double endLong;
  final String endlocation;
  final String startlocation;
  @override
  _NavigationScreenState createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  MapboxMapController? _mapController;
  // bool _isMapReady = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1)).then((_) {
      _drawRoute();
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: height * .35,
        automaticallyImplyLeading: false,
        backgroundColor: primaryblue,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Heading15font500(heading: "YOUR LOCATION", color: whitecolor),
            const Halfh(),
            Heading22font600(heading: widget.startlocation, color: whitecolor),
            const Halfh(),
            Row(
              children: [
                const Icon(
                  Icons.location_on,
                  color: whitecolor,
                ),
                Heading12font500(
                    heading: "${widget.startLat},${widget.startLong}",
                    color: whitecolor.withOpacity(.6)),
              ],
            ),
            CustomLine(
              width: width * .8,
              color: whitecolor,
            ),
            const Heading15font500(heading: "DESTINATION", color: whitecolor),
            const Halfh(),
            Heading22font600(heading: widget.endlocation, color: whitecolor),
            Row(
              children: [
                const Icon(
                  Icons.location_on,
                  color: whitecolor,
                ),
                Heading12font500(
                    heading: "${widget.endLat},${widget.endLong}",
                    color: whitecolor.withOpacity(.6)),
              ],
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: MapboxMap(
              accessToken: mapboxtoken,
              initialCameraPosition: CameraPosition(
                target: LatLng(
                  (widget.startLat + widget.endLat) / 2,
                  (widget.startLong + widget.endLong) / 2,
                ),
                zoom: 12.0,
              ),
              onMapCreated: (controller) {
                setState(() {
                  _mapController = controller;
                  // _isMapReady = true;
                });
              },
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: width,
              height: height * .12,
              color: primaryblue,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  NavigateButton(
                    onpressed: () {
                      saveTrip(
                          startlatitude.value,
                          startlongitude.value,
                          endlatitude.value,
                          endlongitude.value,
                          context,
                          widget.startlocation,
                          widget.endlocation);
                    },
                    buttontitle: "Save",
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void _drawRoute() async {
    List<LatLng> routeCoordinates = await _getRouteCoordinates();
    if (routeCoordinates.isNotEmpty) {
      // Draw markers at start and end points
      _mapController?.addSymbol(
        SymbolOptions(
          iconImage: 'assets/images/marker.png',
          iconSize: 1.0,
          geometry: LatLng(widget.startLat, widget.startLong),
        ),
      );
      _mapController?.addSymbol(
        SymbolOptions(
          iconImage: 'assets/images/marker.png',
          iconSize: 1.0,
          geometry: LatLng(widget.endLat, widget.endLong),
        ),
      );

      // Draw route polyline
      _mapController?.addLine(
        LineOptions(
          geometry: routeCoordinates,
          lineColor: '#ff0000',
          lineWidth: 5.0,
        ),
      );

      // Adjust camera to fit the route
      LatLngBounds bounds = _getBounds(routeCoordinates);
      _mapController?.animateCamera(
        CameraUpdate.newLatLngBounds(
          bounds,
        ),
      );
    }
  }

  LatLngBounds _getBounds(List<LatLng> routeCoordinates) {
    double minLat = routeCoordinates
        .map((coord) => coord.latitude)
        .reduce((a, b) => a < b ? a : b);
    double minLong = routeCoordinates
        .map((coord) => coord.longitude)
        .reduce((a, b) => a < b ? a : b);
    double maxLat = routeCoordinates
        .map((coord) => coord.latitude)
        .reduce((a, b) => a > b ? a : b);
    double maxLong = routeCoordinates
        .map((coord) => coord.longitude)
        .reduce((a, b) => a > b ? a : b);

    return LatLngBounds(
      southwest: LatLng(minLat, minLong),
      northeast: LatLng(maxLat, maxLong),
    );
  }

  Future<List<LatLng>> _getRouteCoordinates() async {
    String accessToken = mapboxtoken;
    String apiUrl =
        'https://api.mapbox.com/directions/v5/mapbox/driving/${widget.startLong},${widget.startLat};${widget.endLong},${widget.endLat}?steps=true&geometries=geojson&access_token=$accessToken';

    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);
        List<dynamic> routes = data['routes'];
        if (routes.isNotEmpty) {
          Map<String, dynamic> route = routes[0];
          Map<String, dynamic> geometry = route['geometry'];
          String encodedRoute = geometry['coordinates'].toString();
          List<dynamic> points = jsonDecode(encodedRoute);
          List<LatLng> coordinates =
              points.map((point) => LatLng(point[1], point[0])).toList();
          return coordinates;
        }
      }
    } catch (e) {}
    return [];
  }
}
