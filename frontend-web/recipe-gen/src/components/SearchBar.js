import React, { useState } from 'react';

function SearchBar( props ) {

    const [searchTerm, setSearchTerm] = useState('');
    const [ingredients, setIngredients] = useState([]);

    const handleSubmit = (event) => {
        event.preventDefault();
      };

  return (
    <div>
      <input
        type="text"
        value={searchTerm}
        onChange={(e) => setSearchTerm(e.target.value)}
        onKeyDown={(e) => {
          if (e.key === "Enter") {
            setIngredients([...ingredients, searchTerm]);
            setSearchTerm("");
          }
        }}
      />
      <button type="submit">→</button>
      <div>
      {/* <ul>
        {ingredients.map((item, index) => (
          <li key={index}>{item}</li>
        ))}
      </ul> */}
        </div>
    </div>
  );
}

export default SearchBar;