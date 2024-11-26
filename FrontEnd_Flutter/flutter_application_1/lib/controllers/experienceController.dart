import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_application_1/models/experienceModel.dart';
import 'package:flutter_application_1/services/experience.dart';
import 'package:flutter_application_1/controllers/experiencesListController.dart';

class ExperienceController extends GetxController {
  final ExperienceService experienceService = Get.put(ExperienceService());
  late final ExperienceListController experienceListController;

  final TextEditingController ownerController = TextEditingController();
  final TextEditingController participantsController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  var isLoading = false.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    // Inicializa experienceListController
    experienceListController = Get.find<ExperienceListController>();
  }

  Future<void> createExperience() async {
    if (ownerController.text.isEmpty ||
        participantsController.text.isEmpty ||
        descriptionController.text.isEmpty) {
      Get.snackbar('Error', 'Todos los campos son obligatorios',
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    final newExperience = ExperienceModel(
      owner: ownerController.text,
      participants: participantsController.text,
      description: descriptionController.text,
    );

    isLoading.value = true;
    errorMessage.value = '';

    try {
      print("Creando experiencia...");
      final statusCode = await experienceService.createExperience(newExperience);
      print("Código de estado del POST: $statusCode");

      if (statusCode == 200 || statusCode == 201) {
        print("Experiencia creada. Actualizando lista...");
        // Usa la instancia existente
        await experienceListController.fetchExperiences();
        Get.snackbar('Éxito', 'Experiencia creada con éxito');
      } else {
        errorMessage.value = 'Error al crear la experiencia';
        Get.snackbar(
            'Error', errorMessage.value, snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      errorMessage.value = 'Error: No se pudo conectar con la API';
      print("Error durante la creación: $e");
      Get.snackbar(
          'Error', errorMessage.value, snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }
}
