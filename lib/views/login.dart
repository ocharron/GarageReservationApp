import 'package:flutter/material.dart';
import 'package:garageauto/controllers/providers/theme_provider.dart';
import 'package:garageauto/controllers/providers/user_provider.dart';
import 'package:garageauto/views/home.dart';
import 'package:provider/provider.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<ThemeProvider>(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Mike's Workshop", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 36)),
        Align(
          alignment: Alignment.topCenter,
          child: Image.asset(
            themeState.getDarkTheme ? 'lib/img/logo.png': 'lib/img/logo_black.png',
            width: 280,
            height: 280,
          ),
        ),
        const SizedBox(height: 100),
        ElevatedButton(
          onPressed: () async {
            await Provider.of<UserProvider>(context, listen: false).loginAction();
            // ignore: use_build_context_synchronously
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Home()),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            foregroundColor: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))
          ),
          child: const Text("Sign In")
        ),
        Consumer<UserProvider>(
          builder: (context, userProvider, child) {
            return Text(userProvider.errorMessage);
          },
        ),
      ],
    );
  }
}
