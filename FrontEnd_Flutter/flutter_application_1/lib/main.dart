import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_application_1/Widgets/bottomNavigationBar.dart';
import 'package:flutter_application_1/screen/experiencies.dart';
import 'package:flutter_application_1/screen/logIn.dart';
import 'package:flutter_application_1/screen/perfil.dart';
import 'package:flutter_application_1/screen/register.dart';
import 'package:flutter_application_1/screen/user.dart';
import 'package:flutter_application_1/screen/home.dart';
import 'package:flutter_application_1/controllers/experiencesListController.dart';
import 'package:flutter_application_1/controllers/userListController.dart';



void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(ExperienceListController(), permanent: true);
  Get.put(UserListController(), permanent: true);
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
   

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      getPages: [
        // Ruta de inicio de sesión
        GetPage(
          name: '/login',
          page: () => LogInPage(),
        ),
        // Ruta de registro
        GetPage(
          name: '/register',
          page: () => RegisterPage(),
        ),
        // Ruta de la pantalla principal con BottomNavScaffold
        GetPage(
          name: '/home',
          page: () => BottomNavScaffold(child: HomePage()),
        ),
        GetPage(
          name: '/usuarios',
          page: () => BottomNavScaffold(child: UserPage()),
        ),
        GetPage(
          name: '/experiencies',
          page: () => BottomNavScaffold(child: ExperienciesPage()),
        ),
        GetPage(
          name: '/perfil',
          page: () => BottomNavScaffold(child: PerfilPage()),
        ),
      ],
    );
  }
}

