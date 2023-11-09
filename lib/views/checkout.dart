import 'package:delivery/widgets/text_widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CheckOut extends StatefulWidget {
  const CheckOut({super.key});

  @override
  State<CheckOut> createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {
  late GoogleMapController _controller;
  CameraPosition? _kGooglePlex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 20.0,right: 10,left: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
             Row(
                  children: [
                  Container(
                    padding: const EdgeInsets.only(left: 5),
                    width: 5,
                    child: IconButton(
                            onPressed: () async {
                              Get.back();
                            },
                            icon: const Icon(
                              Icons.arrow_back,
                              size: 22,
                            )),
                  ),
                    const Expanded(
                      child: TextWidgets(
                          text: "CheckOut",
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ),
              Container(
                width: double.infinity,
                height: 250,
                decoration: BoxDecoration(
                  color:Colors.white ,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey
                          .withOpacity(0.5),
                      blurRadius:3,
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0,right: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: 125,
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
                          /*markers: marker,*/
                          mapType: MapType.normal,
                          onMapCreated: (GoogleMapController controller) {
                            _controller = controller;
                          },
                          myLocationEnabled: true,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
