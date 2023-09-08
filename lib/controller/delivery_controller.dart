import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:web_socket_client/web_socket_client.dart';

import '../service/location_service.dart';
import '../utils/constant.dart';

class DeliveryController extends ChangeNotifier{
  DeliveryController(){
    _init();
  }

  _init()async{
        position = CameraPosition(target: await _userLocation(), zoom: 16);
            Stream<Position> pos = LocationService.getLocationSteam();
              pos.listen(
      (event) {
       
        if (event.latitude != lastLat || event.longitude != lastLng) {
          lastLat = event.latitude;
          lastLng = event.longitude;
                    if (mapController!= null) {
          mapController!.animateCamera(
              CameraUpdate.newLatLng(LatLng(event.latitude, event.longitude)));
          }

          notifyListeners();

         
        }
      },
    );
        notifyListeners();
  }
  bool isAvailable = false;
  double animationController = -10;
    double lastLat = 0;
  double lastLng = 0;
    CameraPosition? position;
     GoogleMapController? mapController;
       late WebSocket socket;
         String? token;

    initialController(GoogleMapController controller) {
    mapController = controller;
    notifyListeners();
  }

  void _socketConnect(BuildContext context) async {
    LatLng location = await _userLocation();
    socket = WebSocket(Uri.parse(webSocketUrl(location, token!)));

    socket.messages.listen((event){
      print(event);
    });}

  void changeIsAvailable(bool val, BuildContext context) {
    if (val) {
      _socketConnect(context);
    } else {
      _socketDisconnect();
    }
    isAvailable = val;
    notifyListeners();
  }

  void _socketDisconnect() {
    socket.close();
  }
  Future<LatLng> _userLocation() async {
    Position value = await LocationService.determinePosition();
    LatLng _latLng = LatLng(value.latitude, value.longitude);
    return _latLng;
  }
    void setToken(String? token){
    print(token);
    this.token = token;
    notifyListeners(); 
  }
}