import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_application_1/services/user.dart';
import 'package:flutter_application_1/models/userModel.dart';

class UserController extends GetxController {
  final UserService userService = Get.put(UserService());

  // Controladores de texto para la UI
  final TextEditingController mailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController commentController = TextEditingController();

  // Variables reactivas para la UI
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  // Función para realizar login
  void logIn() async {
    // Validación de campos
    if (mailController.text.isEmpty || passwordController.text.isEmpty) {
      Get.snackbar('Error', 'Campos vacíos',
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    // Validación de formato de correo electrónico
    if (!GetUtils.isEmail(mailController.text)) {
      Get.snackbar('Error', 'Correo electrónico no válido',
          snackPosition: SnackPosition.BOTTOM);
      return;
    }
    print('Estoy en el login de userController');

    final logIn = (
      mail: mailController.text,
      password: passwordController.text,
    );

    // Iniciar el proceso de inicio de sesión
    isLoading.value = true;
    errorMessage.value = '';

    try {
      // Llamada al servicio para iniciar sesión
      final responseData = await userService.logIn(logIn);

      print('El response data es: $responseData');

      if (responseData != null) {
        // Manejo de respuesta exitosa
        Get.snackbar('Éxito', 'Inicio de sesión exitoso');
        Get.toNamed('/home');
      } else {
        errorMessage.value = 'Usuario o contraseña incorrectos';
        Get.snackbar('Error', errorMessage.value,
            snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      errorMessage.value = 'Error: No se pudo conectar con la API';
      Get.snackbar('Error', errorMessage.value,
          snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }

  // Función para editar un usuario
  void editUser(String id) async {
    // Validación del ID
    if (id.isEmpty) {
      Get.snackbar('Error', 'ID del usuario no definido',
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    // Validación de campos vacíos
    if (nameController.text.isEmpty ||
        mailController.text.isEmpty ||
        passwordController.text.isEmpty ||
        commentController.text.isEmpty) {
      Get.snackbar('Error', 'Campos vacíos',
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    // Validación de formato de correo electrónico
    if (!GetUtils.isEmail(mailController.text)) {
      Get.snackbar('Error', 'Correo electrónico no válido',
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    isLoading.value = true;
    errorMessage.value = '';

    try {
      final updatedUser = UserModel(
        id: id,
        name: nameController.text,
        mail: mailController.text,
        password: passwordController.text,
        comment: commentController.text,
      );

      final response = await userService.editUser(updatedUser, id);
      if (response == 200) {
        Get.snackbar('Éxito', 'Usuario actualizado correctamente');
      } else {
        errorMessage.value = 'Error al actualizar el usuario';
        Get.snackbar('Error', errorMessage.value,
            snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      errorMessage.value = 'Error: No se pudo conectar con la API';
      Get.snackbar('Error', errorMessage.value,
          snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }

  // Función para limpiar los campos de texto
  void clearFields() {
    mailController.clear();
    passwordController.clear();
    nameController.clear();
    commentController.clear();
  }
}
