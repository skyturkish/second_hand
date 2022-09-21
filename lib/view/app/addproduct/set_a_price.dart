import 'package:flutter/material.dart';

class SetAPriceView extends StatefulWidget {
  const SetAPriceView({Key? key}) : super(key: key);

  @override
  State<SetAPriceView> createState() => SetAPriceViewState();
}

class SetAPriceViewState extends State<SetAPriceView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SetAPrice'),
      ),
      body: const Center(
        child: Text(
          'SetAPrice',
        ),
      ),
    );
  }
}
