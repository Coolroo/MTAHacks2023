package com.mtahacks.recipes.service;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.mtahacks.recipes.DTOs.IncomingRequest;
import com.mtahacks.recipes.DTOs.Recipe;
import com.theokanning.openai.completion.CompletionRequest;
import com.theokanning.openai.completion.chat.ChatCompletionRequest;
import com.theokanning.openai.completion.chat.ChatMessage;
import com.theokanning.openai.service.OpenAiService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

import java.util.List;

@Component
public class OpenAIService {

    private static final String KEY = "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";

    private final OpenAiService service;

    Logger logger = LoggerFactory.getLogger(OpenAIService.class);


    public OpenAIService(){
        service = new OpenAiService(KEY);
    }

    public Recipe getRecipe(IncomingRequest request){
        CompletionRequest completionRequest = CompletionRequest.builder()
                .prompt( buildPrompt(request))
                .model("text-davinci-003")
                .maxTokens(3850)
                .build();
        var response = service.createCompletion(completionRequest).getChoices().get(0).getText();
        try{
            return new ObjectMapper().readValue(response, Recipe.class);
        } catch (JsonProcessingException e) {
            throw new RuntimeException(e);
        }
    }

    private static String buildPrompt(IncomingRequest request){
        String ingredients = String.join(",", request.ingredients());
        String restrictions = "";
        if(request.dietaryRestrictions().size() > 0){
            restrictions = "The recipe must consider the following dietary restrictions: " + String.join(",", request.dietaryRestrictions()) + "\n";
        }
        String restrictedIngredients = "";
        if(request.excludedIngredients().size() > 0){
            restrictedIngredients = "The recipe cannot contain any of the following ingredients: " + String.join(",", request.excludedIngredients()) + "\n";
        }
        return String.format("""
                I am going to provide you a list of ingredients, I want you to generate a recipe that takes less than 30 minutes to prepare using the ingredients provided. The recipe should use one or more of the provided ingredients.
                The recipe should be delivered in JSON format. The name of the recipe should be in the JSON object as a string at the key "recipe_name". The ingredients should be in the JSON object with the key "ingredients", and should be listed in a JSON list, and the individual ingredients should resemble the following JSON object: {"name": *ingredient_name*, "amount": *amount of ingredient needed*}. wrap the amount of ingredients needed in double quotes
                The steps should be in a JSON array and should just be strings.
                Do not provide any text except for the requested JSON.
                %s%s
                Do not provide any text except for the requested JSON. Any additional text should be discarded.
                The ingredients are: %s\n""", restrictions, restrictedIngredients, ingredients);
    }
}
