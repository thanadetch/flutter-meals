import 'package:flutter/material.dart';
import 'package:flutter_meals/models/meal.dart';
import 'package:flutter_meals/widgets/meal_item.dart';

class CategoryMealScreen extends StatefulWidget {
  static const routeName = '/category-meals';
  final List<Meal> availableMeals;

  const CategoryMealScreen({super.key, required this.availableMeals});

  @override
  State<CategoryMealScreen> createState() => _CategoryMealScreenState();
}

class _CategoryMealScreenState extends State<CategoryMealScreen> {
  late String categoryTitle;
  late List<Meal> displayedMeals;


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final routeArgs =
    ModalRoute
        .of(context)
        ?.settings
        .arguments as Map<String, String>;
    categoryTitle = routeArgs['title']!;
    final String categoryId = routeArgs['id']!;
    displayedMeals = widget.availableMeals.where((meal) {
      return meal.categories.contains(categoryId);
    }).toList();
  }

  void _removeMeal(String mealId) {
    setState(() {
      displayedMeals.removeWhere((meal) => meal.id == mealId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          final categoryMeal = displayedMeals[index];
          return MealItem(
            id: categoryMeal.id,
            title: categoryMeal.title,
            imageUrl: categoryMeal.imageUrl,
            duration: categoryMeal.duration,
            complexity: categoryMeal.complexity,
            affordability: categoryMeal.affordability,
          );
        },
        itemCount: displayedMeals.length,
      ),
    );
  }
}
