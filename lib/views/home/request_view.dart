// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:saude_facil_inovatech/models/emergency_request.dart';
import 'package:saude_facil_inovatech/views/home/widgets/chatbot_screen.dart';

class RequestView extends StatefulWidget {
  const RequestView({super.key, required this.request});
  final EmergencyRequest request;

  @override
  State<RequestView> createState() => _RequestViewState();
}

class _RequestViewState extends State<RequestView> {
  late EmergencyRequest request;
  final Set<Marker> markers = {};
  final Set<Circle> circles = {};
  late GoogleMapController mapController;
  

  @override
  void initState() {
    super.initState();
    request = widget.request;
    markers.add(
      Marker(
        markerId: MarkerId("Marker"),
        position: LatLng(request.lat, request.lgn),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue)
      )
    );
    circles.add(
      Circle(
        circleId: CircleId("position"),
        center: LatLng(request.lat, request.lgn),
        fillColor: Colors.blue.withAlpha(50),
        strokeWidth: 2,
        strokeColor: Colors.blue,
        radius: 500
      )
    );
  }

  @override
  Widget build(BuildContext context) {

    if(MediaQuery.of(context).size.width < 900 ){
      return Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                maps(),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: indicator()
                )
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: ChatbotScreen()
          )
        ],
      );
    }

    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Stack(
            children: [
              maps(),
              Align(
                alignment: Alignment.bottomLeft,
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 600),
                  child: indicator()
                )
              )
            ],
          ),
        ),
        Expanded(child: ChatbotScreen())
      ],
    );
  }

  Widget maps(){
    return GoogleMap(
      onMapCreated: (controller) => mapController = controller,
      initialCameraPosition: CameraPosition(
        target: LatLng(request.lat - 0.001, request.lgn),
        zoom: 15,
      ),
      myLocationEnabled: true,
      markers: markers,
      circles: circles,
    );
  }

  Widget indicator(){
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ExpansionTile(
            childrenPadding: const EdgeInsets.symmetric(horizontal: 20),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 10,),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Icon(
                    Icons.emergency_outlined,
                    color: Theme.of(context).primaryColor,
                    size: 40,
                  ),
                ),
                const SizedBox(height: 10,),
                Text(
                  "A ajuda está a caminho.",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                Text(
                  "Toque para mais detalhes",
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
            children: [
              Row(
                children: [
                  Expanded(
                    child: ListTile(
                      contentPadding: const EdgeInsets.only(right: 20),
                      title: Text("Endereço", style: TextStyle(fontWeight: FontWeight.bold),),
                      subtitle: Text(request.address, style: TextStyle(fontSize: 12, color: Colors.grey)),
                    )
                  ),
                  Expanded(
                    child: ListTile(
                      contentPadding: const EdgeInsets.only(),
                      title: Text("Localização", style: TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text("Latitude: ${request.lat} | Longitude: ${request.lgn}", style: TextStyle(fontSize: 12, color: Colors.grey)),
                    )
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10,),
          Align(
            alignment: Alignment.centerLeft,
            child: LinearProgressIndicator()
          ),
          const SizedBox(height: 20,),
        ],
      ),
    );
  }
}