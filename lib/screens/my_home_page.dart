import 'package:famous/models/Person.dart';
import 'package:famous/screens/person_details.dart';
import 'package:famous/services/persons_api.dart';
import 'package:flutter/material.dart';

class FamousPersonsScreen extends StatefulWidget {
  const FamousPersonsScreen({super.key});

  @override
  _FamousPersonsScreenState createState() => _FamousPersonsScreenState();
}

class _FamousPersonsScreenState extends State<FamousPersonsScreen> {
  late Future<List<Person>> persons;
  List<Person> favoriteList = [];

  @override
  void initState() {
    super.initState();
    persons = ApiService.fetchPersons();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Persons List'),
        centerTitle: true,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: FutureBuilder<List<Person>>(
        future: persons,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No Data'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final person = snapshot.data![index];
                final isFavorite = favoriteList.contains(person);

                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailsScreen(
                          id: person.id,
                        ),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      elevation: 5,
                      child: ListTile(
                        title: Text(
                          person.name,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(person.category),
                        trailing: IconButton(
                          onPressed: () {
                            setState(() {
                              if (isFavorite) {
                                favoriteList.remove(person);
                              } else {
                                favoriteList.add(person);
                              }
                            });
                          },
                          icon: Icon(
                            isFavorite ? Icons.favorite : Icons.favorite_border,
                            color: isFavorite ? Colors.red : null,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
