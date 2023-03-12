import React, { useState } from 'react';
import './css/HomePage.css';
import Header from './Header';

function ResultPage(props) {

  const recipe_name = props.recipe_name;
  const ingredients = props.ingredients;
  const steps = props.steps;

  return (
    <div className="container">
    <Header></Header>
      <div className="content">
      <h1>{recipe_name}</h1>
      <h2>Ingredients</h2>
      {/* <ul>
        {ingredients.map((ingredient, index) => (
          <li key={index}>{ingredient.amount} {ingredient.name}</li>
        ))}
      </ul>
      <h2>Steps</h2>
      <ol>
        {steps.map((step, index) => (
          <li key={index}>{step}</li>
        ))}
      </ol> */}
    </div>
      </div>
  );
}

export default ResultPage;