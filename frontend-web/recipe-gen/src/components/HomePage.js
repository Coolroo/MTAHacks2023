import React, { useState } from 'react';
import './css/HomePage.css';
import Header from './Header';
import { useNavigate } from "react-router-dom";
import axios from 'axios';

function HomePage() {

    const [searchTerm, setSearchTerm] = useState('');
    const [ingredients, setIngredients] = useState([]);

    const [isChecked1, setIsChecked1] = useState(false);
    const [isChecked2, setIsChecked2] = useState(false);
    const [isChecked3, setIsChecked3] = useState(false);
    const [isChecked4, setIsChecked4] = useState(false);

    const handleCheckbox1Change = () => { setIsChecked1(!isChecked1); };
    const handleCheckbox2Change = () => { setIsChecked2(!isChecked2); };
    const handleCheckbox3Change = () => { setIsChecked3(!isChecked3); };
    const handleCheckbox4Change = () => { setIsChecked4(!isChecked4); };

    const [isVisible, setIsVisible] = useState(false);
    const [hasError, setError] = useState(false);

    const navigate = useNavigate();
    
    function handleClick() {
    
      const diets = [];
      if (isChecked1) { diets.push("Vegan") };
      if (isChecked2) { diets.push("Vegetarian") };
      if (isChecked3) { diets.push("Dairy-free") };
      if (isChecked4) { diets.push("Gluten-free") };

      console.log(diets);

      const body = {
        ingredients: ingredients,
        dietaryRestrictions: diets,
        excludedIngredients: []
      };

      setError(false);
      setIsVisible(true);

      axios.post('https://plagueinc.coolroo.ca/recipe/getRecipe', body)
    .then(response => {
      console.log(response.data);
      navigate('/result', { state: response.data });
    })
    .catch(error => {
      setIsVisible(false);
      setError(true);
      console.log(error);
    });

    }

    function removeIngredient(index) {
        const updated = [...ingredients];
        updated.splice(index, 1);
        setIngredients(updated);
      }

    function handleKeyDown(event) {
      if (ingredients.includes(searchTerm.toLowerCase())) {
        setSearchTerm("");
      }
      else if (event.key === "Enter" && searchTerm !== "") {
      console.log('adding');
      setIngredients([...ingredients, searchTerm.toLowerCase()]);
      setSearchTerm("");
      }   
    }

  return (
    <div className="container">
    <Header></Header>
      <div className="content">
      <div>
      <input
        type="text"
        placeholder = "Eg. Potato"
        value={searchTerm}
        onChange={(e) => setSearchTerm(e.target.value)}
        onKeyDown={handleKeyDown}
      />

      <button type="submit" onClick={handleClick}>→</button>

    </div>
    <p style={{ display: isVisible ? "block" : "none"}}>Generating your recipe, please wait one moment...</p>
    <p style={{ display: hasError ? "block" : "none"}}>An error occured, please try again.</p>
      <br></br>
      <p>Type an ingredient then press 'Enter'. Press → to generate a recipe.</p>
      <p>Taste satisfaction NOT guaranteed.</p>
      <br></br>
      
      <div className="checkbox-grid">
      <div>
        <label> 
          <input
            type="checkbox"
            checked={isChecked1}
            onChange={handleCheckbox1Change}
          />
          Vegan
        </label>
      </div>
      <div>
        <label>
          <input
            type="checkbox"
            checked={isChecked2}
            onChange={handleCheckbox2Change}
          />
          Vegetarian
        </label>
      </div>
      <div>
        <label>
          <input
            type="checkbox"
            checked={isChecked3}
            onChange={handleCheckbox3Change}
          />
          Dairy-free
        </label>
      </div>
      <div>
        <label>
          <input
            type="checkbox"
            checked={isChecked4}
            onChange={handleCheckbox4Change}
          />
          Gluten-free
        </label>
      </div>
    </div>
      
      </div>
      <div className="ingredients">Ingredients (Press ⓧ to remove):</div>
      <div className="footer">
        <div className = "ingredientList">
            <ul>
        {ingredients.map((item, index) => (
          <li key={index}>{item} <button className = "ingredientButton" onClick={() => removeIngredient(index)}>ⓧ</button></li>
        ))}
      </ul>
      </div>
      </div>
    </div>
  );
}

export default HomePage;