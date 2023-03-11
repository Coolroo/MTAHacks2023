import React, { useState } from 'react';
import './css/Checkboxes.css';

function Checkboxes() {

  const [diets, setDiets] = useState([]);

  const [isChecked1, setIsChecked1] = useState(false);
  const [isChecked2, setIsChecked2] = useState(false);
  const [isChecked3, setIsChecked3] = useState(false);
  const [isChecked4, setIsChecked4] = useState(false);

  const handleCheckbox1Change = () => {
    setIsChecked1(!isChecked1);
  };
  const handleCheckbox2Change = () => {
    setIsChecked2(!isChecked2);
  };
  const handleCheckbox3Change = () => {
    setIsChecked3(!isChecked3);
  };
  const handleCheckbox4Change = () => {
    setIsChecked4(!isChecked4);
  };

  return (
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
  );
}

export default Checkboxes;