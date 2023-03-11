class Recipe {
  String name = "Spogooter";
  List<Map<String,String>> ingredients = [{"name": "noods", "amount": "12"}, {"name": "soice", "amount": "0.2375 gallons"}];
  List<String> steps = ["wet your drys", "dry your wets", "wet the drys again"];

  String getName() {
    return name;
  }

  List<Map<String,String>> getIngredients() {
    return ingredients;
  }

  List<String> getSteps() {
    return steps;
  }
}