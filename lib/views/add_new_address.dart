import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:search_map_place_updated/search_map_place_updated.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/address_model/address_model.dart';
import 'package:geolocator/geolocator.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;
import '../services/address/post_addresses/post_addresses.dart';
import '../services/address/put_addresses/put_addresses.dart';
import '../widgets/material_button_widgets.dart';
import '../widgets/text_form_field_widgets.dart';
import '../widgets/text_widgets.dart';

class AddNewAddress extends StatefulWidget {
  const AddNewAddress({super.key});

  @override
  State<AddNewAddress> createState() => _AddNewAddressState();
}

class _AddNewAddressState extends State<AddNewAddress> {
  late GoogleMapController _controller;
  late Position loction;
  late Position loction1;
  double? lat;
  double? long;
  CameraPosition? _kGooglePlex;
  int selectedOption = 1;
  String? city;
  String? street;
  String? name;
  List? addresses;
  List? addressesType;
  final TextEditingController buildingNumber = TextEditingController();
  final TextEditingController apartmentNum = TextEditingController();

  Future fetchAddresses() async {
    SharedPreferences sharedtoken = await SharedPreferences.getInstance();
    String? token = sharedtoken.getString('token');
    final response = await http.get(
      Uri.parse('https://news.wasiljo.com/public/api/v1/user/addresses'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    final jsonRes = json.decode(response.body);
    if (response.statusCode == 200) {
      final addressList = jsonRes['data']['addresses'] as List<dynamic>;
      setState(() {
        addresses = addressList.map((json) => Address.fromJson(json)).toList();
        addressesType = addresses
            ?.where((element) =>
                element.type == 1 && selectedOption == 1 ||
                selectedOption == 2 && element.type == 2)
            .toList();
      });
      if (mounted) {
        addressesType!.isEmpty
            ? postDataAddresses(lat, long, selectedOption, city, street, name,
                buildingNumber, apartmentNum,
                context: context)
            : AwesomeDialog(
                context: context,
                animType: AnimType.leftSlide,
                dialogType: DialogType.info,
                btnOkOnPress: () {
                  PutAddresses(
                    context: context,
                    addressesType: addressesType,
                    lat: lat,
                    long: long,
                    name: name,
                    street: street,
                    buildingNumber: buildingNumber,
                    city: city,
                    apartmentNum: apartmentNum,
                  );
                },
                btnCancelOnPress: () {},
                title: selectedOption == 1
                    ? 'change Address Home'
                    : selectedOption == 2
                        ? 'change Address Work'
                        : '',
                body: TextWidgets(
                  text: selectedOption == 1
                      ? "The Home address exists. Do you want to change it?"
                      : selectedOption == 2
                          ? "The Work address exists. Do you want to change it?"
                          : "",
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  textAlign: TextAlign.center,
                ),
              ).show();
      }
    } else {
      if (mounted) {
        AwesomeDialog(
          animType: AnimType.leftSlide,
          dialogType: DialogType.error,
          btnOkOnPress: () {},
          title: 'Error',
          body: TextWidgets(
            text: '${jsonRes['error']}',
            fontSize: 18,
            fontWeight: FontWeight.bold,
            textAlign: TextAlign.center,
          ),
          context: context,
        ).show();
      }
    }
  }

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
      Get.back();
    }
    getLatAndLogn();
  }

  Future<void> getLatAndLogn() async {
    loction = await Geolocator.getCurrentPosition().then((value) => value);
    if (mounted) {
      setState(() {
        lat = loction.latitude;
        long = loction.longitude;
        _kGooglePlex = CameraPosition(
          target: LatLng(lat!, long!),
          zoom: 15,
        );
      });
    }
    getAddressAndcity();
  }

  Future<void> getAddressAndcity() async {
    List<Placemark> placemarks = await placemarkFromCoordinates(lat!, long!);
    setState(() {
      city =
          placemarks[0].locality!.isEmpty ? 'No City' : placemarks[0].locality;
      street = placemarks[0].street;
      name = placemarks[0].name;
    });
  }

  Future<void> onMapCreated() async {
    LatLng latLng = LatLng(lat!, long!);
    _controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: latLng,
      zoom: 15,
    )));
  }

  late Set<Marker> marker = {
    Marker(
      markerId: const MarkerId('1'),
      draggable: true,
      position: LatLng(lat!, long!),
      onDragEnd: (LatLng v) {
        lat = v.latitude;
        long = v.longitude;
        getAddressAndcity();
      },
    )
  };

  @override
  void initState() {
    getPer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.toNamed('/home');
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
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
                SizedBox(
                  width: double.infinity,
                  height: 250,
                  child: _kGooglePlex == null
                      ? const Text('')
                      : GoogleMap(
                          gestureRecognizers: <Factory<
                              OneSequenceGestureRecognizer>>{
                            Factory<PanGestureRecognizer>(
                                () => PanGestureRecognizer()),
                            Factory<ScaleGestureRecognizer>(
                                () => ScaleGestureRecognizer()),
                            Factory<TapGestureRecognizer>(
                                () => TapGestureRecognizer()),
                            Factory<EagerGestureRecognizer>(
                                () => EagerGestureRecognizer()),
                          },
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
                  height: 7,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SearchMapPlaceWidget(
                      bgColor: const Color(0xffE0E0E0),
                      iconColor: Colors.black,
                      placeholder: 'Search Location',
                      placeType: PlaceType.address,
                      hasClearButton: false,
                      textColor: Colors.black,
                      apiKey: 'AIzaSyC7OA_kF9duRuHHew__jN_HdYh8yq0BCtE',
                      onSelected: (Place place) async {
                        if (mounted) {
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
                        }
                      },
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 7),
                      child: Row(
                        children: [
                          RadioMenuButton(
                            value: 1,
                            groupValue: selectedOption,
                            onChanged: (value) {
                              setState(() {
                                selectedOption = value!;
                              });
                            },
                            child: const TextWidgets(
                              text: 'Home',
                              fontSize: 16,
                              color: Color(0xff8D8D8E),
                            ),
                          ),
                          RadioMenuButton(
                            value: 2,
                            groupValue: selectedOption,
                            onChanged: (value) {
                              setState(() {
                                selectedOption = value!;
                              });
                            },
                            child: const TextWidgets(
                              text: 'Work',
                              fontSize: 16,
                              color: Color(0xff8D8D8E),
                            ),
                          ),
                          RadioMenuButton(
                            value: 3,
                            groupValue: selectedOption,
                            onChanged: (value) {
                              setState(() {
                                selectedOption = value!;
                              });
                            },
                            child: const TextWidgets(
                              text: 'Other',
                              fontSize: 16,
                              color: Color(0xff8D8D8E),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: Container(
                          height: 235,
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            color: Color(0xffFFFFFF),
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xffE0E0E0),
                                blurRadius: 15.0,
                                spreadRadius: 5.0,
                                offset: Offset(0.0, 0.0),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 80,
                                child: TextFormFieldWidgets(
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 23, horizontal: 10),
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
                              SizedBox(
                                height: 75,
                                child: TextFormFieldWidgets(
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 25, horizontal: 10),
                                  controller: buildingNumber,
                                  hintText: 'Building Number',
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 150,
                                    child: TextFormFieldWidgets(
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 23, horizontal: 10),
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
                                  SizedBox(
                                    width: 150,
                                    child: TextFormFieldWidgets(
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 23, horizontal: 10),
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
                                ],
                              )
                            ],
                          )),
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
                              Get.toNamed("/home");
                            },
                          ),
                          const SizedBox(
                            width: 40,
                          ),
                          MaterialButtonWidgets(
                              onPressed: () async {
                                fetchAddresses();
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
                                onPressed: () async {
                                  loction1 =
                                      await Geolocator.getCurrentPosition()
                                          .then((value) => value);
                                  lat = loction1.latitude;
                                  long = loction1.longitude;
                                  setState(() {
                                    marker.add(
                                      Marker(
                                        draggable: true,
                                        markerId: const MarkerId('1'),
                                        position: LatLng(lat!, long!),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
