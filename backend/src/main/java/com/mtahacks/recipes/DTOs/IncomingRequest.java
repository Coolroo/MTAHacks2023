package com.mtahacks.recipes.DTOs;

import java.util.List;

public record IncomingRequest(List<String> ingredients, List<String> dietaryRestrictions, List<String> excludedIngredients) {
}
