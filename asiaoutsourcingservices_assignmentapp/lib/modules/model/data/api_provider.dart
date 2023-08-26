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
        var unstringifiedData = json.decode(response.data['data']);
        final fixedResponse = {
          'success': response.data['success'],
          'message': response.data['message'],
          'data': unstringifiedData
        };
        
        return fixedResponse;
      } else {
        print(response.data);
        return response.data;
      }
    } catch(err) {
      print('Something went wrong');
    }
  }
}

class Endpoints extends _Methods {
  Future getProducts(data) async {
    return await dioPost('/GetMasterData', data);
  }
}