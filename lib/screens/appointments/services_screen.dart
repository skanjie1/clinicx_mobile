import 'package:clinicx_patient/providers/global_controller.dart';
import 'package:clinicx_patient/screens/appointments/appointments_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ServicesScreen extends StatelessWidget {
  const ServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final services = Provider.of<GlobalController>(context).services;
    return Scaffold(
      appBar: AppBar(
        title: const Text("ClinicX Services"),
      ),
      body: ListView.builder(
        itemCount: services.length,
        padding: const EdgeInsets.symmetric(horizontal: 14),
        itemBuilder: (context, index) {
          final service = services[index];
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: ListTile(
                onTap: () {
                  final controller = globalController;
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => AppointmentsScreen(
                            doctors: controller.doctors,
                            services: controller.services,
                          )));
                },
                title: Text(service.name!),
                subtitle: Text("KES ${service.price!}"),
                trailing: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(8)),
                  child: const Text(
                    "Book",
                    style: TextStyle(color: Colors.blue),
                  ),
                )),
          );
        },
      ),
    );
  }
}
