import 'package:clinicx_patient/models/branch_model.dart';
import 'package:clinicx_patient/providers/branches_provider.dart';
import 'package:clinicx_patient/providers/global_controller.dart';
import 'package:clinicx_patient/providers/location_provider.dart';
import 'package:clinicx_patient/screens/appointments/appointments_screen.dart';
import 'package:clinicx_patient/screens/appointments/services_screen.dart';
import 'package:clinicx_patient/screens/branches/branches_map.dart';
import 'package:clinicx_patient/widgets/custom_textfield.dart';
import 'package:clinicx_patient/widgets/loading_shimmer.dart';
import 'package:direct_dialer/direct_dialer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  final searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Provider.of<LocationProvider>(context, listen: false).getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: RefreshIndicator(
        onRefresh: () async {
          await Provider.of<BranchProvider>(context, listen: false)
              .getBranches();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              CustomTextField(
                prefixIcon: const Icon(
                  Icons.search,
                ),
                controller: searchController,
                hintText: "Search branches",
                onChanged: (_) {
                  setState(() {});
                },
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      final controller = globalController;
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => AppointmentsScreen(
                                doctors: controller.doctors,
                                services: controller.services,
                              )));
                    },
                    child: const HomeOptionChip(
                      title: "Schedule",
                      color: Colors.green,
                      icon: Icons.calendar_month,
                    ),
                  ),
                  const SizedBox(width: 10),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const ServicesScreen()));
                    },
                    child: const HomeOptionChip(
                      title: "Services",
                      color: Colors.orange,
                      icon: Icons.medical_services,
                    ),
                  ),
                  const SizedBox(width: 10),
                  const HomeOptionChip(
                    title: "Contact us",
                    color: Colors.blue,
                    icon: Icons.phone,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  const Text(
                    "Branches",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const BranchesMap()));
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 14),
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.blue),
                      ),
                      child: const Text(
                        "View on Map",
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: FutureBuilder<List<BranchModel>>(
                    future: Provider.of<BranchProvider>(context, listen: false)
                        .getBranches(searchQuery: searchController.text),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return LoadingEffect.getSearchLoadingScreen(context);
                      }
                      print(snapshot.error);

                      if (snapshot.hasError) {
                        return const Center(
                          child: Text("An error occurred"),
                        );
                      }

                      final branches = snapshot.data;
                      if (branches == null) {
                        return const Center(
                          child: Text("No branches found"),
                        );
                      }
                      return ListView.builder(
                        itemCount: branches.length,
                        itemBuilder: (context, index) {
                          return BranchWidget(branch: branches[index]);
                        },
                      );
                    }),
              )
            ],
          ),
        ),
      ),
    ));
  }
}

class BranchWidget extends StatelessWidget {
  const BranchWidget({
    super.key,
    required this.branch,
  });

  final BranchModel branch;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.withOpacity(0.3)),
      ),
      child: ListTile(
        leading: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.3),
                borderRadius: BorderRadius.circular(8)),
            child: const Icon(Icons.map_outlined)),
        title: Text(branch.name!),
        tileColor: Theme.of(context).cardColor,
        subtitle: Text(branch.address!),
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => BranchesMap(
                    branch: branch,
                  )));
        },
        trailing: GestureDetector(
          onTap: () async {
            final dialer = await DirectDialer.instance;

            await dialer.dial(branch.phoneNumber!);
          },
          child: const Column(
            children: [Icon(Icons.call), Text("Contact")],
          ),
        ),
      ),
    );
  }
}

class HomeOptionChip extends StatelessWidget {
  const HomeOptionChip({
    super.key,
    required this.color,
    required this.title,
    required this.icon,
  });
  final Color color;
  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            decoration: BoxDecoration(
                color: color.withOpacity(0.3),
                borderRadius: BorderRadius.circular(8)),
            padding: const EdgeInsets.all(28),
            child: Icon(
              icon,
              color: color,
              size: 40,
            )),
        const SizedBox(
          height: 10,
        ),
        Text(title),
      ],
    );
  }
}
