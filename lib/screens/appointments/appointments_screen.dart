import 'package:clinicx_patient/models/doctor_model.dart';
import 'package:clinicx_patient/models/service_model.dart';
import 'package:clinicx_patient/utils/api_service.dart';
import 'package:clinicx_patient/utils/constants.dart';
import 'package:clinicx_patient/widgets/custom_dropdown.dart';
import 'package:clinicx_patient/widgets/custom_textfield.dart';
import 'package:clinicx_patient/widgets/phone_number_form_field.dart';
import 'package:clinicx_patient/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppointmentsScreen extends StatefulWidget {
  const AppointmentsScreen(
      {super.key, required this.doctors, required this.services});
  final List<DoctorModel> doctors;
  final List<ServiceModel> services;

  @override
  State<AppointmentsScreen> createState() => _AppointmentsScreenState();
}

class _AppointmentsScreenState extends State<AppointmentsScreen> {
  final reasonController = TextEditingController();
  final dateController = TextEditingController();
  final timeController = TextEditingController();

  DoctorModel? selectedDoctor;
  ServiceModel? selectedService;
  String? selectedDOption;
  String? selectedSOption;
  String? phoneNumber;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Book an appointment"),
        ),
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          children: [
            const Text("Your phone number"),
            const SizedBox(
              height: 8,
            ),
            PhoneNumberFormField(
              labelText: "Your phone number",
              onChanged: (countryCode, value) {
                phoneNumber = "0$value";
              },
            ),
            const SizedBox(
              height: 10,
            ),
            const Text("Choose a service"),
            CustomDropdown(
                selectedOption: (val) {
                  final service = widget.services
                      .firstWhere((element) => element.name == val);

                  setState(() {
                    selectedSOption = val;
                    selectedService = service;
                  });
                },
                options: widget.services.map((e) => "${e.name}").toList(),
                hintText: "Select a service"),
            const SizedBox(
              height: 10,
            ),
            const Text("Choose a doctor"),
            CustomDropdown(
                selectedOption: (val) {
                  final doctor = widget.doctors.firstWhere((element) =>
                      "${element.user!.firstName!} ${element.user!.lastName!}" ==
                      val);

                  setState(() {
                    selectedDOption = val;
                    selectedDoctor = doctor;
                  });
                },
                options: widget.doctors
                    .map((e) => "${e.user!.firstName!} ${e.user!.lastName!}")
                    .toList(),
                hintText: "Select a doctor"),
            const Text("Reason for appointment"),
            const SizedBox(
              height: 8,
            ),
            CustomTextField(
                controller: reasonController,
                hintText: "Reason for appointment"),
            const SizedBox(
              height: 14,
            ),
            const Text("Date to schedule appointment"),
            const SizedBox(
              height: 8,
            ),
            CustomTextField(
                controller: dateController,
                hintText: "Date",
                suffixIcon: IconButton(
                  onPressed: () async {
                    final date = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(const Duration(days: 30)));
                    dateController.text =
                        DateFormat("dd/MM/yyyy").format(date!);
                  },
                  icon: const Icon(Icons.calendar_today),
                )),
            const SizedBox(
              height: 14,
            ),
            const Text("Time to schedule appointment"),
            const SizedBox(
              height: 8,
            ),
            CustomTextField(
                controller: timeController,
                hintText: "Time",
                suffixIcon: IconButton(
                  onPressed: () async {
                    final time = await showTimePicker(
                        context: context, initialTime: TimeOfDay.now());
                    timeController.text = DateFormat("hh:mm a")
                        .format(DateTime(2021, 1, 1, time!.hour, time.minute));
                  },
                  icon: const Icon(Icons.access_time),
                )),
            const SizedBox(
              height: 14,
            ),
            PrimaryButton(
              isLoading: isLoading,
              onTap: () async {
//Check if all fields are filled
                if (phoneNumber == null ||
                    selectedDoctor == null ||
                    selectedService == null ||
                    dateController.text.isEmpty ||
                    timeController.text.isEmpty ||
                    reasonController.text.isEmpty) {
                  showErrorSnackBar(context, "All fields are required");
                  return;
                }

                setState(() {
                  isLoading = true;
                });
                try {
                  final patient =
                      await apiService.getPatientByPhoneNumber(phoneNumber!);
                  print(patient.toJson());
                  final data = {
                    "patient_id": 2,
                    "doctor_id": selectedDoctor!.id,
                    "service_id": selectedService!.id,
                    "appointment_date": dateController.text,
                    "appointment_time": timeController.text,
                    "reason": reasonController.text
                  };

                  await apiService.bookAppointment(data);
                  Navigator.pop(context);
                } catch (e) {
                  showErrorSnackBar(context, "Failed to book appointment");
                }

                setState(() {
                  isLoading = false;
                });
              },
              text: "Book appointment",
            )
          ],
        ));
  }
}
