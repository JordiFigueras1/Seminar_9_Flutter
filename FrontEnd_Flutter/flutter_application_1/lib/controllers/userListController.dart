import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_application_1/services/user.dart';
import 'package:flutter_application_1/models/userModel.dart';

class UserListController extends GetxController {
  var isLoading = true.obs;
  var userList = <UserModel>[].obs;
  final UserService userService = UserService();

  @override
  void onInit() {
    fetchUsers();
    super.onInit();
  }

Future<void> fetchUsers() async {
  try {
    isLoading(true);
    var users = await userService.getUsers();
    if (users != null) {
      print('Usuarios obtenidos: $users'); // Log para verificar datos
      userList.assignAll(users);
    }
  } catch (e) {
    print("Error fetching users: $e");
  } finally {
    isLoading(false);
  }
}


Future<void> editUser(String id, UserModel updatedUser) async {
  try {
    isLoading(true);
    var statusCode = await userService.editUser(updatedUser, id);
    if (statusCode == 200 || statusCode == 201) { // Ajuste aquí
      Get.snackbar('Éxito', 'Usuario modificado con éxito');
      await fetchUsers();
    } else {
      Get.snackbar('Error', 'Error al modificar el usuario');
    }
  } catch (e) {
    print("Error editing user: $e");
  } finally {
    isLoading(false);
  }
}

}

