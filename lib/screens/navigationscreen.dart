import 'dart:math';
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

  void _drawRoute() {
    if (_mapController != null) {
      List<LatLng> route = [
        LatLng(widget.startLat, widget.startLong),
        LatLng(widget.endLat, widget.endLong),
      ];

      _mapController!.addSymbol(
        SymbolOptions(
          iconImage: 'images/marker.png',
          iconSize: 0.1,
          geometry: LatLng(widget.startLat, widget.startLong),
        ),
      );

      _mapController!.addSymbol(
        SymbolOptions(
          iconImage: 'images/marker.png',
          iconSize: 0.1,
          geometry: LatLng(widget.endLat, widget.endLong),
        ),
      );

      _mapController!.addLine(
        LineOptions(
          geometry: route,
          lineColor: '#ff0000',
          lineWidth: 5.0,
        ),
      );

      LatLngBounds bounds = LatLngBounds(
        southwest: LatLng(
          min(widget.startLat, widget.endLat),
          min(widget.startLong, widget.endLong),
        ),
        northeast: LatLng(
          max(widget.startLat, widget.endLat),
          max(widget.startLong, widget.endLong),
        ),
      );

      _mapController!.animateCamera(
        CameraUpdate.newLatLngBounds(
          bounds,
        ),
      );
    } else {}
  }
}
