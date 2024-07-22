import 'package:client/models/user.dart';
import 'package:client/providers/current_user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends HookWidget {
  const LoginPage({super.key});

  void _loginUser(BuildContext context, CurrentUser user) {
    Provider.of<CurrentUserProvider>(context, listen: false).setUser(user);
    Navigator.pushReplacementNamed(context, '/home');
  }

  void _loginError(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Invalid email or password'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final isLoading = useState(false);

    Future<void> login() async {
      isLoading.value = true;

      final String email = emailController.text;
      final String password = passwordController.text;

      final response = await http.post(
        Uri.parse('http://localhost:3001/login'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': email,
          'password': password,
        }),
      );

      isLoading.value = false;

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseBody = jsonDecode(response.body);
        final String token = responseBody['token'];
        final Map<String, dynamic> user = responseBody['user'];

        // Store token and user information using shared_preferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);
        await prefs.setString('user', jsonEncode(user));

        // Useing addPostFrameCallback to ensure that the user is logged in before navigating to the home screen
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _loginUser(context, CurrentUser.fromJson(user));
        });
      } else {
        // Useing addPostFrameCallback to ensure that the error message is displayed after the login button is pressed
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _loginError(context);
        });
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: isLoading.value
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(labelText: 'Email'),
                  ),
                  TextFormField(
                    controller: passwordController,
                    decoration: const InputDecoration(labelText: 'Password'),
                    obscureText: true,
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: login,
                    child: const Text('Login'),
                  ),
                ],
              ),
            ),
    );
  }
}
