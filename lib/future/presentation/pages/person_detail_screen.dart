import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rick_and_morty/future/domain/entities/person_entity.dart';
import 'package:rick_and_morty/future/presentation/bloc/search_bloc/search_event.dart';

class PersonDetailScreen extends StatelessWidget {
  final PersonEntity person;

  PersonDetailScreen({required this.person});

  @override
  Widget build(BuildContext context) {
    final dateFormatter = DateFormat('yyyy-MM-dd HH:mm').format(person.created);
    return Scaffold(
      appBar: AppBar(
        title: Text('Character'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 30),
              Text(person.name, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              Container(
                  width: 250,
                  height: 250,
                  child: CachedNetworkImage(
                    imageUrl: person.image,
                    placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                    imageBuilder: (context, imageProvider) {
                      return Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(image: imageProvider),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      );
                    },
                  )),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: person.status == 'Alive' ? Colors.green : Colors.red,
                    ),
                  ),
                  SizedBox(width: 10),
                  Text(person.status),
                ],
              ),
              _buildItem(field: 'Gender: ', value: person.gender),
              _buildItem(field: 'Number of episodes: ', value: person.episode.length.toString()),
              _buildItem(field: 'Species: ', value: person.species),
              _buildItem(field: 'Last known location: ', value: person.location.name),
              _buildItem(field: 'Origin: ', value: person.origin.name),
              _buildItem(field: 'Was created: ', value: dateFormatter),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildItem({required String field, required String value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 15),
        Wrap(
          alignment: WrapAlignment.center,
          children: [
            Text(field),
            Text(value, style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ],
    );
  }
}
