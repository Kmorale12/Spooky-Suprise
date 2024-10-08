import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FadingTextAnimation(),
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.black, // Set the AppBar background color to black
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 20), // Set the title text color to white
        ),
      ),
    );
  }
}

class FadingTextAnimation extends StatefulWidget {
  @override
  _FadingTextAnimationState createState() => _FadingTextAnimationState();
}

class _FadingTextAnimationState extends State<FadingTextAnimation> with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  )..repeat(reverse: true);

  late final Animation<Offset> _offsetAnimation = Tween<Offset>(
    begin: Offset.zero,
    end: const Offset(1.5, 0.0), // Horizontal movement for bats
  ).animate(CurvedAnimation(
    parent: _controller,
    curve: Curves.elasticIn,
  ));

  late final AnimationController _scarecrowController = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  )..repeat(reverse: true);

  late final Animation<Offset> _scarecrowAnimation = Tween<Offset>(
    begin: Offset.zero,
    end: const Offset(1.5, 1.5), // Diagonal movement for scarecrow
  ).animate(CurvedAnimation(
    parent: _scarecrowController,
    curve: Curves.elasticIn,
  ));

  late AnimationController _animationController;

  bool _first = true;
  bool _found = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    )..repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _controller.dispose();
    _scarecrowController.dispose();
    super.dispose();
  }

  void toggleVisibility() {
    setState(() {
      _first = !_first;
    });
  }

  void _onTrapTap() {
    // Handle trap tap without sound
  }

  void _onCorrectItemTap() {
    setState(() { //when a user taps the correct item, the _found variable is set to true
      _found = true;
    });
    // Handle correct item tap without sound
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Spooky App'),
      ),
      body: Container(
        color: Colors.deepOrange[900], // Halloween-themed background color
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                if (_found)
                  Text(
                    'You Found It!',
                    style: TextStyle(fontSize: 24, color: Colors.green),
                  ),
                GestureDetector(
                  onTap: () {
                    _animationController.isAnimating
                        ? _animationController.stop()
                        : _animationController.repeat();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RotationTransition(
                            child: Image.asset('assets/jack.png', height: 150, width: 150),
                            alignment: Alignment.center,
                            turns: _animationController,
                          ),
                          SizedBox(height: 20),
                          SlideTransition(
                            position: _offsetAnimation,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset('assets/bats.png', height: 150, width: 150),
                            ),
                          ),
                          SizedBox(height: 20),
                          GestureDetector(
                            onTap: _onTrapTap,
                            child: SlideTransition(
                              position: _scarecrowAnimation,
                              child: Image.asset('assets/scarecrow.png', height: 150, width: 150),
                            ),
                          ),
                          SizedBox(height: 20),
                          GestureDetector(
                            onTap: _onCorrectItemTap,
                            child: Image.asset('assets/tree.png', height: 150, width: 150),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: toggleVisibility,
        child: Icon(Icons.play_arrow),
      ),
    );
  }
}