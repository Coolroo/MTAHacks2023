class Recipe {
  String name = "Spogooter";
  List<dynamic> ingredients = [{"name": "noods", "amount": "12"}, {"name": "soice", "amount": "0.2375 gallons"}];
  List<dynamic> steps = ["wet your drys", "dry your wets", "wet the drys again"];

  Recipe.empty();

  Recipe (Map<dynamic, dynamic> data) {
    name = data['recipe_name'];
    ingredients = data['ingredients'];
    steps = data['steps'];
  }

  String getName() {
    return name;
  }

  List<dynamic> getIngredients() {
    return ingredients;
  }

  List<dynamic> getSteps() {
    return steps;
  }
}