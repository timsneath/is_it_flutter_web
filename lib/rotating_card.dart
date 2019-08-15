import 'package:flutter/material.dart';
import 'package:flutter_flip_view/flutter_flip_view.dart';

void main() => runApp(MaterialApp(home: RotatingCard()));

class RotatingCard extends StatefulWidget {
  @override
  _RotatingCardState createState() => _RotatingCardState();
}

class _RotatingCardState extends State<RotatingCard>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _curvedAnimation;

  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));
    _curvedAnimation =
        CurvedAnimation(parent: _animationController, curve: Curves.easeInOut);
    _animationController.addStatusListener((AnimationStatus status) {
      if (!_focusNode.hasFocus && _animationController.isCompleted) {
        setState(() {
          FocusScope.of(context).requestFocus(_focusNode);
        });
      } else if (_focusNode.hasFocus && !_animationController.isCompleted) {
        _focusNode.unfocus();
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _flip(bool reverse) {
    if (_animationController.isAnimating) return;
    if (reverse) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Center(
            child: FlipView(
              animationController: _curvedAnimation,
              front: _buildFrontSide(() => _flip(true)),
              back: _buildBackSide(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFrontSide(GestureTapCallback onTap) {
    return AspectRatio(
      aspectRatio: 0.7,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              colors: [
                Color(0xff92ffc0),
                Color(0Xff002661),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              splashColor: Colors.white.withOpacity(0.1),
              highlightColor: Colors.transparent,
              borderRadius: BorderRadius.circular(8),
              onTap: onTap,
              child: Center(
                child: Container(
                  // width: 48,
                  // height: 48,
                  alignment: Alignment.center,
                  // decoration: BoxDecoration(
                  //   borderRadius: BorderRadius.circular(60),
                  //   color: Colors.amber,
                  // ),
                  child: Text(
                    'Secret message received',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBackSide() {
    return Card(
      color: Colors.grey.shade50,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Text(
              'Enter secret code to access message',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 32, right: 32, bottom: 24),
            color: Colors.white,
            child: TextField(
              focusNode: _focusNode,
              textAlign: TextAlign.center,
              cursorColor: Colors.black38,
              style: TextStyle(fontSize: 18),
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 6, horizontal: 6),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey.shade100,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey.shade100,
                  ),
                ),
              ),
            ),
          ),
          Divider(height: 1, color: Colors.grey),
          Row(
            children: <Widget>[
              Expanded(
                child: InkWell(
                  highlightColor: Colors.grey.withOpacity(0.2),
                  splashColor: Colors.grey.withOpacity(0.1),
                  borderRadius:
                      BorderRadius.only(bottomLeft: Radius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text('Back', textAlign: TextAlign.center),
                  ),
                  onTap: () {
                    _flip(false);
                  },
                ),
              ),
              Container(
                width: 1,
                height: 46,
                color: Colors.grey.withOpacity(0.4),
              ),
              Expanded(
                child: InkWell(
                  highlightColor: Colors.grey.withOpacity(0.2),
                  splashColor: Colors.grey.withOpacity(0.1),
                  borderRadius:
                      BorderRadius.only(bottomRight: Radius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text('Ok', textAlign: TextAlign.center),
                  ),
                  onTap: () {},
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
