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
      backgroundColor: Colors.white,
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
            AnimatedProgressIndicator(value: _formProgress),
            // LinearProgressIndicator(value: _formProgress, color: Colors.indigoAccent, backgroundColor: Colors.indigoAccent.withOpacity(0.15),),
            Text('Sign up', style: GoogleFonts.oswald(
                color: Colors.indigoAccent,
                fontWeight: FontWeight.bold,
                fontSize: 22
            ),),
            textField(_firstNameTextController, 'First name'),
            textField(_lastNameTextController, 'Last name'),
            textField(_usernameTextController, 'Username'),
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

class AnimatedProgressIndicator extends StatefulWidget {
  final double value;

  const AnimatedProgressIndicator({
    required this.value,
  });

  @override
  State<AnimatedProgressIndicator> createState() {
    return _AnimatedProgressIndicatorState();
  }
}

class _AnimatedProgressIndicatorState extends State<AnimatedProgressIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _colorAnimation;
  late Animation<double> _curveAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: Duration(milliseconds: 1200), vsync: this);

    final colorTween = TweenSequence([
      TweenSequenceItem(
        tween: ColorTween(begin: Colors.indigo[100], end: Colors.indigo[400]),
        weight: 1,
      ),
      TweenSequenceItem(
        tween: ColorTween(begin: Colors.indigo[400], end: Colors.indigo),
        weight: 1,
      ),
      TweenSequenceItem(
        tween: ColorTween(begin: Colors.indigo, end: Colors.indigo[900]),
        weight: 1,
      ),
    ]);

    _colorAnimation = _controller.drive(colorTween);
    _curveAnimation = _controller.drive(CurveTween(curve: Curves.easeIn));
  }

  @override
  void didUpdateWidget(oldWidget) {
    super.didUpdateWidget(oldWidget);
    _controller.animateTo(widget.value);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) => LinearProgressIndicator(
        value: _curveAnimation.value,
        valueColor: _colorAnimation,
        backgroundColor: _colorAnimation.value?.withOpacity(0.4),
      ),
    );
  }
}
