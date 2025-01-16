import 'package:flutter/material.dart';
import 'package:garageauto/controllers/appointment_controller.dart';
import 'package:garageauto/controllers/mechanic_controller.dart';
import 'package:garageauto/controllers/providers/theme_provider.dart';
import 'package:garageauto/main.dart';
import 'package:garageauto/models/appointment.dart';
import 'package:garageauto/views/availabilities.dart';
import 'package:provider/provider.dart';
import 'package:garageauto/views/login.dart';
import 'package:garageauto/controllers/providers/user_provider.dart';

class Home extends StatefulWidget {
  final List<Appointment>? appointments;

  const Home({this.appointments});

  @override
  State<Home> createState() => HomeState();
}

class HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Widget>(
      future: _buildPage(context),
      builder: (BuildContext context, AsyncSnapshot<Widget> snapshot) {
        if (snapshot.connectionState != ConnectionState.waiting) {
          if (!Provider.of<UserProvider>(context).isLoggedIn) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Login())
              );
            });
            return Container();
          }
          return Scaffold(
            body: Center(child: snapshot.data)
          );
        } else {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator())
          );
        }
      }
    );
  }

  Future<Widget> _buildPage(BuildContext context) async {
    final themeState = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Container(
          padding: const EdgeInsets.only(top: 30.0),
          child: Text(
            "My Appointments",
            style: TextStyle(color: themeState.getDarkTheme ? Colors.white : Colors.black)
          ),
        ),
        actions: [
          if (Provider.of<UserProvider>(context, listen: false).hasRole('admin'))
            Padding(
              padding: const EdgeInsets.only(top: 20.0, right: 12),
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Availabilities(),
                      ),
                    );
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                ),
                child: const Row(
                  children: [
                    Icon(
                      Icons.admin_panel_settings,
                      size: 24,
                      color: Colors.white,
                    ),
                    SizedBox(width: 5),
                    Text("Availabilities")
                  ]
                )
              )
            )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(padding: EdgeInsets.only(bottom: 10)),
            FutureBuilder(
              future: listAppointments(),
              builder: (context, snapshot) {
                return SizedBox(
                  height: 500,
                  child: SingleChildScrollView(child: snapshot.data)
                );
              }
            ),
          ],
        )
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.edit_calendar_rounded, color: Colors.white),
        onPressed: () async {
          reserveAppointment(context);
        },
      ),
    );
  }

  Future<Widget?> listAppointments() async {
    final scrollController = ScrollController();
    final appointmentController = AppointmentController();
    final mechanicController = MechanicController();
    final themeState = Provider.of<ThemeProvider>(context);

    Future<List<Appointment>>? appointmentsList = appointmentController.getUserAppointments(Provider.of<UserProvider>(context).id!);
    List<Appointment> appointments = await appointmentsList;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: themeState.getDarkTheme ? const Color.fromARGB(255, 58, 51, 46) : const Color.fromARGB(255, 199, 198, 198),
      ),
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.all(0),
      child: SizedBox(
        child: Scrollbar(
          thumbVisibility: true,
          controller: scrollController,
          thickness: 7,
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(children: [
              DataTable(
                columns: <DataColumn>[
                  DataColumn(
                    label: Expanded(
                      child: Text(
                        "Date",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: themeState.getDarkTheme ? Colors.white: Colors.black,
                          fontSize: 18
                        ),
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Expanded(
                      child: Text(
                        "Mechanic",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: themeState.getDarkTheme ? Colors.white: Colors.black,
                          fontSize: 18
                        ),
                      ),
                    ),
                  ),
                  const DataColumn(
                    label: Expanded(
                      child: Text(
                        ""
                      ),
                    ),
                  ),
                ],
                rows: appointments.expand((appointment) {
                  return [
                    DataRow(
                      key: ValueKey(appointment.id.toString()),
                      cells: <DataCell>[
                        DataCell(
                          Text(
                            appointment.date,
                            style: TextStyle(
                              color: themeState.getDarkTheme ? Colors.white: Colors.black,
                            ),
                          )
                        ),
                        DataCell(
                          FutureBuilder<String>(
                            future: mechanicController.getNameFromId(appointment.mechanicId),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return const CircularProgressIndicator();
                              } else if (snapshot.hasError) {
                                return Text("Error: ${snapshot.error}");
                              } else {
                                return Text(
                                  snapshot.data ?? "",
                                  style: TextStyle(color: themeState.getDarkTheme ? Colors.white: Colors.black),
                                );
                              }
                            },
                          ),
                        ),
                        DataCell(
                          IconButton(
                            key: const Key("CancelAppointmentButton"),
                            icon: Icon(
                              Icons.close,
                              size: 20,
                              color: themeState.getDarkTheme ? Colors.white: Colors.black,
                            ),
                            onPressed: () {
                              cancelAppointment(context, appointment);
                            },
                          )
                        ),
                      ],
                    ),
                  ];
                }).toList(),
              ),
            const Padding(padding: EdgeInsets.only(bottom: 15))
            ])
          )
        )
      )
    );
  }

  Future<void> cancelAppointment(BuildContext context, Appointment appointment) async {
    AppointmentController appointmentController = AppointmentController();

    return showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Are you sure?",
                    style: TextStyle(color: Provider.of<ThemeProvider>(context).getDarkTheme ? Colors.white: Colors.black)
                  ),
                ]
              ),
              scrollable: true,
              content: SizedBox(
                height: 110,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Are you sure you want to cancel your appointment?",
                      style: TextStyle(color: Provider.of<ThemeProvider>(context).getDarkTheme ? Colors.white: Colors.black)
                    ),
                    const Padding(padding: EdgeInsets.only(bottom: 20)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: OutlinedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey,
                              foregroundColor: Colors.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))
                            ),
                            child: const Text("No")
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: OutlinedButton(
                            onPressed: () async {
                              appointmentController.cancelAppointment(appointment);
                              Navigator.pop(context);
                              // ignore: use_build_context_synchronously
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MyApp()
                                )
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                              foregroundColor: Colors.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))
                            ),
                            child: const Text("Yes")
                          )
                        )
                      ]
                    )
                  ]
                )
              )
            );
          }
        );
      }
    );
  }

  Future<void> reserveAppointment(BuildContext context) async {
    AppointmentController appointmentController = AppointmentController();
    MechanicController mechanicController = MechanicController();

    Future<List<Appointment>>? appointmentsList = appointmentController.getAvailableAppointments();
    List<Appointment> availableAppointments = await appointmentsList;

    Appointment? selectedAppointment;
    if (availableAppointments.isNotEmpty) {
      selectedAppointment = availableAppointments.first;
    }

    // ignore: use_build_context_synchronously
    return showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Availabilities",
                    style: TextStyle(color: Provider.of<ThemeProvider>(context).getDarkTheme ? Colors.white: Colors.black),
                  ),
                ]
              ),
              scrollable: true,
              content: SizedBox(
                height: 200,
                child: ListWheelScrollView(
                  itemExtent: 40,
                  children: availableAppointments.map((appointment) {
                    return ListTile(
                      title: FutureBuilder<String>(
                        future: mechanicController.getNameFromId(appointment.mechanicId),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            return Text("Error: ${snapshot.error}");
                          } else {
                            String mechanicName = snapshot.data ?? "";
                            return Text(
                              "${appointment.date} w/ $mechanicName",
                              style: TextStyle(color: Provider.of<ThemeProvider>(context).getDarkTheme ? Colors.white: Colors.black, fontSize: 15),
                            );
                          }
                        },
                      ),
                      onTap: () {
                        setDialogState(() {
                          selectedAppointment = appointment;
                        });
                      },
                    );
                  }).toList(),
                ),
              ),
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    OutlinedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                      ),
                      child: const Text("Cancel"),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () async {
                        if (selectedAppointment != null)
                        {
                          appointmentController.reserveAppointment(selectedAppointment!, Provider.of<UserProvider>(context, listen: false).id!);
                          Navigator.pop(context);
                          // ignore: use_build_context_synchronously
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MyApp()
                            )
                          );
                        }
                        else
                        {
                          Navigator.pop(context);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                      ),
                      child: const Text("Reserve"),
                    ),
                  ],
                ),
              ],
            );
          },
        );
      },
    );
  }
}