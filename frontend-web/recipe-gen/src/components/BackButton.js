import React from 'react';
import { useLocation } from 'react-router-dom';
import './css/BackButton.css';
import { Link } from "react-router-dom";

function BackButton() {

    const location = useLocation();

    if (location.pathname !== '/result') {
        return null;
      }

  return (
    <div className="back">
        <Link to='/'>← Return to Home</Link>
    </div>
  );
}

export default BackButton;