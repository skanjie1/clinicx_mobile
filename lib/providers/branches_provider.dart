import 'package:clinicx_patient/models/branch_model.dart';
import 'package:clinicx_patient/utils/api_service.dart';
import 'package:flutter/material.dart';

class BranchProvider with ChangeNotifier {
  List<BranchModel> _branches = [];

  List<BranchModel> get branches => _branches;

  Future<List<BranchModel>> getBranches({String? searchQuery}) async {
    final result = await apiService.getBranches(searchQuery: searchQuery);
    _branches = result;
    notifyListeners();
    return result;
  }
}
