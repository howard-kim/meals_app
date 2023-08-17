import 'package:flutter/material.dart';

import 'package:meals/data/dummy_data.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/widgets/category_grid_item.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/models/category.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({
    super.key,
    required this.availableMeals,
  });

  final List<Meal> availableMeals;

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController
      _animationController; //to implement animation, the class should be stateful and need animation Controller, this can't be initialized in class but in initstate, so we use "late"

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync:
          this, //60times per sec, 화면에 뜨게 해줌, 그래야 부드러운 애니메이션이 가능하니까, 이제 여기는 티커를 줘야해 그래서 위에 with singletickerProvider 뭐시기를 class에 추가해준것임
      duration: const Duration(milliseconds: 300),
      //lowerBound: 0,
      //upperBound: 1, 이 값들을 지정해주어야 함, 그래야 그 값들 사이에서 애니메이션이 일어나는데 내 애니메이션이 이 값을 사용할것임! 근데 0과 1은 디폴트값임
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose(); //이걸 해줘야 이 위젯 클래스가 죽고 나서 애니메이션도 죽지, 메모리 관리!
    super.dispose();
  }

  void _selectCategory(BuildContext context, Category category) {
    final filteredMeals = widget.availableMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealsScreen(
          title: category.title,
          meals: filteredMeals,
        ),
      ),
    ); // Navigator.push(context, route)
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      child: GridView(
        padding: const EdgeInsets.all(24),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        children: [
          // availableCategories.map((category) => CategoryGridItem(category: category)).toList()
          for (final category in availableCategories)
            CategoryGridItem(
              category: category,
              onSelectCategory: () {
                _selectCategory(context, category);
              },
            )
        ],
      ),
      builder: (context, child) => SlideTransition(
        position: Tween(
          begin: const Offset(0, 0.3),
          end: const Offset(0, 0),
        ).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeInOut,
          ),
        ),
        child: child,
      ),

      /*Padding(
          padding: EdgeInsets.only(top: 100 - _animationController.value * 100),
          child: child),*/
    );
  }
}
