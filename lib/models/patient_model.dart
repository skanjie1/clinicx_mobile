class PatientModel {
  String? bloodGroup;
  String? address;
  String? about;
  String? email;
  String? phoneNumber;
  String? firstName;
  String? lastName;
  String? gender;
  String? userImage;
  String? dateOfBirth;
  String? maritalStatus;
  int? id;

  PatientModel(
      {this.bloodGroup,
      this.address,
      this.about,
      this.email,
      this.phoneNumber,
      this.firstName,
      this.lastName,
      this.gender,
      this.userImage,
      this.dateOfBirth,
      this.maritalStatus,
      this.id});

  PatientModel.fromJson(Map<String, dynamic> json) {
    bloodGroup = json['blood_group'];
    address = json['address'];
    about = json['about'];
    email = json['email'];
    phoneNumber = json['phone_number'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    gender = json['gender'];
    userImage = json['user_image'];
    dateOfBirth = json['date_of_birth'];
    maritalStatus = json['marital_status'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['blood_group'] = bloodGroup;
    data['address'] = address;
    data['about'] = about;
    data['email'] = email;
    data['phone_number'] = phoneNumber;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['gender'] = gender;
    data['user_image'] = userImage;
    data['date_of_birth'] = dateOfBirth;
    data['marital_status'] = maritalStatus;
    data['id'] = id;
    return data;
  }
}
