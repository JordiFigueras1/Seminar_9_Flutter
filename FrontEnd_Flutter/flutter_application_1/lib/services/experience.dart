import 'dart:convert';
import 'package:flutter_application_1/models/experienceModel.dart';
import 'package:dio/dio.dart';

class ExperienceService {
  final String baseUrl = "http://127.0.0.1:3000"; // URL de tu backend web
  //final String baseUrl = "http://10.0.2.2:3000"; // URL de tu backend Android
  final Dio dio = Dio(); // Instancia de Dio para realizar solicitudes HTTP
  var statusCode;
  var data;

  // Función para crear una nueva experiencia
Future<int> createExperience(ExperienceModel newExperience) async {
  print('createExperience');
  try {
    Response response = await dio.post(
      '$baseUrl/experiencias',
      data: newExperience.toJson(),
    );

    data = response.data.toString();
    statusCode = response.statusCode;
    print('Data: $data');
    print('Status code: $statusCode');

    // Considera 200 como éxito
    if (statusCode == 200 || statusCode == 201) {
      print('Experiencia creada exitosamente.');
      return statusCode;
    } else {
      print('Error con el status code: $statusCode');
      return -1;
    }
  } catch (e) {
    print('Error creating experience: $e');
    return -1;
  }
}

  // Función para eliminar una experiencia por ID
  Future<int> deleteExperienceById(String id) async {
    print('deleteExperienceById');
    try {
      // Enviar solicitud DELETE a /experiencias/:id
      Response response = await dio.delete('$baseUrl/experiencias/$id');

      // Guardar datos de la respuesta
      data = response.data.toString();
      statusCode = response.statusCode;
      print('Data: $data');
      print('Status code: $statusCode');

      // Verificar el código de estado
      if (statusCode == 200 || statusCode == 201) {
        print('Experiencia eliminada exitosamente.');
        return statusCode;
      } else {
        print('Error con el status code: $statusCode');
        return -1;
      }
    } catch (e) {
      print('Error deleting experience: $e');
      return -1;
    }
  }

  // Función para obtener la lista de experiencias
Future<List<ExperienceModel>> getExperiences() async {
  print('Llamando al backend para obtener experiencias...');
  try {
    var res = await dio.get('$baseUrl/experiencias');
    print('Datos obtenidos del backend: ${res.data}');
    List<dynamic> responseData = res.data;
    List<ExperienceModel> experiences = responseData
        .map((data) => ExperienceModel.fromJson(data))
        .toList();
    print('Experiencias parseadas: ${experiences.length}');
    return experiences;
  } catch (e) {
    print('Error en getExperiences: $e');
    throw e;
  }
}



  // Función para editar una experiencia existente
  Future<int> editExperience(ExperienceModel updatedExperience, String id) async {
    print('editExperience');
    try {
      // Enviar solicitud PUT para actualizar una experiencia
      Response response = await dio.put(
        '$baseUrl/experiencias/$id',
        data: updatedExperience.toJson(),
      );

      // Guardar datos de la respuesta
      data = response.data.toString();
      statusCode = response.statusCode;
      print('Data: $data');
      print('Status code: $statusCode');

      // Verificar el código de estado
      if (statusCode == 201) {
        print('201');
        return 201;
      } else if (statusCode == 400) {
        print('400');
        return 400;
      } else if (statusCode == 500) {
        print('500');
        return 500;
      } else {
        print('-1');
        return -1;
      }
    } catch (e) {
      print('Error editing experience: $e');
      return -1;
    }
  }

  // Función para eliminar una experiencia por descripción
  Future<int> deleteExperienceByDescription(String description) async {
    print('deleteExperienceByDescription');
    try {
      // Enviar solicitud DELETE utilizando la descripción como parámetro en la URL
      Response response = await dio.delete('$baseUrl/experiencias', data: {"description": description});

      // Guardar datos de la respuesta
      data = response.data.toString();
      statusCode = response.statusCode;
      print('Data: $data');
      print('Status code: $statusCode');

      // Verificar el código de estado
      if (statusCode == 201) {
        print('201');
        return 201;
      } else if (statusCode == 400) {
        print('400');
        return 400;
      } else if (statusCode == 500) {
        print('500');
        return 500;
      } else {
        print('-1');
        return -1;
      }
    } catch (e) {
      print('Error deleting experience: $e');
      return -1;
    }
  }
}
