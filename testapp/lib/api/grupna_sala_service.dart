import 'package:dio/dio.dart';
import 'package:testapp/models/responses/grupna_sala_response.dart';

import 'dio_client.dart';

class GrupneSaleService {
  Future<List<GrupnaSalaResponse>> getGrupneSale(
      DioClient dioClient, String citaonicaId) async {
    // Perform GET request to the endpoint "/users/<id>"
    try {
      Response saleData = await dioClient.dio
          .get('/citaonice/${citaonicaId.toString()}/grupne-sale');

      // Prints the raw data returned by the server
      //print('User Info: ${userData.data}');

      // Parsing the raw JSON data to the User class
      List<GrupnaSalaResponse> grupneSale = (saleData.data as List)
          .map((data) => GrupnaSalaResponse.fromJson(data))
          .toList();

      return grupneSale;
    } catch (error, stacktrace) {
      throw Exception("Exception occured: $error stackTrace: $stacktrace");
    }
  }
}
