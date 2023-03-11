package com.mtahacks.recipes.DTOs;

import java.util.List;

public record Recipe(String recipe_name, List<Ingredient> ingredients, List<String> steps) {
}
