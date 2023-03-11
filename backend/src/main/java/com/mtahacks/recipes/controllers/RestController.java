package com.mtahacks.recipes.controllers;

import com.mtahacks.recipes.DTOs.IncomingRequest;
import com.mtahacks.recipes.DTOs.Recipe;
import com.mtahacks.recipes.service.OpenAIService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestBody;

@org.springframework.web.bind.annotation.RestController
@CrossOrigin
public class RestController {

    @Autowired
    OpenAIService service;
    Logger logger = LoggerFactory.getLogger(RestController.class);
    @GetMapping("/getRecipe")
    public ResponseEntity<Recipe> getRecipe(@RequestBody IncomingRequest body){
        try{

            return ResponseEntity.ok().body(service.getRecipe(body));
        }
        catch(Exception e){
            e.printStackTrace();
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
}
