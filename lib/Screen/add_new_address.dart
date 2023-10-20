import 'dart:async';
import 'package:delivery/Screen/homepage.dart';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:search_map_place_updated/search_map_place_updated.dart';
import '../Server/api_Addresses_response.dart';
import '../Utils/Ui/material_button_widgets.dart';
import '../Utils/Ui/text_form_field_widgets.dart';
import '../Utils/Ui/text_widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:geocoding/geocoding.dart';

class AddNewAddress extends StatefulWidget {
  const AddNewAddress({super.key});

  @override
  State<AddNewAddress> createState() => _AddNewAddressState();
}

class _AddNewAddressState extends State<AddNewAddress> {
  late GoogleMapController _controller;
  late Position loction;
  var lat;
  var long;
  CameraPosition? _kGooglePlex;
  int selectedOption = 1;
  String? city;
  String? street;
  String? name;
  final TextEditingController buildingNumber = TextEditingController();
  final TextEditingController apartmentNum = TextEditingController();

  Future getPer() async {
    bool services;
    LocationPermission per;
    services = await Geolocator.isLocationServiceEnabled();
    if (services == false) {
      if (!mounted) return;
      AwesomeDialog(
        context: context,
        animType: AnimType.leftSlide,
        dialogType: DialogType.info,
        btnOkOnPress: () {},
        title: "Turn on location",
        body: const Padding(
          padding: EdgeInsets.only(bottom: 15.0),
          child: TextWidgets(
            text: "Please turn on location",
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ).show();
    }
    per = await Geolocator.checkPermission();

    if (per == LocationPermission.denied) {
      per = await Geolocator.requestPermission();
      Navigator.of(context).pop();
    }
    return per;
  }

  Future<void> getLatAndLogn() async {
    loction = await Geolocator.getCurrentPosition().then((value) => value);

    lat = loction.latitude;
    long = loction.longitude;
    _kGooglePlex = CameraPosition(
      target: LatLng(lat, long),
      zoom: 15,
    );
    setState(() {});
    getAddressAndcity();
  }

  Future<void> getAddressAndcity() async {
    List<Placemark> placemarks = await placemarkFromCoordinates(lat, long);
    setState(() {
      city = placemarks[0].locality;
      street = placemarks[0].street;
      name = placemarks[0].name;
    });

  }

  Future<void> onMapCreated() async {
    LatLng latLng = LatLng(lat, long);
    _controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: latLng,
      zoom: 15,
    )));
    setState(() {});
  }

  late Set<Marker> marker = {
    Marker(
      markerId: const MarkerId('1'),
      draggable: true,
      onDragEnd: (LatLng v) {
        lat = v.latitude;
        long = v.longitude;
        getAddressAndcity();
      },
      position: LatLng(lat, long),
    )
  };

  @override
  void initState() {
    getPer();
    getLatAndLogn();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(top: 40.0),
        child: Column(
          children: [
            const Center(
                child: TextWidgets(
                    text: 'Address',
                    fontSize: 25,
                    fontWeight: FontWeight.bold)),
            const SizedBox(
              height: 10,
            ),
            Container(
              width: double.infinity,
              height: 250,
              child: _kGooglePlex == null
                  ? const Text('')
                  : GoogleMap(
                      initialCameraPosition: _kGooglePlex!,
                      markers: marker,
                      mapType: MapType.normal,
                      onMapCreated: (GoogleMapController controller) {
                        _controller = controller;
                      },
                      myLocationEnabled: true,
                    ),
            ),
            const SizedBox(
              height: 15,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SearchMapPlaceWidget(
                      bgColor: Colors.white,
                      iconColor: Colors.black,
                      placeholder: 'Search Location',
                      placeType: PlaceType.address,
                      hasClearButton: false,
                      textColor: Colors.black,
                      apiKey: 'AIzaSyC7OA_kF9duRuHHew__jN_HdYh8yq0BCtE',
                      onSelected: (Place place) async {
                        final geo = await place.geolocation;
                        _controller.animateCamera(
                            CameraUpdate.newLatLng(geo?.coordinates));
                        _controller.animateCamera(
                            CameraUpdate.newLatLngBounds(geo?.bounds, 0));
                        final center = geo!.coordinates;

                        setState(() {
                          lat = center.latitude;
                          long = center.longitude;
                          marker.add(
                            Marker(
                              draggable: true,
                              markerId: const MarkerId('1'),
                              position: center,
                              onDragEnd: (LatLng v) {
                                lat = v.latitude;
                                long = v.longitude;
                                getAddressAndcity();
                              },
                            ),
                          );
                        });
                        getAddressAndcity();
                        onMapCreated();
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: RadioListTile<int>(
                              contentPadding: EdgeInsets.zero,
                              dense: true,
                              title: const TextWidgets(
                                text: 'Home',
                                fontSize: 16,
                                color: Color(0xff8D8D8E),
                              ),
                              value: 1,
                              groupValue: selectedOption,
                              onChanged: (value) {
                                setState(() {
                                  selectedOption = value!;
                                });
                              },
                            ),
                          ),
                          Expanded(
                            child: RadioListTile<int>(
                              contentPadding: EdgeInsets.zero,
                              dense: true,
                              title: const TextWidgets(
                                text: 'Work',
                                fontSize: 16,
                                color: Color(0xff8D8D8E),
                              ),
                              value: 2,
                              groupValue: selectedOption,
                              onChanged: (value) {
                                setState(() {
                                  selectedOption = value!;
                                });
                              },
                            ),
                          ),
                          Expanded(
                            child: RadioListTile<int>(
                              contentPadding: EdgeInsets.zero,
                              dense: true,
                              title: const TextWidgets(
                                text: 'Other',
                                fontSize: 16,
                                color: Color(0xff8D8D8E),
                              ),
                              value: 3,
                              groupValue: selectedOption,
                              onChanged: (value) {
                                setState(() {
                                  selectedOption = value!;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 25, right: 25),
                      height: 200,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 10.0,
                            spreadRadius: 2.0,
                            offset: Offset(0.0, 0.0),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 12.0),
                            child: TextFormFieldWidgets(
                                readOnly: true,
                                hintText: street ?? 'StreetName',
                                enabledBorderUnderline:
                                    const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 2, //<-- SEE HERE
                                    color: Colors.black,
                                  ),
                                ),
                                focusedBorderUnderline:
                                    const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 2, //<-- SEE HERE
                                    color: Colors.black,
                                  ),
                                ),
                                hintstyle: const TextStyle(
                                  fontSize: 20,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                prefixIcon: const Icon(
                                  Icons.location_on,
                                  color: Colors.black,
                                  size: 35,
                                )),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 15.0),
                            child: TextFormFieldWidgets(
                              controller: buildingNumber,
                              enabledBorderUnderline:
                                  const UnderlineInputBorder(
                                borderSide: BorderSide(
                                  width: 2, //<-- SEE HERE
                                  color: Colors.black,
                                ),
                              ),
                              focusedBorderUnderline:
                                  const UnderlineInputBorder(
                                borderSide: BorderSide(
                                  width: 2, //<-- SEE HERE
                                  color: Colors.black,
                                ),
                              ),
                              hintText: 'Building Number',
                              hintstyle: const TextStyle(
                                fontSize: 20,
                                overflow: TextOverflow.ellipsis,
                              ),
                              prefixIcon: const Icon(
                                Icons.add_location_alt,
                                color: Colors.black,
                                size: 35,
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your BulidNumber';
                                }
                                return null;
                              },
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: TextFormFieldWidgets(
                                    readOnly: true,
                                    inputBorder: InputBorder.none,
                                    hintText: city ?? 'city',
                                    hintstyle: const TextStyle(
                                        fontSize: 20,
                                        overflow: TextOverflow.ellipsis),
                                    prefixIcon: const Icon(
                                      Icons.location_city,
                                      color: Colors.black,
                                      size: 35,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: TextFormFieldWidgets(
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your Apartment Num';
                                      }
                                      return null;
                                    },
                                    controller: apartmentNum,
                                    inputBorder: InputBorder.none,
                                    hintText: 'Apartment Num',
                                    hintstyle: const TextStyle(
                                        fontSize: 20,
                                        overflow: TextOverflow.ellipsis),
                                    prefixIcon: const Icon(
                                      Icons.numbers,
                                      color: Colors.black,
                                      size: 35,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 120,
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 10,
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.arrow_back_ios_new,
                              color: Color(0xff4B5056),
                              size: 40,
                            ),
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const HomePage()));
                            },
                          ),
                          const SizedBox(
                            width: 40,
                          ),
                          MaterialButtonWidgets(
                              onPressed: () async {
                                postDataAddresses(
                                    lat,
                                    long,
                                    selectedOption,
                                    city,
                                    street,
                                    name,
                                    buildingNumber,
                                    apartmentNum,
                                    context: context);
                              },
                              height: 60,
                              textColor: Colors.white,
                              color: const Color(0xff15CB95),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Icon(
                                    Icons.check,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  TextWidgets(
                                      text: "SAVE ADDRESS",
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ],
                              )),
                          const SizedBox(
                            width: 10,
                          ),
                          Container(
                            width: 65,
                            height: 65,
                            decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              color: Color(0xff14CB95),
                            ),
                            child: Center(
                              child: IconButton(
                                onPressed: () {
                                  onMapCreated();
                                },
                                icon: const Icon(
                                  Icons.location_on,
                                  color: Colors.white,
                                  size: 35,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
