import 'dart:convert';
import 'package:flutter_application_1/models/userModel.dart';
import 'package:dio/dio.dart';

class UserService {
  final String baseUrl = "http://127.0.0.1:3000"; // URL de tu backend Web
  //final String baseUrl = "http://10.0.2.2:3000"; // Para emulador de Android

  final Dio dio = Dio();
  var statusCode;
  var data;

Future<int> createUser(UserModel newUser) async {
  try {
    Response response = await dio.post('$baseUrl/user/newUser', data: newUser.toJson());
    data = response.data.toString();
    statusCode = response.statusCode;

    if (statusCode == 200 || statusCode == 201) {
      return statusCode; // Éxito
    } else {
      print('Error inesperado: $statusCode');
      return -1; // Error
    }
  } catch (e) {
    print('Error creando usuario: $e');
    return -1; // Error
  }
}




Future<List<UserModel>> getUsers() async {
  try {
    var res = await dio.get('$baseUrl/user');
    print('Respuesta del backend: ${res.data}'); // Log para verificar datos del backend
    List<dynamic> responseData = res.data;
    List<UserModel> users = responseData.map((data) {
      print('Datos del usuario mapeados: $data'); // Log por usuario
      return UserModel.fromJson(data);
    }).toList();
    return users;
  } catch (e) {
    print('Error en getUsers: $e');
    throw e;
  }
}

Future<int> editUser(UserModel updatedUser, String id) async {
  try {
    print('Enviando solicitud PUT a $baseUrl/user/$id');
    print('Datos enviados: ${updatedUser.toJson()}');
    Response response = await dio.put(
      '$baseUrl/user/$id',
      data: updatedUser.toJson(),
    );
    data = response.data.toString();
    statusCode = response.statusCode;
    print('Respuesta del backend: $data, Estado: $statusCode');
    return statusCode ?? -1;
  } catch (e) {
    print('Error en editUser: $e');
    throw e;
  }
}

  Future<int> deleteUser(String id) async {
    Response response = await dio.delete('$baseUrl/user/$id');
    data = response.data.toString();
    statusCode = response.statusCode;
    return statusCode ?? -1;
  }

  Future<int> logIn(logIn) async {
    Response response = await dio.post('$baseUrl/user/logIn', data: logInToJson(logIn));
    data = response.data.toString();
    statusCode = response.statusCode;
    return statusCode ?? -1;
  }

  Map<String, dynamic> logInToJson(logIn) {
    return {'mail': logIn.mail, 'password': logIn.password};
  }
}
