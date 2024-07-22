import 'package:client/providers/current_user_provider.dart';
import 'package:client/screens/add_user_screen/add_user_screen.dart';
import 'package:client/screens/home_screen/home_screen.dart';
import 'package:client/screens/user_list_screen/user_list_screen.dart';
import 'package:client/services/websocket_service.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'services/graphql_service.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:shared_preferences_web/shared_preferences_web.dart';

void registerPlugins(Registrar registrar) {
  SharedPreferencesPlugin.registerWith(registrar);
  registrar.registerMessageHandler();
}

void main() {
  registerPlugins(webPluginRegistrar);
  runApp(const ClimbrApp());
}

class ClimbrApp extends StatelessWidget {
  const ClimbrApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ValueNotifier<GraphQLClient>>(
      future: GraphQLService.initializeClient(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const MaterialApp(
            home: Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        }

        if (snapshot.hasError) {
          final error = snapshot.error;
          return MaterialApp(
            home: Scaffold(
              body: Center(
                child: Text(
                    'Error initializing GraphQL client: ${error.toString()}'),
              ),
            ),
          );
        }

        return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => CurrentUserProvider()),
            ChangeNotifierProvider(create: (context) => WebSocketService())
          ],
          child: GraphQLProvider(
            client: snapshot.data!,
            child: MaterialApp(
              title: 'Climbr',
              theme: ThemeData(
                primaryColor: const Color(0xFF2E7D32), // Forest Green
                highlightColor: const Color(0xFFFFA000), // Amber
                textTheme: GoogleFonts.openSansTextTheme(
                  Theme.of(context).textTheme,
                ),
              ),
              initialRoute: '/',
              routes: {
                // '/': (context) => const LoginPage(),
                '/': (context) => const HomeScreen(),
                // '/home': (context) => const HomeScreen(),
                '/user_list': (context) => const UserListScreen(),
                '/add_user': (context) => const AddUserScreen(),
              },
              debugShowCheckedModeBanner: false,
            ),
          ),
        );
      },
    );
  }
}
