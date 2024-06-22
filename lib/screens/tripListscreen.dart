import 'package:ateam/helper/config.dart';
import 'package:ateam/helper/trip.dart';
import 'package:ateam/screens/navigationscreen.dart';
import 'package:ateam/utils/colors/colors.dart';
import 'package:ateam/utils/reusable_widgets/reusable_buttons.dart';
import 'package:ateam/utils/reusable_widgets/reusable_widgets.dart';
import 'package:ateam/utils/reusable_widgets/reused_text.dart';
import 'package:ateam/utils/spacing/spacing.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

class TripListScreen extends StatelessWidget {
  const TripListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
        children: [
          const TopHeaderSection(),
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: Hive.box<Trip>('trips').listenable(),
              builder: (context, Box<Trip> box, _) {
                if (box.values.isEmpty) {
                  return const Center(
                    child: Text('No trips added yet.'),
                  );
                }

                return ListView.builder(
                  itemCount: box.length,
                  itemBuilder: (context, index) {
                    final trip = box.getAt(index);
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Container(
                          width: width * .8,
                          height: height * .31,
                          decoration: BoxDecoration(
                              border: Border.all(color: primaryblue, width: .3),
                              color: whitecolor,
                              borderRadius: BorderRadius.circular(12)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Fivew(),
                                  const Icon(Icons.location_on),
                                  const Threew(),
                                  Heading15font500(
                                      heading: "Trip -${index + 1}",
                                      color: blackcolor),
                                  const Spacer(),
                                  GestureDetector(
                                    onTap: () {
                                      box.deleteAt(index);
                                    },
                                    child: const Icon(
                                      Icons.delete,
                                      size: 20,
                                      color: Colors.red,
                                    ),
                                  ),
                                  const Fivew(),
                                ],
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: SizedBox(
                                  height: height * .2,
                                  width: width * .7,
                                  child: MapboxMap(
                                    accessToken: mapboxtoken,
                                    initialCameraPosition: const CameraPosition(
                                      target: LatLng(8.5241, 76.9366),
                                      zoom: 13.0,
                                    ),
                                    onMapCreated: (controller) {},
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Get.to(() => NavigationScreen(
                                        startLat: trip!.startLat,
                                        startLong: trip.startLong,
                                        endLat: trip.endLat,
                                        endLong: trip.endLong,
                                        startlocation: trip.startlocation,
                                        endlocation: trip.endlocation,
                                      ));
                                },
                                child: const Heading15font500(
                                    heading: "View Trip", color: primaryblue),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
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
                      Navigator.pop(context);
                    },
                    buttontitle: "Go Back",
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
