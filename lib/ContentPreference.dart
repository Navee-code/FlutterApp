import 'package:shared_preferences/shared_preferences.dart';

class ContentPreference{
   static saveList(List<String> myList) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = myList.join(',');
    await prefs.setString('myList', jsonString);
  }

   static Future<List<String>> fetchList() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('myList') ?? '';
    final list = jsonString.split(',');
    return  list;
  }

}