import 'package:dio/dio.dart';
import 'package:testapp/exceptions/van_radnogvremena_exception.dart';
import 'package:testapp/models/requests/rezervacija_grupne_sale_request.dart';
import 'package:testapp/models/responses/rezervacija_mjesta_response.dart';

import '../exceptions/conflict_exception.dart';
import 'dio_client.dart';

class RezervacijaService {
  Future<Response?> kreirajRezervacijuMjesta(DioClient dioClient,
      String mjestoId, DateTime vrijemeOd, DateTime vrijemeDo) async {
    // Perform GET request to the endpoint "/users/<id>"
    try {
      Response? odgovor = await dioClient.dio
          .post('/mjesta/${mjestoId.toString()}/rezervacije/', data: {
        'vrijemeVazenjaOd': vrijemeOd.toString(),
        'vrijemeVazenjaDo': vrijemeDo.toString()
      });

      return odgovor;
    } on DioError catch (error, stacktrace) {
      if (error.response != null) {
        print(error.response!.statusCode);
        if (error.response!.statusCode == 409) {
          throw ConflictException('Rezervacija vec definisana u tom vremenu');
        } else if (error.response!.statusCode == 400) {
          throw VanRadnogVremenaException('Rezervacija je van radnog vremena');
        }
      } else {
        throw Exception("Exception occured: $error stackTrace: $stacktrace");
      }
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
          .post('/mjesta/${mjestoId.toString()}/rezervacije-vrijeme/', data: {
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

    try {
      Response? odgovor = await dioClient.dio.post(
          '/grupne-sale/${grupnaSalaId.toString()}/rezervacije/',
          data: rezervacijaData.toJson());

      return odgovor;
    } catch (error, stacktrace) {
      throw Exception("Exception occured: $error stackTrace: $stacktrace");
    }
    // } on DioError catch (error, stacktrace) {
    //   print('asdlfksjadfl');
    //   if (error.response != null) {
    //     if (error.response!.statusCode == 409) {
    //       throw ConflictException('Rezervacija vec definisana u tom vremenu');
    //     } else if (error.response!.statusCode == 400) {
    //       throw VanRadnogVremenaException('Rezervacija je van radnog vremena');
    //     } else {
    //       throw Exception('sdfsadfasdf');
    //     }
    //   } else {
    //     throw Exception("Exception occured: $error stackTrace: $stacktrace");
    //   }
    // }
  }

  Future<List<RezervacijaMjestaResponse>> getRezervacijeGrupneSale(
      DioClient dioClient,
      String grupnaSalaId,
      RezervacijeGrupneSaleRequest salaRequest) async {
    // Perform GET request to the endpoint "/users/<id>"
    List<RezervacijaMjestaResponse> lista;
    try {
      Response odgovor = await dioClient.dio.post(
          '/grupne-sale/${grupnaSalaId.toString()}/rezervacije-vrijeme/',
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
