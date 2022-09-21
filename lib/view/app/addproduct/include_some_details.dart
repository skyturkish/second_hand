import 'package:flutter/material.dart';

class IncludeSomeDetailsView extends StatefulWidget {
  const IncludeSomeDetailsView({Key? key}) : super(key: key);

  @override
  State<IncludeSomeDetailsView> createState() => IncludeSomeDetailsViewState();
}

class IncludeSomeDetailsViewState extends State<IncludeSomeDetailsView> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Include some details'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: const [],
        ),
      ),
    );
  }
}
