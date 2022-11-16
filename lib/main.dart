//@dart=2.9
import 'package:flutter/material.dart';
import 'package:meals_app/screens/categories_screen.dart';
import 'package:meals_app/screens/category_meals_screen.dart';
import 'package:meals_app/screens/favorites_screen.dart';
import 'package:meals_app/screens/filters_screen.dart';
import 'package:meals_app/screens/meal_detail_screen.dart';
import 'package:meals_app/screens/tabs_screen.dart';
import 'package:meals_app/screens/tabs_screenb.dart';
import 'package:meals_app/screens/filters_screen.dart';

import 'dummy.dart';
import 'models/meal.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = const {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };



  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favoriteMeals=[];

  void setFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;

      _availableMeals = DUMMY_MEALS.where((meal) {
        if (_filters['gluten'] && !meal.isGlutenFree) {
          return false;
        }
        if (_filters['lactose'] && !meal.isLactoseFree) {
          return false;
        }
        if (_filters['vegan'] && !meal.isVegan) {
          return false;
        }
        if (_filters['vegetarian'] && !meal.isVegetarian) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  void _toggleFavorite(String mealId){
final existindex=_favoriteMeals.indexWhere((meal) => meal.id==mealId);

if(existindex >=0){
  setState((){
    _favoriteMeals.removeAt(existindex);
  });
}
else{
  setState((){
    _favoriteMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id==mealId));
  });
}

  }

  bool _isMealFavorite(String id){
    return _favoriteMeals.any((meal) => meal.id==id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DeliMeals',
      theme: ThemeData(
          primarySwatch: Colors.orange,
          accentColor: Colors.red,
          canvasColor: const Color.fromRGBO(255, 254, 229, 1),
          textTheme: ThemeData.light().textTheme.copyWith(
              bodyText1: const TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              bodyText2: const TextStyle(
                color: const Color.fromRGBO(20, 51, 51, 1),
              ),
              headline6: const TextStyle(
                  fontSize: 18,
                  fontFamily: "RobotoCondensed",
                  fontWeight: FontWeight.bold))),
      home: TabsScreenB(_favoriteMeals),
      routes: {
        CategoryMealsScreen.routeName: (ctx) =>
            CategoryMealsScreen(_availableMeals),
        MealDetailScreen.routeName: (ctx) => MealDetailScreen(_toggleFavorite,_isMealFavorite),
        FilterScreen.routeName: (ctx) => FilterScreen(_filters,setFilters),
      },
      // onGenerateRoute: (settings){
      // For rerouting when the named route does not exist
      //   print(settings.arguments);
      //   return MaterialPageRoute(builder: (ctx)=>CategoriesScreen());
      // },

      onUnknownRoute: (settings) {
        // the final fall back if on generate route or build function doesn't run its like a 404 page better than showing an app crash error
        return MaterialPageRoute(builder: (ctx) => CategoriesScreen());
      },
    );
  }
}
