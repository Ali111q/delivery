import 'package:delivery/controller/delivery_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import 'bottom_sheets/home_bottomsheet.dart';
import 'bottom_sheets/order_bottomsheets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  
  @override
  Widget build(BuildContext context) {
        DeliveryController controller = Provider.of<DeliveryController>(context);

    return  Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(6.0),
          child: GestureDetector(
            onTap: () {
              showModalBottomSheet(
                constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height * 0.7),
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                context: context,
                builder: (context) => OrdersBottomSheet(),
              );
            },
            child: Material(
              elevation: 2,
              borderRadius: BorderRadius.circular(7),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: SvgPicture.asset('assets/svgs/orders.svg'),
              ),
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height * 0.7),
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  context: context,
                  builder: (context) => HomeBottomSheet(),
                );
              },
              child: Material(
                elevation: 2,
                borderRadius: BorderRadius.circular(7),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SvgPicture.asset('assets/svgs/setting.svg'),
                ),
              ),
            ),
          )
        ],
      ),
      body: Stack(
        children: [
           if (controller.position != null)
            GoogleMap(
              initialCameraPosition: controller.position!,
              zoomControlsEnabled: false,
              // myLocationEnabled: true,
              markers: {
                Marker(
                    markerId: MarkerId('value'),
                    icon: BitmapDescriptor.defaultMarkerWithHue(
                        BitmapDescriptor.hueAzure),
                    position: LatLng(
                        Provider.of<DeliveryController>(context).lastLat,
                        Provider.of<DeliveryController>(context).lastLng))
              },
              onMapCreated: Provider.of<DeliveryController>(context, listen: false)
                  .initialController,
              myLocationButtonEnabled: false,
            ),
        ],
      ),
    );
  }
}