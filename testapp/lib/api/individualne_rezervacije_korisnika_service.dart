import 'package:dio/dio.dart';
import 'package:testapp/models/responses/individualne_rezervacije_korisnika_response.dart';

import 'dio_client.dart';

class IndividualneRezervacijeKorisnikaService {
  Future<List<IndividualneRezervacijeKorisnikaResponse>>
      getIndividualneRezervacijeKorisnika(
    DioClient dioClient,
    int korisnikId,
  ) async {
    // Perform GET request to the endpoint "/users/<id>"
    List<IndividualneRezervacijeKorisnikaResponse> lista;
    try {
      Response odgovor = await dioClient.dio
          .get('/korisnici/${korisnikId.toString()}/rezervacije-mjesta');
      lista = (odgovor.data as List)
          .map(
              (data) => IndividualneRezervacijeKorisnikaResponse.fromJson(data))
          .toList();
      // Prints the raw data returned by the server
      //print('User Info: ${userData.data}');

      // Parsing the raw JSON data to the User class

    } catch (error, stacktrace) {
      throw Exception("Exception occured: $error stackTrace: $stacktrace");
    }
    return lista;
  }

  Future<Response> deleteRezervacija(
      {required DioClient dioClient,
      required int mjestoId,
      required int rezervacijaId}) async {
    // Perform GET request to the endpoint "/users/<id>"
    try {
      Response odgovor = await dioClient.dio.delete(
        '/mjesta/${mjestoId.toString()}/rezervacije/${rezervacijaId.toString()}',
      );

      return odgovor;
    } catch (error, stacktrace) {
      throw Exception("Exception occured: $error stackTrace: $stacktrace");
    }
  }
}
