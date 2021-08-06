import 'dart:convert';

import 'package:rick_and_morty/core/error/exception.dart';
import 'package:rick_and_morty/future/data/datasources/person_remote_data_source.dart';
import 'package:rick_and_morty/future/data/models/person_model.dart';
import 'package:http/http.dart' as http;

class PersonRemoteDataSourseImpl implements PersonRemoteDataSource {
  final http.Client client = http.Client();

  @override
  Future<List<PersonModel>> getAllPersons(int page) async {
    String endpoint = 'https://rickandmortyapi.com/api/character/?page=$page';
    return _getPersonsFromUrl(endpoint);
  }

  @override
  Future<List<PersonModel>> searchPerson(String query) async {
    String endpoint = 'https://rickandmortyapi.com/api/character/?name=$query';
    return _getPersonsFromUrl(endpoint);
  }

  Future<List<PersonModel>> _getPersonsFromUrl(String endpoint) async {
    final url = Uri.parse(endpoint);
    final response = await http.get(url, headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      final persons = json.decode(response.body);
      return (persons['results'] as List<dynamic>).map((person) => PersonModel.fromJson(person)).toList();
    } else {
      throw ServerException();
    }
  }
}
