import 'package:client/models/user.dart';
import 'package:client/screens/find_partner_screen/find_partner_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final userProvider = Provider.of<CurrentUserProvider>(context);
    // final user = userProvider.user;

    final CurrentUser user =
        CurrentUser(id: 1, name: 'John Doe', email: 'test@gmail.com');

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: Text('Climbr',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.8,
                  )),
        ),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text('Welcome to Climbr!'),
            ),
            Center(
                child: user != null
                    ? Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text('Welcome back, ${user.name}!'),
                              const SizedBox(height: 10),
                              Text('Name: ${user.name}'),
                              Text('Email: ${user.email}'),
                            ]))
                    : const Text('Welcome!')),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Navigator.pushNamed(context, '/find_partner');
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const FindPartnerScreen(),
                          ));
                    },
                    child: const Text('Find Partner'),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/user_list');
                    },
                    child: const Text('User List'),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/profile');
                    },
                    child: const Text('Profile'),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/settings');
                    },
                    child: const Text('Settings'),
                  ),
                ],
              ),
            ),
          ],
        )));
  }
}
