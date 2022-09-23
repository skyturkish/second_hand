import 'package:flutter/material.dart';
import 'package:second_hand/models/product.dart';
import 'package:second_hand/service/cloud/product/product-service.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => HomeViewState();
}

class HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: GroupCloudFireStoreService.instance.getAllProductsWithoutImages(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data as List<Product>;

            return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  crossAxisSpacing: 5.0,
                  mainAxisSpacing: 5.0,
                ),
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Column(
                      children: [
                        Text(data[index].title),
                        Expanded(
                          child: Image.file(
                            he
                            data[index].images.first,
                          ),
                        ),
                      ],
                    ),
                  );
                });
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
