import 'package:get/get.dart';
import 'package:flutter_application_1/models/userModel.dart';

class UserModelController extends GetxController {
  final user = UserModel(
    id: 'temp-id', // Aquí puedes usar un id temporal o uno generado dinámicamente
    name: 'Usuario desconocido',
    mail: 'No especificado',
    password: 'Sin contraseña',
    comment: 'Sin comentarios',
  ).obs;

  // Método para actualizar los datos del usuario
  void setUser(String id, String name, String mail, String password, String comment) {
    user.update((val) {
      if (val != null) {
        val.setUser(name, mail, password, comment);
      }
    });
  }
}
