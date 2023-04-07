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

class _MyHomePageState extends State<MyHomePage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _pictureController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final dogProvider = Provider.of<DogProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ancha',
            style: TextStyle(color: Colors.white, fontSize: 30)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: StreamBuilder<List<Dog>>(
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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Add a dog'),
                content: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      TextFormField(
                        controller: _nameController,
                        decoration: const InputDecoration(
                          labelText: 'Name',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a name';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _pictureController,
                        decoration: const InputDecoration(
                          labelText: 'Picture URL',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a picture URL';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        final dog = Dog(
                          name: _nameController.text.trim(),
                          picture: _pictureController.text.trim(),
                        );

                        dogProvider.addDog(dog);
                        Navigator.of(context).pop();
                      }
                    },
                    child: const Text('Add'),
                  ),
                ],
              );
            },
          );
        },
        tooltip: 'Add a dog',
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
