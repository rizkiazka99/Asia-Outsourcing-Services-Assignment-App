import 'dart:convert';
import 'package:asiaoutsourcingservices_assignmentapp/helpers/constants.dart';
import 'package:dio/dio.dart';

class _Methods {
  Dio dio = Dio();

 Future dioPost(url, data) async {
    try {
      final response = await dio.post(
        Constants.baseUrl + url,
        data: jsonEncode(data)
      );

      if (response.data['data'] != null) {
        var destringifiedData = json.decode(response.data['data']);
        final fixedResponse = {
          'success': response.data['success'],
          'message': response.data['message'],
          'data': destringifiedData
        };
        
        return fixedResponse;
      } else {
        return response.data;
      }
    } catch(err) {
      print(err);
      print('Something went wrong');
    }
  }
}

class Endpoints extends _Methods {
  Future getProducts(data) async {
    return await dioPost('/GetMasterData', data);
  }

  Future insertSales(data) async {
    return await dioPost('/UpdateData', data);
  }
}