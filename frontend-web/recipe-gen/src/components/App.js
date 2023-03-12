import React from 'react';
import HomePage from './HomePage';
import ResultPage from './ResultPage';
import { BrowserRouter as Router, Route, Routes } from 'react-router-dom';

function App() {
  return (
    <Router>
      <Routes>
        <Route exact path="/" element={<HomePage/>} />
        <Route path="/result" element={<ResultPage/>} />
      </Routes>
    </Router>
  );
}

export default App;
