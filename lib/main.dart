import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttersimplon/pages/home_page.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:fluttersimplon/theme.dart';

const firebaseConfig = {};

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: kIsWeb
          ? const FirebaseOptions(
              apiKey: "AIzaSyCUh4CyO3Zx4cOUqHniBeeRLpLsbxwWXvI",
              authDomain: "flutter-simplon.firebaseapp.com",
              projectId: "flutter-simplon",
              storageBucket: "flutter-simplon.appspot.com",
              messagingSenderId: "166030816604",
              appId: "1:166030816604:web:11f4bd8007ec12291efd99")
          : null);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Messagerie Simplon',
      theme: myTheme,
      initialRoute:
          FirebaseAuth.instance.currentUser == null ? '/sign-in' : '/home',
      routes: {
        '/sign-in': (_) {
          return SignInScreen(
            providers: [EmailAuthProvider()],
            actions: [
              AuthStateChangeAction<SignedIn>((context, state) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const HomePage()),
                );
              }),
            ],
          );
        },
        HomePage.name: (_) {
          return const HomePage();
        },
      },
    );
  }
}
