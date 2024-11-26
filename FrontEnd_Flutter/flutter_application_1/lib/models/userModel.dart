import 'package:flutter/material.dart';

class UserModel with ChangeNotifier {
  String? id; // Ahora id es opcional
  String name;
  String mail;
  String password;
  String comment;

  // Constructor
  UserModel({
    this.id, // id es opcional
    required this.name,
    required this.mail,
    required this.password,
    required this.comment,
  });

  // Método para actualizar los atributos del usuario
  void setUser(String name, String mail, String password, String comment) {
    this.name = name;
    this.mail = mail;
    this.password = password;
    this.comment = comment;
    notifyListeners();
  }

  // Método para convertir desde JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'] ?? json['id'], // Acepta _id o id
      name: json['name'] ?? 'Usuario desconocido',
      mail: json['mail'] ?? 'No especificado',
      password: json['password'] ?? 'Sin contraseña',
      comment: json['comment'] ?? 'Sin comentarios',
    );
  }

  // Método para convertir a JSON
  Map<String, dynamic> toJson() {
    return {
      if (id != null) '_id': id, // Incluye id si no es null
      'name': name,
      'mail': mail,
      'password': password,
      'comment': comment,
    };
  }
}
