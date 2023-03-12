import React from 'react';
import logo from './static/images/logo.png';
import './css/Header.css';
import BackButton from './BackButton';

function Header() {

  return (
    <div className="header" style={{ display: 'flex', justifyContent: 'center' }}>
      <div style={{ alignSelf: 'flex-start', marginRight: 'auto', width: '30%' }}>
      <BackButton/></div>
      <div style={{width: '40%'}}>
      <img src={logo} alt="Logo" className="logo" /></div>
      <div style={{ marginLeft: 'auto', width: '30%' }}></div>
    </div>
  );
}

export default Header;