import 'package:dio/dio.dart';
import 'package:testapp/models/responses/obavjestenja_response.dart';
import 'dio_client.dart';

class ObavjestenjeService {
  Future<List<ObavjestenjaResponse>> getObavjestenja(
      DioClient dioClient, int citaonicaId) async {
    // Perform GET request to the endpoint "/users/<id>"
    try {
      Response obavjestenjaData = await dioClient.dio
          .get('/citaonice/${citaonicaId.toString()}/obavjestenja');

      List<ObavjestenjaResponse> obavjestenja = (obavjestenjaData.data as List)
          .map((data) => ObavjestenjaResponse.fromJson(data))
          .toList();
      return obavjestenja;
    } catch (error, stacktrace) {
      throw Exception("Exception occured: $error stackTrace: $stacktrace");
    }
  }
}
