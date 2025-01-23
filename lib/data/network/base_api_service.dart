import 'package:firebase_todo_app/data/network/network_api_services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class BaseApiServices {
  Future<dynamic> getGetApiResponse(String url, Map<String, dynamic> data, {String? username, String? password, String? token});
  Future<dynamic> getPostApiResponse(String url, dynamic data, {String? token});
}

// Define a provider for BaseApiServices
final baseApiServiceProvider = Provider<BaseApiServices>((ref) {
  return ref.read(networkApiServiceProvider);
});
