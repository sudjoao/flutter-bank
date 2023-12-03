import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:my_bank/widgets/obscure_text.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final LocalAuthentication auth = LocalAuthentication();
  bool obscureText = true;

  Future<void> onPressed() async {
    if (obscureText) {
      final bool authenticated = await _authenticate();
      if (authenticated) {
        setState(() {
          obscureText = false;
        });
        return;
      }
    }

    setState(() {
      obscureText = true;
    });
  }

  @override
  void initState() {
    super.initState();
    _authenticate();
  }

  Future<bool> _authenticate() async {
    final bool canAuthenticateWithBiometrics = await auth.canCheckBiometrics;
    final List<BiometricType> availableBiometrics =
        await auth.getAvailableBiometrics();
    final bool canAuthenticate =
        canAuthenticateWithBiometrics || await auth.isDeviceSupported();

    if (canAuthenticate) {
      if (availableBiometrics.contains(BiometricType.face)) {
        bool success = await auth.authenticate(
          localizedReason: 'Please authenticate to show account balance',
          options: const AuthenticationOptions(biometricOnly: true),
        );
        return success;
      } else if (availableBiometrics.contains(BiometricType.fingerprint)) {
        bool success = await auth.authenticate(
          localizedReason: 'Please authenticate to show account balance',
          options: const AuthenticationOptions(biometricOnly: true),
        );
        return success;
      } else {
        bool success = await auth.authenticate(
          localizedReason: 'Please authenticate to show account balance',
          options: const AuthenticationOptions(stickyAuth: true),
        );
        return success;
      }
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('My Bank'),
        actions: [
          IconButton(
              onPressed: onPressed,
              icon: obscureText
                  ? const Icon(Icons.visibility_off)
                  : const Icon(Icons.visibility))
        ],
      ),
      body: Center(
        child: ObscureText(
          'Welcome to My Bank!',
          style: const TextStyle(fontSize: 24),
          obscureText: obscureText,
        ),
      ),
    );
  }
}
