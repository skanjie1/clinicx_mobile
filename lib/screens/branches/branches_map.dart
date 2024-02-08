import 'package:clinicx_patient/models/branch_model.dart';
import 'package:clinicx_patient/providers/branches_provider.dart';
import 'package:clinicx_patient/providers/location_provider.dart';
import 'package:clinicx_patient/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class BranchesMap extends StatefulWidget {
  const BranchesMap({super.key, this.branch});
  final BranchModel? branch;

  @override
  State<BranchesMap> createState() => _BranchesMapState();
}

class _BranchesMapState extends State<BranchesMap> {
  GoogleMapController? _controller;
  BranchModel? selectedBranch;
  BitmapDescriptor? bitmapDescriptor;
  Marker? markerIcon;

  List<Marker> _markers = [];

//google cloud api key

  void _onMapCreated(GoogleMapController controller) async {
    _controller = controller;

    final branches =
        Provider.of<BranchProvider>(context, listen: false).branches;

    for (BranchModel branch in branches) {
      final marker = Marker(
        markerId: MarkerId(branch.id.toString()),
        position: LatLng(branch.latitude!, branch.longitude!),
        infoWindow: InfoWindow(title: branch.name, snippet: branch.description),
        onTap: () {
          setState(() {
            selectedBranch = branch;
          });

          _controller!.animateCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(
                target: LatLng(branch.latitude!, branch.longitude!),
                zoom: 15,
              ),
            ),
          );
        },
      );
      _markers.add(marker);
    }

    setState(() {});

    if (widget.branch != null) {
      _controller!.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(widget.branch!.latitude!, widget.branch!.longitude!),
            zoom: 15,
          ),
        ),
      );

      selectedBranch = widget.branch;
      setState(() {});
    }
  }

  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final userLoc = Provider.of<LocationProvider>(context).locationData;
    return Scaffold(
        appBar: AppBar(title: const Text("ClinicX Branch Locator")),
        body: Stack(
          children: [
            GoogleMap(
                onMapCreated: _onMapCreated,
                myLocationButtonEnabled: true,
                myLocationEnabled: true,
                markers: Set.from(_markers),
                initialCameraPosition: CameraPosition(
                  target: userLoc == null
                      ? const LatLng(6.5244, 3.3792)
                      : LatLng(userLoc.latitude, userLoc.longitude),
                  zoom: 6,
                )),
            if (selectedBranch != null)
              Positioned(
                  bottom: 14,
                  left: 14,
                  right: 14,
                  child: BranchWidget(
                    branch: selectedBranch!,
                  ))
          ],
        ));
  }
}
