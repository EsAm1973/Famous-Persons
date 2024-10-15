import 'package:famous/models/Person_Details.dart';
import 'package:famous/screens/full_image.dart';
import 'package:famous/services/persons_api.dart';
import 'package:flutter/material.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key, required this.id});
  final int id;

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  late Future<PersonDetails> fetchPersonDetails;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchPersonDetails = ApiService.fetchPersonDetails(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Person Details'),
      ),
      body: SingleChildScrollView(
        child: FutureBuilder<PersonDetails>(
          future: fetchPersonDetails,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData) {
              return const Center(child: Text('No Details Available'));
            } else {
              final person = snapshot.data!;
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FullImageScreen(
                                imageUrl:
                                    'https://image.tmdb.org/t/p/w500${person.profilePath}'),
                          ),
                        );
                      },
                      child: Center(
                        child: Image.network(
                          'https://image.tmdb.org/t/p/w500${person.profilePath}',
                          width: 400,
                          height: 400,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(person.name,
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    Text('Biography: ${person.biography}',
                        style: const TextStyle(fontSize: 16)),
                    const SizedBox(height: 10),
                    Text('Place of Birth: ${person.placeOfBirth}',
                        style: const TextStyle(fontSize: 16)),
                    const SizedBox(height: 10),
                    Text('Popularity: ${person.popularity}',
                        style: const TextStyle(fontSize: 16)),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
