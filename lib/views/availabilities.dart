import 'package:flutter/material.dart';
import 'package:garageauto/controllers/appointment_controller.dart';
import 'package:garageauto/controllers/mechanic_controller.dart';
import 'package:garageauto/controllers/providers/theme_provider.dart';
import 'package:garageauto/controllers/providers/user_provider.dart';
import 'package:garageauto/controllers/user_controller.dart';
import 'package:garageauto/models/appointment.dart';
import 'package:garageauto/models/mechanic.dart';
import 'package:garageauto/views/parameters.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class Availabilities extends StatefulWidget {
  const Availabilities({Key? key}) : super(key: key);

  @override
  State<Availabilities> createState() => _AvailabilitiesState();
}

class _AvailabilitiesState extends State<Availabilities> {
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  late Function setDialogStateCreateAvailabilityReference;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Widget>(
      future: _buildPage(context),
      builder: (BuildContext context, AsyncSnapshot<Widget> snapshot) {
        return Scaffold(
          body: Center(child: snapshot.data)
        );
      }
    );
  }

  Future<Widget> _buildPage(BuildContext context) async {
    final themeState = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text(
          "Mike's Workshop",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)
        ),
        actions: [
          if (Provider.of<UserProvider>(context).isLoggedIn)
            IconButton(
              icon: const Icon(Icons.logout_rounded, size: 24),
              color: Colors.white,
              onPressed: () async {
                await Provider.of<UserProvider>(context, listen: false).logoutAction();
                // ignore: use_build_context_synchronously
                Navigator.pop(context);
              }
            ),
          if (Provider.of<UserProvider>(context).isLoggedIn)
            IconButton(
              icon: const Icon(Icons.settings, size: 24),
              color: Colors.white,
              onPressed: () async {
                setState(() {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Parameters(),
                    ),
                  );
                });
              }
            ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(padding: EdgeInsets.only(bottom: 10)),
            AppBar(
              automaticallyImplyLeading: false,
              title: Text(
                "Availabilities", style: TextStyle(color: themeState.getDarkTheme ? Colors.white : Colors.black)
              ),
              actions: [
                IconButton(
                  key: const Key("AddAvailabilitiesButton"),
                  icon: Icon(
                    Icons.add,
                    size: 32,
                    color: themeState.getDarkTheme ? Colors.white : Colors.black,
                  ),
                  onPressed: () {
                    createAvailability(context);
                  },
                )
              ]
            ),
            const Padding(padding: EdgeInsets.only(bottom: 10)),
            FutureBuilder(
              future: listAvailabilities(),
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
    );
  }

  Future<Widget?> listAvailabilities() async {
    final scrollController = ScrollController();
    final appointmentController = AppointmentController();
    final mechanicController = MechanicController();
    final userController = UserController();
    final themeState = Provider.of<ThemeProvider>(context);

    Future<List<Appointment>>? availabilitiesList = appointmentController.getAppointments();
    List<Appointment> availabilities = await availabilitiesList;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: themeState.getDarkTheme ? const Color.fromARGB(255, 58, 51, 46) : const Color.fromARGB(255, 199, 198, 198),
      ),
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.all(0),
      child: SizedBox(
        child: Scrollbar(
          thumbVisibility: false,
          controller: scrollController,
          thickness: 5,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
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
                          color: themeState.getDarkTheme ? Colors.white : Colors.black,
                          fontSize: 16
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
                          color: themeState.getDarkTheme ? Colors.white : Colors.black,
                          fontSize: 16
                        ),
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Expanded(
                      child: Text(
                        "Client",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: themeState.getDarkTheme ? Colors.white : Colors.black,
                          fontSize: 16
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
                rows: availabilities.expand((availability) {
                  return [
                    DataRow(
                      key: ValueKey(availability.id.toString()),
                      cells: <DataCell>[
                        DataCell(
                          Text(
                            availability.date,
                            style: TextStyle(
                              color: themeState.getDarkTheme ? Colors.white : Colors.black
                            ),
                          )
                        ),
                        DataCell(
                          FutureBuilder<String>(
                            future: mechanicController.getNameFromId(availability.mechanicId),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return const CircularProgressIndicator();
                              } else if (snapshot.hasError) {
                                return Text("Error: ${snapshot.error}");
                              } else {
                                return Text(
                                  snapshot.data ?? "",
                                  style: TextStyle(color: themeState.getDarkTheme ? Colors.white : Colors.black),
                                );
                              }
                            },
                          ),
                        ),
                        DataCell(
                          availability.userId != null
                            ? FutureBuilder<String>(
                                future: userController.getNameFromId(availability.userId!),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState == ConnectionState.waiting) {
                                    return const CircularProgressIndicator();
                                  } else if (snapshot.hasError) {
                                    return Text("Error: ${snapshot.error}");
                                  } else {
                                    return Text(
                                      snapshot.data ?? "",
                                      style: TextStyle(color: themeState.getDarkTheme ? Colors.white : Colors.black),
                                    );
                                  }
                                },
                              )
                            : Text(
                                "N/A",
                                style: TextStyle(color: themeState.getDarkTheme ? Colors.white : Colors.black),
                              ),
                        ),
                        DataCell(
                          IconButton(
                            key: const Key("DeleteAvailabilityButton"),
                            icon: Icon(
                              Icons.close,
                              size: 20,
                              color: themeState.getDarkTheme ? Colors.white : Colors.black,
                            ),
                            onPressed: () {
                              deleteAvailability(context, availability);
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

  Future<void> createAvailability(BuildContext context) async {
    MechanicController mechanicController = MechanicController();
    AppointmentController appointmentController = AppointmentController();

    List<Mechanic>? mechanics = await mechanicController.getMechanics();
    List<String> mechanicsName = mechanics.map((mechanic) => mechanic.name).toList();

    String selectedMechanic = mechanicsName.isNotEmpty ? mechanicsName.first : "";

    // ignore: use_build_context_synchronously
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setDialogState) {
          setDialogStateCreateAvailabilityReference = setDialogState;

          return AlertDialog(
            title: Center(
              child: Text(
                "New Availability",
                style: TextStyle(
                  color: Provider.of<ThemeProvider>(context).getDarkTheme ? Colors.white : Colors.black,
                ),
              ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Date: ${DateFormat('yyyy-MM-dd').format(selectedDate)}",
                        style: TextStyle(
                          color: Provider.of<ThemeProvider>(context).getDarkTheme ? Colors.white : Colors.black,
                          fontSize: 16
                        ),
                      )
                    ),
                    IconButton(
                      icon: const Icon(Icons.calendar_today),
                      onPressed: () => _selectDate(context),
                      color: Provider.of<ThemeProvider>(context).getDarkTheme ? Colors.white : Colors.black
                    )
                  ]
                ),
                Row(
                  children: [
                    Expanded(
                    child: Text(
                        "Time: ${DateFormat('HH:mm').format(DateTime(2023, 1, 1, selectedTime.hour, selectedTime.minute))}",
                        style: TextStyle(
                          color: Provider.of<ThemeProvider>(context).getDarkTheme ? Colors.white : Colors.black,
                          fontSize: 16
                        ),
                      )
                    ),
                    IconButton(
                      icon: const Icon(Icons.access_time),
                      onPressed: () => _selectTime(context),
                      color: Provider.of<ThemeProvider>(context).getDarkTheme ? Colors.white : Colors.black
                    )
                  ]
                ),
                DropdownButton<String>(
                  value: selectedMechanic,
                  style: TextStyle(
                    color: Provider.of<ThemeProvider>(context).getDarkTheme ? Colors.white : Colors.black,
                    fontSize: 16
                  ),
                  hint: const Text("Mechanic"),
                  onChanged: (String? newValue) {
                    setDialogState(() {
                      selectedMechanic = newValue!;
                    });
                  },
                  items: mechanicsName.map<DropdownMenuItem<String>>(
                    (String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    },
                  ).toList(),
                ),
              ],
            ),
            actions: [
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
                      child: const Text("Cancel")
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: OutlinedButton(
                      onPressed: () async {
                        appointmentController.addAppointment(
                          selectedMechanic,
                          DateFormat('yyyy-MM-dd').format(selectedDate),
                          DateFormat('HH:mm').format(DateTime(2023, 1, 1, selectedTime.hour, selectedTime.minute))
                        );
                        Navigator.pop(context);
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Availabilities()
                          )
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))
                      ),
                      child: const Text("Create")
                    )
                  )
                ]
              )
            ],
          );
        });
      }
    );
  }

  Future<void> deleteAvailability(BuildContext context, Appointment appointment) async {
    AppointmentController appointmentController = AppointmentController();

    return showDialog(
      context: context,
      builder: (context) {
        
        return AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Are you sure?",
                style: TextStyle(color: Provider.of<ThemeProvider>(context).getDarkTheme ? Colors.white : Colors.black)
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
                  "Are you sure you want to delete this availability?",
                  style: TextStyle(color: Provider.of<ThemeProvider>(context).getDarkTheme ? Colors.white : Colors.black)
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
                          appointmentController.deleteAppointment(appointment);
                          Navigator.pop(context);
                          // ignore: use_build_context_synchronously
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Availabilities()
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

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != selectedDate) {
      setDialogStateCreateAvailabilityReference(() {
        selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
    );

    if (picked != null && picked != selectedTime) {
      setDialogStateCreateAvailabilityReference(() {
        selectedTime = picked;
      });
    }
  }
}