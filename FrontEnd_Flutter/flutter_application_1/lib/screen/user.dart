import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_application_1/controllers/userListController.dart';
import 'package:flutter_application_1/controllers/registerController.dart';
import 'package:flutter_application_1/Widgets/userCard.dart';
import 'package:flutter_application_1/models/userModel.dart';

class UserPage extends StatelessWidget {
  final UserListController userController = Get.put(UserListController());
  final RegisterController registerController = Get.put(RegisterController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Gestión de Usuarios')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Expanded(
              child: Obx(() {
                if (userController.isLoading.value) {
                  return Center(child: CircularProgressIndicator());
                } else if (userController.userList.isEmpty) {
                  return Center(child: Text("No hay usuarios disponibles"));
                } else {
                  return ListView.builder(
                    itemCount: userController.userList.length,
                    itemBuilder: (context, index) {
                      final user = userController.userList[index];
                      return UserCard(
                        user: user,
                        onEdit: () {
                          Get.defaultDialog(
                            title: 'Modificar Usuario',
                            content: EditUserForm(user: user),
                          );
                        },
                      );
                    },
                  );
                }
              }),
            ),
            SizedBox(width: 20),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Crear Nuevo Usuario',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  TextField(
                    controller: registerController.nameController,
                    decoration: InputDecoration(labelText: 'Usuario'),
                  ),
                  TextField(
                    controller: registerController.mailController,
                    decoration: InputDecoration(labelText: 'Correo'),
                  ),
                  TextField(
                    controller: registerController.passwordController,
                    decoration: InputDecoration(labelText: 'Contraseña'),
                    obscureText: true,
                  ),
                  TextField(
                    controller: registerController.commentController,
                    decoration: InputDecoration(labelText: 'Comentario'),
                  ),
                  SizedBox(height: 16),
                  Obx(() {
                    if (registerController.isLoading.value) {
                      return CircularProgressIndicator();
                    } else {
                      return ElevatedButton(
                        onPressed: registerController.signUp,
                        child: Text('Registrarse'),
                      );
                    }
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EditUserForm extends StatelessWidget {
  final UserModel user;
  final UserListController userController = Get.find();

  EditUserForm({required this.user});

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController(text: user.name);
    final mailController = TextEditingController(text: user.mail);
    final passwordController = TextEditingController(text: user.password);
    final commentController = TextEditingController(text: user.comment);

    return Column(
      children: [
        TextField(
          controller: nameController,
          decoration: InputDecoration(labelText: 'Nombre'),
        ),
        TextField(
          controller: mailController,
          decoration: InputDecoration(labelText: 'Correo'),
        ),
        TextField(
          controller: passwordController,
          decoration: InputDecoration(labelText: 'Contraseña'),
          obscureText: true,
        ),
        TextField(
          controller: commentController,
          decoration: InputDecoration(labelText: 'Comentario'),
        ),
        SizedBox(height: 16),
ElevatedButton(
  onPressed: () {
    final updatedUser = UserModel(
      id: user.id,
      name: nameController.text,
      mail: mailController.text,
      password: passwordController.text,
      comment: commentController.text,
    );
    print('Intentando editar usuario con ID: ${user.id}');
    print('Datos enviados: ${updatedUser.toJson()}');
    userController.editUser(user.id ?? '', updatedUser);
    Get.back();
  },
  child: Text('Guardar Cambios'),
        ),
      ],
    );
  }
}
