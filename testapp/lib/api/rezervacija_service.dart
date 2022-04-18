import 'package:dio/dio.dart';
import 'package:testapp/models/requests/rezervacija_grupne_sale_request.dart';
import 'package:testapp/models/responses/rezervacija_mjesta_response.dart';

import '../exceptions/conflict_exception.dart';
import 'dio_client.dart';

class RezervacijaService {
  Future<Response> kreirajRezervacijuMjesta(DioClient dioClient,
      String mjestoId, DateTime vrijemeOd, DateTime vrijemeDo) async {
    // Perform GET request to the endpoint "/users/<id>"
    try {
      Response odgovor = await dioClient.dio
          .post('/mjesta/${mjestoId.toString()}/rezervacije', data: {
        'vrijemeVazenjaOd': vrijemeOd.toString(),
        'vrijemeVazenjaDo': vrijemeDo.toString()
      });

      // Prints the raw data returned by the server
      //print('User Info: ${userData.data}');

      // Parsing the raw JSON data to the User class

      return odgovor;
    } catch (error, stacktrace) {
      throw Exception("Exception occured: $error stackTrace: $stacktrace");
    }
  }

  Future<List<RezervacijaMjestaResponse>> getRezervacijeMjesta(
      DioClient dioClient,
      String mjestoId,
      DateTime vrijemeOd,
      DateTime vrijemeDo) async {
    // Perform GET request to the endpoint "/users/<id>"
    List<RezervacijaMjestaResponse> lista;
    try {
      Response odgovor = await dioClient.dio
          .post('/mjesta/${mjestoId.toString()}/rezervacije-vrijeme', data: {
        'vrijemeVazenjaOd': vrijemeOd.toString(),
        'vrijemeVazenjaDo': vrijemeDo.toString()
      });
      lista = (odgovor.data as List)
          .map((data) => RezervacijaMjestaResponse.fromJson(data))
          .toList();
      // Prints the raw data returned by the server
      //print('User Info: ${userData.data}');

      // Parsing the raw JSON data to the User class

    } catch (error, stacktrace) {
      throw Exception("Exception occured: $error stackTrace: $stacktrace");
    }
    return lista;
  }

  Future<Response?> kreirajRezervacijuGrupneSale(DioClient dioClient,
      String grupnaSalaId, RezervacijeGrupneSaleRequest rezervacijaData) async {
    // Perform GET request to the endpoint "/users/<id>"

    Response? odgovor;
    try {
      odgovor = await dioClient.dio.post(
          '/grupne-sale/${grupnaSalaId.toString()}/rezervacije',
          data: rezervacijaData.toJson());

      // Prints the raw data returned by the server
      //print('User Info: ${userData.data}');

      // Parsing the raw JSON data to the User class

    } catch (error, stacktrace) {
      if (odgovor != null) {
        if (odgovor.statusCode == 409) {
          throw ConflictException('Rezervacija vec definisana u tom vremenu');
        } else {
          throw Exception("Exception occured: $error stackTrace: $stacktrace");
        }
      } else {
        throw Exception("Exception occured: $error stackTrace: $stacktrace");
      }
    }
    return odgovor;
  }

  Future<List<RezervacijaMjestaResponse>> getRezervacijeGrupneSale(
      DioClient dioClient,
      String grupnaSalaId,
      RezervacijeGrupneSaleRequest salaRequest) async {
    // Perform GET request to the endpoint "/users/<id>"
    List<RezervacijaMjestaResponse> lista;
    try {
      Response odgovor = await dioClient.dio.post(
          '/grupne-sale/${grupnaSalaId.toString()}/rezervacije-vrijeme',
          data: salaRequest.toJson());
      lista = (odgovor.data as List)
          .map((data) => RezervacijaMjestaResponse.fromJson(data))
          .toList();
      // Prints the raw data returned by the server
      //print('User Info: ${userData.data}');

      // Parsing the raw JSON data to the User class

    } catch (error, stacktrace) {
      throw Exception("Exception occured: $error stackTrace: $stacktrace");
    }
    return lista;
  }
}
