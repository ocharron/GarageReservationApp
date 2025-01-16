import 'package:flutter/material.dart';
import 'package:garageauto/controllers/providers/theme_provider.dart';
import 'package:garageauto/controllers/providers/user_provider.dart';
import 'package:provider/provider.dart';

class Parameters extends StatefulWidget {
  const Parameters({Key? key}) : super(key: key);

  @override
  State<Parameters> createState() => _ParametersState();
}

class _ParametersState extends State<Parameters> {
  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(
          Provider.of<UserProvider>(context).isLoggedIn ? "Mike's Workshop" : "",
          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)
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
            )
        ]
      ),
      body: Column(children: [
        const Padding(padding: EdgeInsets.only(bottom: 10)),
        AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            "Parameters",
            style: TextStyle(color: themeState.getDarkTheme ? Colors.white : Colors.black)
          )
        ),
        Center(
          child: SwitchListTile(
            title: const Text("Theme"),
            secondary: Icon(
              themeState.getDarkTheme ? Icons.dark_mode_rounded : Icons.light_mode_rounded
            ),
            onChanged: (bool value) {
              setState(() {
                themeState.setDarkTheme = value;
              });
            },
            value: themeState.getDarkTheme
          )
        )
      ])
    );
  }
}