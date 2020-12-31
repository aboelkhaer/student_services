import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_services/utility/config.dart';

readFromSharedPref(String firstName, String lastName, String email) async {
  StudentServicesApp.sharedPreferences = await SharedPreferences.getInstance();
  firstName = StudentServicesApp.sharedPreferences
      .getString(StudentServicesApp.userFirstName);
  lastName = StudentServicesApp.sharedPreferences
      .getString(StudentServicesApp.userLastName);
  email = StudentServicesApp.sharedPreferences
      .getString(StudentServicesApp.userEmail);
}
