import 'package:flutter/material.dart';

class ExperienceModel with ChangeNotifier {
  String? _id; // Hacemos que _id sea nullable
  String _owner;
  String _participants;
  String _description;

  // Constructor
  ExperienceModel({
    String? id, // Hacemos que id sea opcional
    required String owner,
    required String participants,
    required String description,
  })  : _id = id,
        _owner = owner,
        _participants = participants,
        _description = description;

  // Getters
  String? get id => _id; // El getter de id también es nullable
  String get owner => _owner;
  String get participants => _participants;
  String get description => _description;

  // Método fromJson para crear una instancia desde un Map
  factory ExperienceModel.fromJson(Map<String, dynamic> json) {
    return ExperienceModel(
      id: json['_id'], // Asignamos el id si está disponible
      owner: json['owner']?['name'] ?? 'Propietario desconocido',
      participants: (json['participants'] as List<dynamic>)
          .map((participant) => participant['name'])
          .join(', '),
      description: json['description'] ?? 'Sin descripción',
    );
  }

  // Método toJson para convertir la instancia en un Map
  Map<String, dynamic> toJson() {
    return {
      if (_id != null) '_id': _id, // Incluimos _id solo si no es null
      'owner': _owner,
      'participants': _participants,
      'description': _description,
    };
  }
}
