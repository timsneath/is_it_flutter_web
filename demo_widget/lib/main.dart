import 'package:flutter/material.dart';

// import 'demo_widget.dart';
import 'master.dart';

void main() => runApp(
      MaterialApp(
        home: Scaffold(
          body: Directionality(
            textDirection: TextDirection.ltr,
            child: FlipViewMasterWidget(),
          ),
        ),
      ),
    );
