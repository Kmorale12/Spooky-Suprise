import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
    Widget build(BuildContext context) {
    return MaterialApp(
      home: FadingTextAnimation(),
    );
  }
}




class FadingTextAnimation extends StatefulWidget {
@override
_FadingTextAnimationState createState() => _FadingTextAnimationState();
}




class _FadingTextAnimationState extends State<FadingTextAnimation> with TickerProviderStateMixin {


    
  late AnimationController _animationController; 

late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  )..repeat(reverse: true);
  late final Animation<Offset> _offsetAnimation = Tween<Offset>(
    begin: Offset.zero,
    end: const Offset(1.5, 0.0),
  ).animate(CurvedAnimation(
    parent: _controller,
    curve: Curves.elasticIn,
  ));

  
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
    super.dispose(); 
  } 


bool _isVisible = true;
void toggleVisibility() {
setState(() {
_isVisible = !_isVisible;
});
}

 bool _toggle = true; 



 

@override
Widget build(BuildContext context) {
bool _first = true;
return Scaffold(
appBar: AppBar(
title: Text('Fading Text Animation'),

),
body: Center(

  
    child: Column(
      children: [
    
    
    
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
                        
                      // defining the animation type 
                      RotationTransition( 
                        child: Image.asset('assets/jack.png', 
                            height: 150, width: 150), 
                        alignment: Alignment.center, 
                        turns: _animationController, 
                      ), 
                      SizedBox( 
                        height: 20, 
                      ), 
                     SlideTransition(
      position: _offsetAnimation,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.asset('assets/bats.png', 
                            height: 150, width: 150),
                           
      ),
    ), SizedBox(height: 20),
    AnimatedCrossFade(
  duration: const Duration(seconds: 3),
  firstChild: const FlutterLogo(style: FlutterLogoStyle.horizontal, size: 100.0),
  secondChild: const FlutterLogo(style: FlutterLogoStyle.stacked, size: 100.0),
  crossFadeState: _first ? CrossFadeState.showFirst : CrossFadeState.showSecond,
)
                    ], 
                  )
                )
              )
     )
  
    ]
),
),



floatingActionButton: FloatingActionButton(
onPressed: toggleVisibility,
child: Icon(Icons.play_arrow),
),
);
}
}