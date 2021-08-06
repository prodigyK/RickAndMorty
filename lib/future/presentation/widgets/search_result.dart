import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:rick_and_morty/future/domain/entities/person_entity.dart';
import 'package:rick_and_morty/future/presentation/pages/person_detail_screen.dart';

class SearchResult extends StatelessWidget {
  final PersonEntity person;

  SearchResult({required this.person});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => PersonDetailScreen(person: person)));
      },
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  SizedBox(width: 5),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: CachedNetworkImage(
                      imageUrl: person.image,
                      imageBuilder: (context, imageProvider) {
                        return Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: imageProvider,
                            )
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(width: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(person.name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                      SizedBox(height: 5),
                      Text(person.location.name),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
