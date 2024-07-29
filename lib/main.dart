import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'dart:async';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyAXAbs_OJ7HqHEo0ENcjr1_oX_K1CFaeYg",
          authDomain: "thecoolappsmiths.firebaseapp.com",
          projectId: "thecoolappsmiths",
          storageBucket: "thecoolappsmiths.appspot.com",
          messagingSenderId: "815562933611",
          appId: "1:815562933611:web:bf60c930f1a23a8a06f82e",
          measurementId: "G-CTX5DDYBDH"));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple),
        useMaterial3: true,
      ),
      home: MyHomePage2(),
    );
  }
}

class MyHomePage2 extends StatefulWidget {
  @override
  State<MyHomePage2> createState() => _MyHomePageState2();
}

class _MyHomePageState2 extends State<MyHomePage2> {
  @override
  void initState() {
    super.initState();
    _startAutoSlide();
  }

  final PageController _pageController = PageController();
  Timer? _timer;
  final int _slideDuration = 3;
  void _startAutoSlide() {
    _timer = Timer.periodic(Duration(seconds: _slideDuration), (timer) {
      if (_pageController.hasClients) {
        int nextPage = (_pageController.page!.toInt() + 1) %
            3; // Change 3 to the number of pages
        _pageController.animateToPage(
          nextPage,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double screenWidth = mediaQueryData.size.width;
    double screenHeight = mediaQueryData.size.height;
    final CollectionReference fireStoreCollection =
        FirebaseFirestore.instance.collection('INFORMATION');
    final defaultFontSize = 18.0;
    final fontSize = (screenWidth ?? 0) > 800 ? 24.0 : defaultFontSize;

    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.purple,
            title: Center(
              child: Text("THE COOL APPSMITHS",
                  style: TextStyle(color: Colors.white, fontSize: fontSize)),
            )),
        body: SingleChildScrollView(
            child: Container(
          color: Colors.purple,
          child: Center(
              child: Column(
            children: [
              SizedBox(
                height: screenHeight * 0.05,
              ),
              Container(
                color: Color(0xffffffff),
                child: Center(
                    child: Text(
                  "MOBILE APPS CREATION SERVICES",
                  style: TextStyle(color: Colors.purple, fontSize: 20),
                )),
                width: screenWidth * 1,
                height: screenHeight * 0.4,
              ),
              Container(
                color: Colors.green,
                height: screenHeight * 1,
                width: screenWidth * 0.4,
                child: Text("SCROLLING VIEW"),
              ),
              SizedBox(
                height: screenHeight * 0.05,
              ),
              Container(
                width: screenWidth * 0.8,
                height: screenHeight * 0.3,
                margin: EdgeInsets.symmetric(
                    vertical: 8.0), // Optional: margin between tiles
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(
                      12.0), // Adjust the radius as needed
                  child: Container(
                    color: Colors.purple, // Background color of the ListTile
                    child: ListTile(
                      contentPadding:
                          EdgeInsets.all(16.0), // Padding inside the ListTile
                      title: Text(
                        "HAVE A FREE FIRST MEETING TO DISCUSS YOUR PROJECT AND GET A QUOTE. FOR SCHEDULING IT...",
                        style: TextStyle(
                          color: Colors.white, // Text color
                          fontSize: fontSize, // Text size
                          fontWeight: FontWeight.bold, // Optional: text weight
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  await showDialog(
                    context: context,
                    builder: (context) => ContactFormDialog(),
                  );
                },
                child: Text("GIVE US A WAY TO CONTACT YOU"),
              )
            ],
          )),
          width: screenWidth * 1,
          height: screenHeight * 1,
        )));
  }
}

class ContactFormDialog extends StatefulWidget {
  @override
  _ContactFormDialogState createState() => _ContactFormDialogState();
}

class _ContactFormDialogState extends State<ContactFormDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  String? _besttimeController;

  String? _timezone;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Contact Form"),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: "First Name"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your first name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _lastNameController,
                decoration: InputDecoration(labelText: "Last Name"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your last name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _phoneController,
                decoration: InputDecoration(labelText: "Phone with Area code"),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your phone number';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: "Email"),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              Text("Best Time to Contact"),
              SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(
                    labelText:
                        "Prefered time you wish to be contacted/prefered contact method"),
                onChanged: (value) {
                  _besttimeController = value;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(labelText: "Timezone/Country"),
                onChanged: (value) {
                  _timezone = value;
                },
              ),
            ],
          ),
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text("Cancel"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text("Submit"),
          onPressed: () async {
            if (_formKey.currentState?.validate() ?? false) {
              final userData = {
                'firstName': _nameController.text,
                'lastName': _lastNameController.text,
                'phone': _phoneController.text,
                'email': _emailController.text,
                'bestTime': _besttimeController,
                'timezone': _timezone,
              };

              // Send data to Firebase
              try {
                await FirebaseFirestore.instance
                    .collection('contacts')
                    .add(userData);
                Navigator.of(context).pop(); // Close the dialog
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Data submitted successfully!')),
                );
              } catch (e) {
                print("Error adding document: $e");
              }
            }
          },
        ),
      ],
    );
  }
}
