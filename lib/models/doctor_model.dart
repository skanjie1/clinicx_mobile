import 'package:clinicx_patient/models/branch_model.dart';

class DoctorModel {
  int? branchId;
  int? userId;
  int? id;
  BranchModel? branch;
  User? user;

  DoctorModel({this.branchId, this.userId, this.id, this.branch, this.user});

  DoctorModel.fromJson(Map<String, dynamic> json) {
    branchId = json['branch_id'];
    userId = json['user_id'];
    id = json['id'];
    branch =
        json['branch'] != null ? BranchModel.fromJson(json['branch']) : null;
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['branch_id'] = branchId;
    data['user_id'] = userId;
    data['id'] = id;
    if (branch != null) {
      data['branch'] = branch!.toJson();
    }
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class User {
  String? email;
  String? phoneNumber;
  String? firstName;
  String? lastName;
  String? gender;
  String? role;
  String? userImage;
  String? dateOfBirth;
  String? maritalStatus;
  String? createdAt;
  int? id;

  User(
      {this.email,
      this.phoneNumber,
      this.firstName,
      this.lastName,
      this.gender,
      this.role,
      this.userImage,
      this.dateOfBirth,
      this.maritalStatus,
      this.createdAt,
      this.id});

  User.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    phoneNumber = json['phone_number'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    gender = json['gender'];
    role = json['role'];
    userImage = json['user_image'];
    dateOfBirth = json['date_of_birth'];
    maritalStatus = json['marital_status'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['phone_number'] = phoneNumber;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['gender'] = gender;
    data['role'] = role;
    data['user_image'] = userImage;
    data['date_of_birth'] = dateOfBirth;
    data['marital_status'] = maritalStatus;
    data['created_at'] = createdAt;
    data['id'] = id;
    return data;
  }
}
