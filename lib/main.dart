import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';

import 'cache_provider.dart';
import 'database.dart';
import 'hive_service.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:auto_size_text/auto_size_text.dart';

import 'package:firedart/firedart.dart';
import 'package:firedart/auth/user_gateway.dart';

import 'loadFromFB.dart';
import 'dart:ui';

late Future<String> _hiveInitialized; // Ορίστικε String για το Futurebuilder

int indexNav = 2;
String msg = "";
//bool signInPressed = false;

const apiKey = "AIzaSyBq53JubRCINsc-g6sKgA-fjUVE2l2ruTw";
const projectId = "atlantas-e5e5e";

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp();
  Firestore.initialize(projectId);
  FirebaseAuth.initialize(apiKey, VolatileStore());

  initSettings().then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ATLANTAS XML',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Atlantas XML'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
      Settings.setValue('counter', _counter);
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (HiveService().isHiveOk == false) {
      _hiveInitialized = isHiveInitialized().catchError((error) async {
        debugPrint('catch ERROR $error');
        String errorMsg = error;
        debugPrint(errorMsg);
        await showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text(
              'Μη αναμενόμενο σφάλμα!',
              style: TextStyle(color: Colors.black),
            ),
            content: Text(
              'Σφάλμα: "$errorMsg"',
              style: TextStyle(color: Colors.black),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Συνέχεια'),
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
              )
            ],
          ),
        );
        return errorMsg;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    TextEditingController _emailTextController = TextEditingController();
    TextEditingController _passwordTextController = TextEditingController();
    // if (Settings.isInitialized == true) {
    //   if (Settings.containsKey('counter') == false) {
    //     Settings.setValue('counter', 10);
    //   } else {
    //     _counter = Settings.getValue('counter', 10);
    //   }
    // }
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 17, 21, 24),
        // appBar: AppBar(
        //   backgroundColor: const Color.fromARGB(255, 16, 82, 249),
        //   // Here we take the value from the MyHomePage object that was created by
        //   // the App.build method, and use it to set our appbar title.
        //   title: Text(widget.title),
        // ),
        body: Column(
          children: [
            //Expanded(flex: 1, child: Container()),
            Expanded(
              flex: 4,
              child: Row(
                children: [
                  //Expanded(flex: 1, child: Container()),
                  Expanded(
                    flex: 4,
                    child: Container(
                      color: const Color.fromARGB(255, 17, 21, 24),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(flex: 1, child: Container()),
                            Expanded(
                              flex: 2,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  //Expanded(flex: 1, child: Container()),
                                  Expanded(
                                      flex: 1,
                                      child: Image.asset(
                                          "assets/img/firebase.png")),
                                  Expanded(
                                    flex: 4,
                                    child: AutoSizeText(
                                      (msg == "")
                                          ? "SIGN IN USING FIREBASE"
                                          : msg,
                                      style: TextStyle(
                                          color: (msg == "")
                                              ? const Color.fromARGB(
                                                  255, 16, 82, 249)
                                              : Colors.red,
                                          fontSize: (msg == "") ? 35 : 20),
                                      maxFontSize: 35,
                                      minFontSize: 5,
                                      maxLines: (msg == "") ? 1 : 10,
                                      overflowReplacement:
                                          Text('Sorry String too long'),
                                    ),
                                  ),
                                  //Expanded(flex: 1, child: Container()),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Container(),
                                  ),
                                  Expanded(
                                    flex: 5,
                                    child: TextFormField(
                                      style:
                                          const TextStyle(color: Colors.white),
                                      textInputAction: TextInputAction.next,
                                      decoration: InputDecoration(
                                          enabledBorder:
                                              const UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color.fromARGB(
                                                    255, 16, 82, 249)),
                                          ),
                                          focusedBorder:
                                              const UnderlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.white),
                                          ),
                                          hintText: "Type your email here..",
                                          hintStyle: TextStyle(
                                              color: Colors.white
                                                  .withOpacity(0.5))),

                                      controller: _emailTextController,
                                      //focusNode: _focusEmail,
                                      validator: (value) =>
                                          Validator.validateEmail(
                                              email: value!),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Container(),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(),
                            ),
                            Expanded(
                              flex: 2,
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Container(),
                                  ),
                                  Expanded(
                                    flex: 5,
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                          enabledBorder:
                                              const UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color.fromARGB(
                                                    255, 16, 82, 249)),
                                          ),
                                          focusedBorder:
                                              const UnderlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.white),
                                          ),
                                          hintText: "Type your password here..",
                                          hintStyle: TextStyle(
                                              color: Colors.white
                                                  .withOpacity(0.5))),
                                      textInputAction: TextInputAction.done,
                                      style:
                                          const TextStyle(color: Colors.white),
                                      controller: _passwordTextController,
                                      //focusNode: _focusPassword,
                                      obscureText: true,
                                      validator: (value) =>
                                          Validator.validatePassword(
                                              password: value!),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Container(),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(),
                            ),
                            Expanded(
                              flex: 2,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Container(),
                                  ),
                                  Expanded(
                                    flex: 5,
                                    child: ElevatedButton(
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  const Color.fromARGB(
                                                      255, 16, 82, 249))),
                                      onPressed: () async {
                                        if (_formKey.currentState!.validate()) {
                                          User? user = await FireAuth
                                              .signInUsingEmailPassword(
                                                  email:
                                                      _emailTextController.text,
                                                  password:
                                                      _passwordTextController
                                                          .text,
                                                  context: context);
                                          setState(() {});
                                          if (user != null) {
                                            print(user.id);

                                            DocumentReference usersDB =
                                                await Firestore.instance
                                                    .collection(user.id)
                                                    .document("Products");
                                            SQLHelper.userFB = usersDB;
                                            //await usersDB.delete();
                                            Navigator.pushReplacement(
                                              context,
                                              PageRouteBuilder(
                                                pageBuilder: (context,
                                                        animation1,
                                                        animation2) =>
                                                    FBLoad(
                                                  userDB: usersDB,
                                                ),
                                                transitionDuration:
                                                    Duration.zero,
                                                reverseTransitionDuration:
                                                    Duration.zero,
                                              ),
                                            );
                                          }
                                        }
                                      },
                                      child: const Text(
                                        'Sign In',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Container(),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  //Expanded(flex: 1, child: Container()),
                ],
              ),
            ),
            //Expanded(flex: 1, child: Container()),
          ],
        ),
      ),
      // bottomNavigationBar: CurvedNavigationBar(
      //   index: indexNav,
      //   backgroundColor: const Color.fromARGB(255, 17, 21, 24),
      //   color: const Color.fromARGB(255, 16, 82, 249),
      //   buttonBackgroundColor: const Color.fromARGB(255, 16, 82, 249),
      //   animationDuration: const Duration(milliseconds: 300),
      //   items: const <Widget>[
      //     Icon(
      //       Icons.add,
      //       size: 30,
      //       color: Colors.white,
      //     ),
      //     Icon(
      //       Icons.list,
      //       size: 30,
      //       color: Colors.white,
      //     ),
      //     Icon(
      //       Icons.compare_arrows,
      //       size: 30,
      //       color: Colors.white,
      //     ),
      //   ],
      //   onTap: (index) {
      //     if (index != index) {
      //       setState(() {
      //         indexNav = index;
      //       });
      //     }
      //   },
      //   height: 60,
      // ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

Future<void> initSettings() async {
  await Settings.init(
    cacheProvider: HiveCache(),
  );
}

Future<String> isHiveInitialized() async {
  if (HiveService().isHiveOk == false) {
    await HiveService().setHiveInitialVals();

    // throw ('Δοκιμή λάθους');
    return Settings.isInitialized.toString();
  }
  return HiveService().isHiveOk.toString();
}

class Validator {
  static String? validateName({required String name}) {
    if (name == null) {
      return null;
    }
    if (name.isEmpty) {
      return 'Name can\'t be empty';
    }

    return null;
  }

  static String? validateEmail({required String email}) {
    if (email == null) {
      return null;
    }
    RegExp emailRegExp = RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");

    if (email.isEmpty) {
      return 'Email can\'t be empty';
    } else if (!emailRegExp.hasMatch(email)) {
      return 'Enter a correct email';
    }

    return null;
  }

  static String? validatePassword({required String password}) {
    if (password == null) {
      return null;
    }
    if (password.isEmpty) {
      return 'Password can\'t be empty';
    } else if (password.length < 6) {
      return 'Enter a password with length at least 6';
    }

    return null;
  }
}

class FireAuth {
  // static Future<User?> registerUsingEmailPassword({
  //   required String name,
  //   required String email,
  //   required String password,
  // }) async {
  //   FirebaseAuth auth = FirebaseAuth.instance;
  //   User? user;
  //   try {
  //     UserCredential userCredential = await auth.createUserWithEmailAndPassword(
  //       email: email,
  //       password: password,
  //     );
  //     user = userCredential.user;
  //     await user!.updateProfile(displayName: name);
  //     await user.reload();
  //     user = auth.currentUser;
  //   } on FirebaseAuthException catch (e) {
  //     if (e.code == 'weak-password') {
  //       print('The password provided is too weak.');
  //     } else if (e.code == 'email-already-in-use') {
  //       print('The account already exists for that email.');
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  //   return user;
  // }

  static Future<User?> signInUsingEmailPassword({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    //Firestore.initialize(projectId);
    var auth = FirebaseAuth.instance;
    User? user2;
    // FirebaseAuth.initialize(apiKey, VolatileStore());
    // Firestore.initialize(projectId); // Firestore reuses the auth client
    try {
      // Monitor sign-in state
      // auth.signInState
      //     .listen((state) => print("Signed ${state ? "in" : "out"}"));

      // Sign in with user credentials
      await auth.signIn(email, password);

      // Get user object
      var user = await auth.getUser();

      var ref = Firestore.instance.collection('test').document('doc');

      // Subscribe to changes to that document
      ref.stream.listen((document) => print('updated: $document'));

      // Update the document
      await ref.update({'value': 'test'});

      // Get a snapshot of the document
      var document = await ref.get();
      print('snapshot: ${document['value']}');

      auth.signOut();

      // Allow some time to get the signed out event
      await Future.delayed(Duration(seconds: 1));
      print(user);
      return user;
    } catch (e) {
      msg = e.toString();
      //print(e);

    }
    return user2;
    //return user;
  }

  //return user;
}
