import 'package:clinicx_patient/models/doctor_model.dart';
import 'package:clinicx_patient/models/patient_model.dart';
import 'package:clinicx_patient/models/service_model.dart';
import 'package:clinicx_patient/utils/api_service.dart';
import 'package:clinicx_patient/utils/network/preferences.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class GlobalController extends ChangeNotifier {
  bool isLoading = false;
  bool isAuthenticated = false;
  Object? error;
  PatientModel? userModel;
  List<DoctorModel> doctors = [];
  List<ServiceModel> services = [];

  GlobalController() {
    final accessToken = preferences.getString("token");
    if (accessToken != null && !JwtDecoder.isExpired(accessToken)) {
      isAuthenticated = true;
    }
  }

  Future<void> initialize() async {
    final response = await Future.wait([
      apiService.getDoctors(),
      apiService.getServices(),
    ]);
    doctors = response[0] as List<DoctorModel>;
    services = response[1] as List<ServiceModel>;
    notifyListeners();
  }
}

final globalController = GlobalController();
