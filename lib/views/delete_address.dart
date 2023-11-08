import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:delivery/widgets/text_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import '../controllers/address_controller/address_controller.dart';
import '../controllers/cart_controller/cart_controller.dart';
import '../services/address/delete_address/delete_address.dart';
import '../widgets/material_button_widgets.dart';

class DeleteAddress extends StatefulWidget {
  const DeleteAddress({super.key});

  @override
  State<DeleteAddress> createState() => _DeleteAddressState();
}

class _DeleteAddressState extends State<DeleteAddress> {
  final AddressController addressController = Get.find();
  final CartController cartController = Get.find();
  late BuildContext context1;
  @override
  Widget build(BuildContext context) {
    context1=context;
    return GetBuilder(
        init: AddressController(),
        builder: (addressController) => Scaffold(
              backgroundColor: Colors.white,
              body: Padding(
                padding: const EdgeInsets.only(top: 25.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: const Icon(
                            Icons.arrow_back,
                            color: Color(0xff4E5156),
                            size: 25,
                          ),
                        ),
                        const TextWidgets(
                          text: "Delete Address",
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                        GetBuilder(
                            init: CartController(),
                            builder: (cartController) {
                              return Stack(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      Get.toNamed("/cart");
                                    },
                                    icon: const Icon(
                                      Icons.shopping_bag,
                                      color: Color(0xff4E5156),
                                      size: 25,
                                    ),
                                  ),
                                  Positioned(
                                    right: 4,
                                    top: 2,
                                    child: Container(
                                      padding: const EdgeInsets.all(4),
                                      decoration: const BoxDecoration(
                                        color: Color(0xff14CB95),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Text(
                                        '${cartController.numberOfItem}',
                                        style: const TextStyle(
                                          fontSize: 15,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            })
                      ],
                    ),
                    addressController.addressList.isEmpty
                        ? const Center(
                            child: TextWidgets(
                              text:
                                  "There is no Loction. Please enter a Loction",
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              textAlign: TextAlign.center,
                            ),
                          )
                        : Expanded(
                            child: ListView.builder(
                                itemExtent: 80,
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount: addressController.addressList.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                      padding: const EdgeInsets.only(
                                          left: 12, right: 12),
                                      child: addressController.isLoading.value
                                          ? Shimmer.fromColors(
                                              baseColor: Colors.grey[300]!,
                                              highlightColor: Colors.grey[100]!,
                                              child: Container(
                                                height: 65,
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                              ),
                                            )
                                          : SingleChildScrollView(
                                              child: Container(
                                                height: 65,
                                                width: double.infinity,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10),
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(25),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.grey
                                                          .withOpacity(0.5),
                                                      spreadRadius: 5,
                                                      blurRadius: 7,
                                                      offset:
                                                          const Offset(0, 3),
                                                    ),
                                                  ],
                                                ),
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        TextWidgets(
                                                          text:
                                                              "${addressController.addressList[index].street}/${addressController.addressList[index].buildingNumber ?? 0}",
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 15,
                                                        ),
                                                        const SizedBox(
                                                          width: 10,
                                                        ),
                                                        TextWidgets(
                                                          text:
                                                              "${addressController.addressList[index].city}/${addressController.addressList[index].apartmentNum}",
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 15,
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(width: 15,),
                                                    SizedBox(
                                                      height: 35,
                                                      width: 70,
                                                      child: MaterialButtonWidgets(
                                                        onPressed: () async {
                                                          if (!mounted) return;
                                                          AwesomeDialog(
                                                            context: context1,
                                                            animType: AnimType.leftSlide,
                                                            dialogType: DialogType.info,
                                                            btnOkOnPress: () {
                                                              RemoteServicesAddress.fetchAddress(context:context1,id:addressController.addressList[index].id,mounted:mounted);
                                                              if (!mounted) return;
                                                              AwesomeDialog(
                                                                context: context,
                                                                animType: AnimType.leftSlide,
                                                                dialogType: DialogType.success,
                                                                btnOkOnPress: () {},
                                                                btnCancelOnPress: () {},
                                                                title: "Delete Address",
                                                                body: const TextWidgets(
                                                                  text: "Deleted Address successfully",
                                                                  fontSize: 18,
                                                                  fontWeight: FontWeight.bold,
                                                                  textAlign: TextAlign.center,
                                                                ),
                                                              ).show();
                                                            },
                                                            btnCancelOnPress: () {},
                                                            title: "Delete Address",
                                                            body: const TextWidgets(
                                                              text: "Are you sure you want to delete this address?",
                                                              fontSize: 18,
                                                              fontWeight: FontWeight.bold,
                                                              textAlign: TextAlign.center,
                                                            ),
                                                          ).show();
                                                        },
                                                        textColor: Colors.white,
                                                        color: const Color(
                                                            0xff15CB95),
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                        child: const Center(
                                                          child: TextWidgets(
                                                              text: "Delete",
                                                              fontSize: 10,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ));
                                }),
                          ),
                    Container(
                      width: double.infinity,
                      height: 55,
                      color: const Color(0xff14CB95),
                    )
                  ],
                ),
              ),
            ));
  }
}
