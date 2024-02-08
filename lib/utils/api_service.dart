import 'package:clinicx_patient/models/branch_model.dart';
import 'package:clinicx_patient/models/doctor_model.dart';
import 'package:clinicx_patient/models/patient_model.dart';
import 'package:clinicx_patient/models/service_model.dart';
import 'package:clinicx_patient/utils/network/http_client.dart';

class APIService {
  String _queryParams(Map<String, dynamic> params) =>
      '?${params.entries.map((map) => '${map.key}=${map.value}').toList().join('&')}';

  Future<PatientModel> getUser() async {
    final result = await httpClient.request("/patients", "GET", {});
    return PatientModel.fromJson(result.data);
  }

  Future<List<BranchModel>> getBranches({String? searchQuery}) async {
    final filters = {
      "search": searchQuery ?? "",
    };
    final result = await httpClient
        .request("/branches${_queryParams(filters)}", "GET", {});

    print(result.data);
    return List<BranchModel>.from(
        result.data.map((x) => BranchModel.fromJson(x)));
  }

  Future<List<DoctorModel>> getDoctors({String? searchQuery}) async {
    final filters = {
      "search": searchQuery ?? "",
    };
    final result =
        await httpClient.request("/doctors${_queryParams(filters)}", "GET", {});

    return List<DoctorModel>.from(
        result.data.map((x) => DoctorModel.fromJson(x)));
  }

  Future<List<ServiceModel>> getServices({String? searchQuery}) async {
    final filters = {
      "search": searchQuery ?? "",
    };
    final result = await httpClient
        .request("/services${_queryParams(filters)}", "GET", {});

    return List<ServiceModel>.from(
        result.data.map((x) => ServiceModel.fromJson(x)));
  }

  Future<void> bookAppointment(Map<String, dynamic> data) async {
    final response = await httpClient.request("/appointments/", "POST", data);
    print(response.data);
  }

  Future<PatientModel> getPatientByPhoneNumber(String phoneNumber) async {
    final result =
        await httpClient.request("/patients?search=$phoneNumber", "GET", {});
    return PatientModel.fromJson(result.data[0]);
  }
}

final apiService = APIService();
