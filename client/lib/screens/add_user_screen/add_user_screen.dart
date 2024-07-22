import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:client/screens/add_user_screen/createUser.graphql.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'package:client/screens/add_user_screen/form_fields.dart';

class AddUserScreen extends HookWidget {
  const AddUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = useTextEditingController();
    final nameController = useTextEditingController();
    final passwordController = useTextEditingController();
    final loading = useState(false);
    final client = useGraphQLClient();

    Future<void> createUser() async {
      loading.value = true;
      final MutationOptions options = MutationOptions(
        document: documentNodeMutationCreateUser,
        variables: {
          'params': {
            'email': emailController.text,
            'name': nameController.text,
            'password': passwordController.text,
          },
        },
      );

      try {
        final QueryResult result = await client.mutate(options);

        if (!context.mounted) return;

        if (result.hasException) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${result.exception.toString()}')),
          );
        } else if (result.data != null) {
          final responseData = result.data!;
          print('User created: $responseData');
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('User created successfully!')),
          );
          Navigator.pushNamed(context, '/user_list');
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('No data received')),
          );
        }
      } finally {
        loading.value = false;
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Add User',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.8,
                )),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            FormFieldsWidget(
              emailController: emailController,
              nameController: nameController,
              passwordController: passwordController,
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: loading.value ? null : createUser,
              child: loading.value
                  ? const CircularProgressIndicator()
                  : const Text('Create User'),
            ),
          ],
        ),
      ),
    );
  }
}
