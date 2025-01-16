import 'package:auth0_flutter/auth0_flutter.dart';
import 'package:flutter/material.dart';
import 'package:garageauto/constants/theme_data.dart';
import 'package:garageauto/controllers/appointment_controller.dart';
import 'package:garageauto/controllers/mechanic_controller.dart';
import 'package:garageauto/controllers/providers/theme_provider.dart';
import 'package:garageauto/controllers/user_controller.dart';
import 'package:garageauto/database/database.dart';
import 'package:garageauto/models/appointment.dart';
import 'package:garageauto/models/mechanic.dart';
import 'package:garageauto/views/home.dart';
import 'package:garageauto/views/login.dart';
import 'package:garageauto/views/parameters.dart';
import 'package:provider/provider.dart';
import 'package:garageauto/controllers/providers/user_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(
            Auth0('dev-brvejdsxrja4lmq1.us.auth0.com', 'GkwKL3j74UaafFgVzd9niap0oGELV6qk'),
            UserController()
          )
        )
      ],
      child: const MyApp(),
    )
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeProvider themeProvider = ThemeProvider();

  void getCurrentTheme() async {
    themeProvider.setDarkTheme = await themeProvider.themeController.getTheme();
  }

  @override
  void initState() {
    getCurrentTheme();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) {
          return themeProvider;
        })
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Mike\'s Workshop',
            theme: Styles.themeData(context, themeProvider.getDarkTheme),
            home: ChangeNotifierProvider.value(
              value: userProvider,
              child: const MyHomePage(title: 'Mike\'s Workshop'),
            )
          );
        }
      )
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final DatabaseHandler _databaseHandler = DatabaseHandler();
  bool _isLoading = true;

  final MechanicController _mechanicController = MechanicController();
  final AppointmentController _appointmentController = AppointmentController();

  List<Mechanic> mechanics = [];
  List<Appointment> appointments = [];

  @override
  void initState() {
    super.initState();
    if (_databaseHandler.database == null) {
      _isLoading = true;
      _initDatabase();
    } else {
      _isLoading = false;
    }
  }

  void _initDatabase() async {
    await _databaseHandler.initDb();
    List<Mechanic> mechanicsList = await _mechanicController.getMechanics();
    List<Appointment> appointmentsList = await _appointmentController.getAppointments();

    setState(() {
      _isLoading = false;
      mechanics = mechanicsList;
      appointments = appointmentsList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(
          Provider.of<UserProvider>(context).isLoggedIn ? widget.title : '',
          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)
        ),
        actions: [
          if (Provider.of<UserProvider>(context).isLoggedIn)
            IconButton(
              icon: const Icon(Icons.logout_rounded, size: 24),
              color: Colors.white,
              onPressed: () async {
                await Provider.of<UserProvider>(context, listen: false).logoutAction();
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
      body: Consumer<UserProvider>(
        builder: (context, userProvider, child) {
          return Center(
            child: _isLoading || userProvider.isAuthenticating
                ? const CircularProgressIndicator()
                : userProvider.isLoggedIn
                ? Home(appointments: appointments)
                : const Login(),
          );
        },
      ),
    );
  }
}
