import React from 'react';
import logo from './static/images/logo.png';
import './css/Header.css';

function Header() {
  return (
    <div className="header">
      <img src={logo} alt="Logo" className="logo" />
    </div>
  );
}

export default Header;