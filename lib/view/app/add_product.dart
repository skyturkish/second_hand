import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddProductView extends StatefulWidget {
  const AddProductView({Key? key}) : super(key: key);

  @override
  State<AddProductView> createState() => AddProductViewState();
}

class AddProductViewState extends State<AddProductView> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Container();
      },
    );
  }
}
