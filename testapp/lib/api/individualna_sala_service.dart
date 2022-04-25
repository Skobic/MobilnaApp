import 'package:dio/dio.dart';
import 'package:testapp/models/responses/individualna_sala_response.dart';

import 'dio_client.dart';

class IndividualneSaleService {
  Future<List<IndividualnaSalaResponse>> getIndividualneSale(
      DioClient dioClient, String citaonicaId) async {
    // Perform GET request to the endpoint "/users/<id>"
    try {
      Response saleData = await dioClient.dio
          .get('/citaonice/${citaonicaId.toString()}/individualne-sale/');

      // Prints the raw data returned by the server
      //print('User Info: ${userData.data}');

      // Parsing the raw JSON data to the User class
      List<IndividualnaSalaResponse> individualneSale = (saleData.data as List)
          .map((data) => IndividualnaSalaResponse.fromJson(data))
          .toList();

      return individualneSale;
    } catch (error, stacktrace) {
      throw Exception("Exception occured: $error stackTrace: $stacktrace");
    }
  }
}
