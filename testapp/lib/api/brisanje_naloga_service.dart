import 'package:dio/dio.dart';
import 'package:testapp/api/dio_client.dart';
import 'package:testapp/models/responses/brisanje_naloga_response.dart';

class BrisanjeNalogaService {
  Future<Response?> obrisiNalog(
      {required DioClient dioClient,
      required int korisnikId,
      required BrisanjeNalogaResponse korisnikLozinka}) async {
    // WebLogin? retrievedObavjestenje;
    Response? response;

    try {
      response = await dioClient.dio.delete(
          '/korisnici/${korisnikId.toString()}',
          data: korisnikLozinka.toJson());

      //print('User created: ${response.data}');

      //retrievedObavjestenje = WebLogin.fromJson(response.data);
    } catch (e) {
      print('Error creating user: $e');
    }

    return response;
  }
}
