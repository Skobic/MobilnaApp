import 'package:dio/dio.dart';
import 'package:testapp/models/requests/registracija_request.dart';

import 'dio_client.dart';

class RegistracijaService {
  /*Future<RegistracijaRequest> getCitaonice(DioClient dioClient) async {
    // Perform GET request to the endpoint "/users/<id>"
    try {
      Response citaoniceData = await dioClient.dio.get('/citaonice');

      // Prints the raw data returned by the server
      //print('User Info: ${userData.data}');

      // Parsing the raw JSON data to the User class
      List<CitaonicaResponse> citaonice = (citaoniceData.data as List)
          .map((data) => CitaonicaResponse.fromJson(data))
          .toList();

      return citaonice;
    } catch (error, stacktrace) {
      throw Exception("Exception occured: $error stackTrace: $stacktrace");
    }
  }*/

  Future<Response?> createKorisnik(
      {required DioClient dioClient,
      required RegistracijaRequest korisnikInfo}) async {
    Response? response;

    try {
      response = await dioClient.dio.post(
        '/registracija',
        data: korisnikInfo.toJson(),
      );
    } catch (e) {
      print('Error creating user: $e');
    }

    return response;
  }
}
