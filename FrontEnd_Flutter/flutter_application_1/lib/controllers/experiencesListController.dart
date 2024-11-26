import 'package:get/get.dart';
import 'package:flutter_application_1/models/experienceModel.dart';
import 'package:flutter_application_1/services/experience.dart';

class ExperienceListController extends GetxController {
  var isLoading = false.obs;
  var experienceList = <ExperienceModel>[].obs;
  final ExperienceService experienceService = ExperienceService();

  @override
  void onInit() {
    super.onInit();
    fetchExperiences(); // Cargar experiencias al inicializar
  }

Future<void> fetchExperiences() async {
  try {
    print("Obteniendo experiencias...");
    isLoading(true);
    var experiences = await experienceService.getExperiences();

    if (experiences != null) {
      print("Experiencias obtenidas: ${experiences.length}");
      experienceList.assignAll(experiences); // Actualiza la lista observable
    } else {
      print("No se encontraron experiencias.");
      experienceList.clear(); // Limpia la lista si no hay datos
    }
  } catch (e) {
    print("Error al obtener experiencias: $e");
  } finally {
    isLoading(false);
  }
}

  Future<void> deleteExperienceById(String id) async {
    try {
      isLoading(true);
      var statusCode = await experienceService.deleteExperienceById(id);
      if (statusCode == 200 || statusCode == 201) {
        await fetchExperiences(); // Actualiza la lista después de eliminar
        Get.snackbar('Éxito', 'Experiencia eliminada con éxito');
      } else {
        Get.snackbar('Error', 'Error al eliminar la experiencia');
      }
    } catch (e) {
      print("Error al eliminar experiencia: $e");
      Get.snackbar('Error', 'Error al eliminar la experiencia');
    } finally {
      isLoading(false);
    }
  }
}
