import 'package:flutter/material.dart';
import '../models/userModel.dart';

class UserCard extends StatelessWidget {
  final UserModel user;
  final VoidCallback onEdit;

  const UserCard({
    Key? key,
    required this.user,
    required this.onEdit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              user.name,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(user.mail),
            const SizedBox(height: 8),
            Text(user.comment.isNotEmpty ? user.comment : "Sin comentarios"),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: onEdit, // Siempre permite editar; maneja ID en el controlador
              child: const Text('Editar'),
            ),
          ],
        ),
      ),
    );
  }
}
