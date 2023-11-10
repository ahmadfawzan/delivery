import 'package:delivery/widgets/text_widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../controllers/address_controller/address_controller.dart';
import '../controllers/checkout_controller/checkout_controller.dart';

class CheckOut extends StatefulWidget {
  const CheckOut({super.key});

  @override
  State<CheckOut> createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {
  final AddressController addressController = Get.find();
  final CheckOutController checkOutController = Get.find();
  late GoogleMapController _controller;

  @override
  void initState() {
    checkOutController.PopMenuValueCheckOut();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 20.0, right: 10, left: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                      onPressed: () async {
                        checkOutController.changeAddressList.clear();
                        Get.back();
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        size: 22,
                      )),
                  const Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(right: 25.0),
                      child: TextWidgets(
                        text: "CheckOut",
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                ],
              ),
              Obx(() {
                return Container(
                  width: double.infinity,
                  height: 325,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        blurRadius: 3,
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: double.infinity,
                          height: 200,
                          child: GoogleMap(
                            gestureRecognizers: {
                              Factory<PanGestureRecognizer>(
                                  () => PanGestureRecognizer()),
                              Factory<ScaleGestureRecognizer>(
                                  () => ScaleGestureRecognizer()),
                              Factory<TapGestureRecognizer>(
                                  () => TapGestureRecognizer()),
                              Factory<EagerGestureRecognizer>(
                                  () => EagerGestureRecognizer()),
                            },
                            initialCameraPosition: CameraPosition(
                              target: LatLng(
                                  checkOutController.changeAddressList.isEmpty
                                      ? double.parse(checkOutController
                                          .popMenuValueCheckOut[0].latitude)
                                      : double.parse(checkOutController
                                          .changeAddressList.first.latitude!),
                                  checkOutController.changeAddressList.isEmpty
                                      ? double.parse(checkOutController
                                          .popMenuValueCheckOut[0].longitude)
                                      : double.parse(checkOutController
                                          .changeAddressList.first.longitude!)),
                              zoom: 14.4746,
                            ),
                            markers: {
                              Marker(
                                markerId: const MarkerId('1'),
                                draggable: true,
                                position: LatLng(
                                    checkOutController.changeAddressList.isEmpty
                                        ? double.parse(checkOutController
                                            .popMenuValueCheckOut[0].latitude)
                                        : double.parse(checkOutController
                                            .changeAddressList.first.latitude!),
                                    checkOutController.changeAddressList.isEmpty
                                        ? double.parse(checkOutController
                                            .popMenuValueCheckOut[0].longitude)
                                        : double.parse(checkOutController
                                            .changeAddressList
                                            .first
                                            .longitude!)),
                              )
                            },
                            onMapCreated: (GoogleMapController controller) {
                              _controller = controller;
                            },
                            mapType: MapType.normal,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Icon(
                                      Icons.location_on_outlined,
                                      size: 24,
                                    ),
                                    const SizedBox(
                                      width: 3,
                                    ),
                                    TextWidgets(
                                      text:
                                          "${checkOutController.changeAddressList.isEmpty ? checkOutController.popMenuValueCheckOut[0].street : checkOutController.changeAddressList.first.street}",
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.home_outlined,
                                      size: 24,
                                    ),
                                    const SizedBox(
                                      width: 3,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        TextWidgets(
                                          text:
                                              "bulding:${checkOutController.changeAddressList.isEmpty  ? checkOutController.popMenuValueCheckOut[0].buildingNumber??'0' : checkOutController.changeAddressList.first.buildingNumber??'0'}",
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        const SizedBox(height: 5,),
                                        TextWidgets(
                                          text:
                                          "apartment:${checkOutController.changeAddressList.isEmpty ? checkOutController.popMenuValueCheckOut[0].apartmentNum : checkOutController.changeAddressList.first.apartmentNum}",
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ],
                                    )
                                  ],
                                )
                              ],
                            ),
                            SizedBox(
                                width: 75,
                                child: PopupMenuButton(
                                    color: const Color(0xffEBFAF5),
                                    onSelected: (value) {
                                      setState(() {
                                        checkOutController
                                            .changeAddressList.value = [value];
                                        _controller.animateCamera(
                                            CameraUpdate.newCameraPosition(
                                                CameraPosition(
                                          target: LatLng(
                                            checkOutController
                                                    .changeAddressList.isEmpty
                                                ? double.parse(
                                                    checkOutController
                                                        .popMenuValueCheckOut[0]
                                                        .latitude)
                                                : double.parse(
                                                    checkOutController
                                                        .changeAddressList
                                                        .first
                                                        .latitude!),
                                            checkOutController
                                                    .changeAddressList.isEmpty
                                                ? double.parse(
                                                    checkOutController
                                                        .popMenuValueCheckOut[0]
                                                        .longitude)
                                                : double.parse(
                                                    checkOutController
                                                        .changeAddressList
                                                        .first
                                                        .longitude!),
                                          ),
                                          zoom: 14,
                                        )));
                                      });
                                    },
                                    child: Row(
                                      children: [
                                        addressController.addressList.isEmpty
                                            ? const TextWidgets(
                                                text: 'No Loction',
                                                fontWeight: FontWeight.bold,
                                                textOverFlow:
                                                    TextOverflow.ellipsis,
                                                fontSize: 15,
                                              )
                                            : const TextWidgets(
                                                text: "Change",
                                                color: Color(0xff52C4A1),
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15,
                                              ),
                                        const Icon(
                                          Icons.keyboard_arrow_down_outlined,
                                          color: Color(0xff52C4A1),
                                          size: 22,
                                        ),
                                      ],
                                    ),
                                    itemBuilder: (context) => [
                                          ...addressController.addressList
                                              .map((item) {
                                            return PopupMenuItem(
                                              value: item,
                                              child: Container(
                                                width: 190,
                                                padding: const EdgeInsets.only(
                                                    right: 8.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    TextWidgets(
                                                      text: item.type == 1
                                                          ? item.street
                                                              .toString()
                                                          : item.type == 2
                                                              ? item.street
                                                                  .toString()
                                                              : item.street
                                                                  .toString(),
                                                      textOverFlow:
                                                          TextOverflow.ellipsis,
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                    const SizedBox(
                                                      height: 6,
                                                    ),
                                                    TextWidgets(
                                                      text: item.type == 1
                                                          ? '${item.city.toString()} - ${item.apartmentNum.toString()}'
                                                          : item.type == 2
                                                              ? '${item.city.toString()} - ${item.apartmentNum.toString()}'
                                                              : '${item.city.toString()} - ${item.apartmentNum.toString()}',
                                                      textOverFlow:
                                                          TextOverflow.ellipsis,
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    Theme(
                                                      data: ThemeData(
                                                        dividerColor:
                                                            Colors.black,
                                                      ),
                                                      child:
                                                          const PopupMenuDivider(
                                                        height: 4,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          }),
                                          PopupMenuItem(
                                            child: const TextWidgets(
                                                text: '+Add new address'),
                                            onTap: () {
                                              Get.toNamed("/addNewAddress");
                                            },
                                          )
                                        ]))
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}
