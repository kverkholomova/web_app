import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';



class SignUpApp extends StatelessWidget {
  const SignUpApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => const SignUpScreen(),
        '/welcome': (context) => const WelcomeScreen(),
      },
    );
  }
}

class SignUpScreen extends StatelessWidget {
  const SignUpScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.indigoAccent.withOpacity(0.2),
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.4,
          child: Card(
            child: SignUpForm(),
          ),
        ),
      ),
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigoAccent.withOpacity(0.2),
      body: Center(
        child:
        Text('Welcome!', style: GoogleFonts.oswald(
            color: Colors.indigoAccent,
            fontWeight: FontWeight.bold,
            fontSize: 60
        ),),
      ),
    );
  }
}

class SignUpForm extends StatefulWidget {
  const SignUpForm();

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _firstNameTextController = TextEditingController();
  final _lastNameTextController = TextEditingController();
  final _usernameTextController = TextEditingController();

  double _formProgress = 0;

  void _showWelcomeScreen() {
    Navigator.of(context).pushNamed('/welcome');
  }

  void _updateFormProgress() {
    var progress = 0.0;
    final controllers = [
      _firstNameTextController,
      _lastNameTextController,
      _usernameTextController
    ];

    for (final controller in controllers) {
      if (controller.value.text.isNotEmpty) {
        progress += 1 / controllers.length;
      }
    }

    setState(() {
      _formProgress = progress;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(

      onChanged: _updateFormProgress,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            LinearProgressIndicator(value: _formProgress, color: Colors.indigoAccent, backgroundColor: Colors.indigoAccent.withOpacity(0.15),),
            Text('Sign up', style: GoogleFonts.oswald(
                color: Colors.indigoAccent,
                fontWeight: FontWeight.bold,
                fontSize: 22
            ),),
            textField(_firstNameTextController, 'First name'),
            textField(_lastNameTextController, 'Last name'),
            textField(_usernameTextController, 'Username'),
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: TextFormField(
            //     controller: _firstNameTextController,
            //     decoration: InputDecoration(hintText: 'First name', hintStyle: GoogleFonts.oswald(
            //         color: Colors.black.withOpacity(0.6),
            //         fontSize: 18
            //     ),),
            //   ),
            // ),
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: TextFormField(
            //     controller: _lastNameTextController,
            //     decoration: InputDecoration(hintText: 'Last name', hintStyle: GoogleFonts.oswald(
            //         color: Colors.black.withOpacity(0.6),
            //         fontSize: 18
            //     ),),
            //   ),
            // ),
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: TextFormField(
            //     controller: _usernameTextController,
            //     decoration: InputDecoration(hintText: 'Username', hintStyle: GoogleFonts.oswald(
            //         color: Colors.black.withOpacity(0.6),
            //         fontSize: 18
            //     ),),
            //   ),
            // ),
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.02,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: MediaQuery.of(context).size.width * 0.05,
                width: double.infinity,
                child: TextButton(
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.resolveWith(
                            (Set<MaterialState> states) {
                          return states.contains(MaterialState.disabled)
                              ? Colors.white
                              : Colors.white;
                        }),
                    backgroundColor: MaterialStateProperty.resolveWith(
                            (Set<MaterialState> states) {
                          return states.contains(MaterialState.disabled)
                              ? Colors.indigoAccent.withOpacity(0.3)
                              : Colors.indigoAccent;
                        }),
                  ),
                  onPressed: _formProgress == 1 ? _showWelcomeScreen : null,
                  child: Text('Sign up',
                  style: GoogleFonts.oswald(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18
                  ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.02,
            ),
          ],
        ),
      ),
    );
  }

  Padding textField (TextEditingController textEditingController, String txt,  ) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: textEditingController,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hoverColor: Colors.indigoAccent.withOpacity(0.1),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.indigoAccent
            )
          ),
          hintText: txt,
          hintStyle: GoogleFonts.oswald(
            color: Colors.black.withOpacity(0.6),
            fontSize: 14
        ),),
      ),
    );
  }
}
