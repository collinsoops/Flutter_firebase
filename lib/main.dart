import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebaseauth/screens/auth_screen.dart';
import 'package:firebaseauth/screens/chat_screen.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase',
      theme: ThemeData(
          primarySwatch: Colors.lightGreen,
          backgroundColor: Colors.pinkAccent,
          accentColorBrightness: Brightness.dark,
          accentColor: Colors.deepPurple,
          buttonTheme: ButtonTheme.of(context).copyWith(
              buttonColor: Colors.pink,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              textTheme: ButtonTextTheme.primary)),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ChatScreen();
          }
          return AuthScreen();
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: AuthScreen(),
    );
  }
}
