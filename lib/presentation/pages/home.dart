import 'package:ancha/core/models/dog.dart';
import 'package:ancha/core/providers/dog_provider.dart';
import 'package:ancha/presentation/widgets/item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

// Add un list view with a list of items to the body of the scaffold, but this items have a card widget that contain a name and picture
class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final dogProvider = Provider.of<DogProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ancha App'),
      ),
      body: StreamBuilder<List<Dog>>(
          stream: dogProvider.getDogs(),
          builder: (context, snapshop) {
            if (snapshop.hasData) {
              return ListView.builder(
                  itemCount: snapshop.data!.length,
                  itemBuilder: (context, index) {
                    return ItemWidget(
                        name: snapshop.data![index].name,
                        imageUrl: snapshop.data![index].picture);
                  });
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

// ListView(
//         children: const <Widget>[
//           ItemWidget(
//               name: "Marinette",
//               imageUrl:
//                   "https://images.hola.com/imagenes/mascotas/20221020219416/razas-perros-toy/1-154-393/02-bichon-maltes-a.jpg?tx=w_360")
//         ],
// )
