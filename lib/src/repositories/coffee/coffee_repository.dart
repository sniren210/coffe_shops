import 'package:dimy_teknologi_quiz/dimy_teknologi_quiz.dart';

class CoffeeRepository
    extends SingleChangeNotifierProvider<List<CoffeHotModel>> {
  final coffeeServices = CoffeHotService();

  @override
  Future<List<CoffeHotModel>> fetch() async {
    final res = await coffeeServices.getAll();

    res.sort((a, b) {
      int aValue = a.id;
      int bValue = b.id;

      return aValue < bValue ? 1 : 0;
    });

    return res;
  }
}
