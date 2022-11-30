import 'package:dimy_teknologi_quiz/dimy_teknologi_quiz.dart';
import 'package:http/http.dart' as http;

class CoffeHotService {
  final urlBase = 'api.sampleapis.com';
  final path = 'coffee/hot';

  Future<List<CoffeHotModel>> getAll() async {
    final rs = await http.get(Uri.https(urlBase, path));

    if (rs.statusCode == 200) {
      return coffeHotModelFromJson(rs.body);
    }

    throw Exception();
  }
}
