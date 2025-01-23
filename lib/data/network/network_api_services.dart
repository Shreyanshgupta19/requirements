import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:firebase_todo_app/data/app_exceptions.dart';
import 'package:firebase_todo_app/data/network/base_api_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

// Define a provider for NetworkApiService
final networkApiServiceProvider = Provider<NetworkApiService>((ref) {
  return NetworkApiService();
});

class NetworkApiService implements BaseApiServices {
  late final Dio _dio;

  NetworkApiService() {
    _dio = Dio(
      BaseOptions(
        baseUrl: '',
        connectTimeout: const Duration(seconds: 20),
        receiveTimeout: const Duration(seconds: 20),
        responseType: ResponseType.json,
      ),
    );

    // Adding interceptors
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          // Remove null query parameters
          options.queryParameters.removeWhere((key, value) => value == null);
          if (kDebugMode) {
            debugPrint(
              "Request [${options.method}] : ${options.uri}\n"
              "Query: ${options.queryParameters}\n"
              "Data: ${options.data}\n"
              "Headers: ${options.headers}",
            );
          }
          return handler.next(options); // Continue the request
        },
        onResponse: (response, handler) {
          if (kDebugMode) {
            debugPrint(
              "Response [${response.statusCode}] (${response.requestOptions.path}) : ${response.data}",
            );
          }
          return handler.next(response); // Continue the response
        },
        onError: (error, handler) {
          if (kDebugMode) {
            debugPrint(
              "Error in request [${error.response?.statusCode}] : ${error.response?.data}",
            );
          }
          return handler.next(error); // Continue the error
        },
      ),
    );

    // Optional: Add log interceptor for debugging
    if (kDebugMode) {
      _dio.interceptors.add(
        LogInterceptor(
          request: true,
          responseBody: true,
          requestBody: true,
          error: true,
        ),
      );
    }
  }

  // Future<Options> getAuthTokenHeaderOption() async {
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   return Options(
  //       headers: {
  //         "Authorization": 'Bearer ${pref.getString('access_token')}',
  //         "user_id": pref.getInt('id')
  //       });
  // }

  Future<Options> getAuthHeader({String? username, String? password, String? token}) async {
    String? authorization;
    if (username != null && password != null) {
      authorization =
          'Basic ${base64Encode(utf8.encode('$username:$password'))}';
    } else if (token != null) {
      authorization = 'Bearer $token';
    } else {
      throw UnauthorisedException('Missing credentials for authorization');
    }

    return Options(
      headers: {
        'Authorization': authorization,
      },
    );
  }

  @override
  Future getGetApiResponse(String url, Map<String, dynamic> data,
      {String? username, String? password, String? token}) async {
    try {
      final options = await getAuthHeader(
          username: username, password: password, token: token);
      final response = await _dio.get(
        url,
        queryParameters: data,
        options: options,
      );
      return handleResponse(response);
    } on DioException catch (error) {
      throw handleDioError(error);
    }
  }

  @override
  Future getPostApiResponse(String url, dynamic data, {String? token}) async {
    try {
      final options = await getAuthHeader(token: token);
      final response = await _dio.post(
        url,
        data: data,
        options: options,
      );
      return handleResponse(response);
    } on DioException catch (error) {
      throw handleDioError(error);
    }
  }

  // Handling responses based on HTTP status codes

  static dynamic handleResponse(Response response) {
    if (kDebugMode) {
      debugPrint('Response Status Code: ${response.statusCode}');
      debugPrint('Response Data: ${response.data}');
    }
    if (response == null || response.statusCode == null) {
      throw FetchDataException("Invalid response from the server.");
    }

    switch (response.statusCode) {
      case 200:
        return response.data;
      case 201:
        return response.data;
      case 400:
        throw BadRequestException(response.data.toString());
      case 401:
      case 403:
      case 404:
        throw UnauthorisedException(response.data.toString());
      case 500:
        throw FetchDataException('Internal server error');
      default:
        throw FetchDataException(
          'Unexpected error occurred: ${response.statusCode}',
        );
    }
  }

  Exception handleDioError(DioException error) {
    if (kDebugMode) {
      debugPrint("Dio Error: ${error.message}");
      if (error.response != null) {
        debugPrint("Response Data: ${error.response?.data}");
        debugPrint("Response Status Code: ${error.response?.statusCode}");
      }
    }

    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
        return FetchDataException("Network request timed out.");
      case DioExceptionType.badResponse:
        return FetchDataException("Bad response from server.");
      case DioExceptionType.connectionError:
        return NoInternetException("No Internet connection.");
      default:
        return FetchDataException(
          error.response?.data?["error"] ?? "Something went wrong!",
        );
    }
  }

  static String catchError(dynamic e) {
    if (e is DioException) {
      final response = e.response;
      if (response != null) {
        switch (response.statusCode) {
          case 500:
            return "Backend error occurred!";
          case 401:
            return response.data?["error"] ?? "Unauthorized access!";
          default:
            return response.data?["error"] ?? "An unexpected error occurred!";
        }
      }
      return "Something went wrong: ${e.message}";
    }
    return "Unexpected error: $e";
  }
}

dynamic handleWebSocketError(dynamic error) {
  if (error is SocketException) {
// Handle network-related errors
    if (kDebugMode) debugPrint('SocketException: ${error.message}');
    throw FetchDataException(
        'Network error: Unable to connect to the WebSocket server. Please check your internet connection.');
  } else if (error is WebSocketChannelException) {
// Handle WebSocket-specific errors
    if (kDebugMode) debugPrint('WebSocketChannelException: ${error.message}');
    throw FetchDataException(
        'WebSocket error: Unable to establish a connection.');
  } else if (error is FormatException) {
// Handle data formatting/parsing issues
    if (kDebugMode) debugPrint('FormatException: ${error.message}');
    throw FetchDataException(
        'Data format error: Received invalid data from the server. Please try again later.');
  } else if (error is TimeoutException) {
// Handle timeout errors
    if (kDebugMode) debugPrint('TimeoutException: ${error.message}');
    throw FetchDataException(
        'Connection timed out: The server is taking too long to respond. Please try again later.');
  } else if (error is HandshakeException) {
// Handle SSL handshake errors
    if (kDebugMode) debugPrint('HandshakeException: ${error.message}');
    throw FetchDataException(
        'SSL error: Unable to establish a secure connection.');
  } else {
// Handle all other errors
    if (kDebugMode) debugPrint('Unknown error: $error');
    throw FetchDataException(
        'An unexpected error occurred. Please try again later.');
  }
}
