import React, { useState } from 'react';
import './css/HomePage.css';
import Header from './Header';
import Checkboxes from './Checkboxes';

function HomePage() {

    const [searchTerm, setSearchTerm] = useState('');
    const [ingredients, setIngredients] = useState([]);
    const [diets, setDiets] = useState([]);

    function removeIngredient(index) {
        const updated = [...ingredients];
        updated.splice(index, 1);
        setIngredients(updated);
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
        onKeyDown={(e) => {
            if (ingredients.includes(searchTerm.toLowerCase())) {
                setSearchTerm("");
            }
          else if (e.key === "Enter" && searchTerm !== "") {
            setIngredients([...ingredients, searchTerm.toLowerCase()]);
            setSearchTerm("");
          }
        }}
      />
      <button type="submit">→</button>

    </div>
      <br></br>
      <p>Type an ingredient then press 'Enter'. Press → to generate a recipe.</p>
      <p>Taste satisfaction NOT guaranteed.</p>
      <br></br>
      <Checkboxes></Checkboxes>
      
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