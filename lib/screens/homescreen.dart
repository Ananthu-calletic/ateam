import 'dart:convert';
import 'package:ateam/helper/config.dart';
import 'package:ateam/helper/controller.dart';
import 'package:ateam/helper/places.dart';
import 'package:ateam/screens/tripListscreen.dart';
import 'package:ateam/screens/navigationscreen.dart';
import 'package:ateam/utils/colors/colors.dart';
import 'package:ateam/utils/reusable_widgets/reusable_buttons.dart';
import 'package:ateam/utils/reusable_widgets/reusable_widgets.dart';
import 'package:ateam/utils/reusable_widgets/reused_text.dart';
import 'package:ateam/utils/spacing/spacing.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _startlocationcontroller =
      TextEditingController();
  final TextEditingController _endlocationcontroller = TextEditingController();

  List<Place> _places = [];

  @override
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: whitecolor,
      body: SingleChildScrollView(
        child: SizedBox(
          height: height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const TopHeaderSection(),
              Container(
                width: width * .8,
                height: _places.isEmpty ? height * .07 : height * .3,
                decoration: BoxDecoration(
                    border: Border.all(color: primaryblue, width: .3),
                    color: whitecolor,
                    borderRadius: BorderRadius.circular(12)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.location_on),
                        const Threew(),
                        SizedBox(
                          height: height * .06,
                          width: width * .6,
                          child: TextField(
                            cursorColor: blackcolor,
                            controller: _startlocationcontroller,
                            onChanged: (_) {
                              searchPlace(_startlocationcontroller.text);
                            },
                            decoration: InputDecoration(
                              fillColor: whitecolor,
                              filled: true,
                              hintText: "Start location",
                              contentPadding: const EdgeInsets.only(
                                  left: 20, top: 8, bottom: 8),
                              hintStyle: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey,
                                fontFamily: 'Gilroy',
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                    color: Colors.grey, width: 1),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                    color: Colors.grey, width: 1),
                              ),
                            ),
                            style: const TextStyle(
                              fontSize: 13.0,
                              fontFamily: 'Gilroy',
                              height: 1,
                              fontWeight: FontWeight.w400,
                              color: blackcolor,
                            ),
                            // maxLines: maxLines,
                          ),
                        )
                      ],
                    ),
                    _places.isEmpty
                        ? const SizedBox()
                        : SizedBox(
                            height: height * .23,
                            child: ListView.builder(
                              itemCount: _places.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  title: Heading12font500(
                                    heading: _places[index].placeName,
                                    color: blackcolor,
                                  ),
                                  onTap: () {
                                    _startlocationcontroller.text =
                                        _places[index].placeName;
                                    startlatitude.value =
                                        _places[index].latitude;
                                    startlongitude.value =
                                        _places[index].longitude;
                                    setState(() {
                                      _places.clear();
                                    });
                                  },
                                );
                              },
                            ),
                          ),
                  ],
                ),
              ),
              Container(
                width: width * .8,
                height: _places.isEmpty ? height * .07 : height * .3,
                decoration: BoxDecoration(
                    border: Border.all(color: primaryblue, width: .3),
                    color: whitecolor,
                    borderRadius: BorderRadius.circular(12)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.location_on),
                        const Threew(),
                        SizedBox(
                          height: height * .06,
                          width: width * .6,
                          child: TextField(
                            cursorColor: blackcolor,
                            controller: _endlocationcontroller,
                            onChanged: (_) {
                              searchPlace(_endlocationcontroller.text);
                            },
                            decoration: InputDecoration(
                              fillColor: whitecolor,
                              filled: true,
                              hintText: "End location",
                              contentPadding: const EdgeInsets.only(
                                  left: 20, top: 8, bottom: 8),
                              hintStyle: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey,
                                fontFamily: 'Gilroy',
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                    color: Colors.grey, width: 1),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                    color: Colors.grey, width: 1),
                              ),
                            ),
                            style: const TextStyle(
                              fontSize: 13.0,
                              fontFamily: 'Gilroy',
                              height: 1,
                              fontWeight: FontWeight.w400,
                              color: blackcolor,
                            ),
                            // maxLines: maxLines,
                          ),
                        )
                      ],
                    ),
                    _places.isEmpty
                        ? const SizedBox()
                        : SizedBox(
                            height: height * .23,
                            child: ListView.builder(
                              itemCount: _places.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  title: Heading12font500(
                                    heading: _places[index].placeName,
                                    color: blackcolor,
                                  ),
                                  onTap: () {
                                    _endlocationcontroller.text =
                                        _places[index].placeName;

                                    endlatitude.value = _places[index].latitude;
                                    endlongitude.value =
                                        _places[index].longitude;
                                    setState(() {
                                      _places.clear();
                                    });
                                  },
                                );
                              },
                            ),
                          ),
                  ],
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
                          Get.to(() => NavigationScreen(
                                startLat: startlatitude.value,
                                startLong: startlongitude.value,
                                endLat: endlatitude.value,
                                endLong: endlongitude.value,
                                startlocation: _startlocationcontroller.text,
                                endlocation: _endlocationcontroller.text,
                              ));
                        },
                        buttontitle: "Navigate",
                      ),
                      NavigateButton(
                        onpressed: () {
                          Get.to(() => const TripListScreen());
                        },
                        buttontitle: "Saved",
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void searchPlace(String query) async {
    List<Place> places = [];

    String apiKey = mapboxtoken;
    String endpoint =
        'https://api.mapbox.com/geocoding/v5/mapbox.places/$query.json?access_token=$apiKey';

    var response = await http.get(Uri.parse(endpoint));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      places.clear();
      setState(() {
        _places.clear();
        if (data['features'] != null) {
          _places = List<Place>.from(
              data['features'].map((place) => Place.fromJson(place)));
        }
      });
    } else {
      print('Failed to fetch data: ${response.statusCode}');
    }
  }
}
