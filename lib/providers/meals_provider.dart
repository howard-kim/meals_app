import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/data/dummy_data.dart';

final mealsProvider = Provider(
  (ref) {
    return dummyMeals;
  },
); //이것을 통해서 전체적인 값들을 관리할 수 있다..