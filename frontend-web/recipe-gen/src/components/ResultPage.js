import './css/HomePage.css';
import Header from './Header';
import { useLocation } from 'react-router-dom';

function ResultPage(props) {

  const { state } = useLocation();

  const recipe_name = state.recipe_name;
  const ingredients = state.ingredients;
  const steps = state.steps;

  return (
    <div className="container">
    <Header></Header>
      <div className="content">
      <h1>{recipe_name}</h1>
      <h2>Ingredients</h2>
       <ul>
        {ingredients.map((ingredient, index) => (
          <li key={index}>{ingredient.amount} {ingredient.name}</li>
        ))}
      </ul>
      <h2>Steps</h2>
      <ol>
        {steps.map((step, index) => (
          <li key={index}>{step}</li>
        ))}
      </ol> 
    </div>
      </div>
  );
}

export default ResultPage;