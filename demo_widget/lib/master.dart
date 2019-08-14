import 'package:flutter/material.dart';
import 'custom_layout_example.dart';
import 'simple_example.dart';

void main() => runApp(MaterialApp(home: FlipViewMasterWidget()));

class FlipViewMasterWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flip View'),
      ),
      body: ListView(children: <Widget>[
        ListTile(
          title: const Text('Simple Example'),
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (BuildContext context) {
              return SimpleExample();
            }));
          },
        ),
        ListTile(
          title: const Text('Custom Layout Example'),
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (BuildContext context) {
              return CustomLayoutExample();
            }));
          },
        )
      ]),
    );
  }
}
