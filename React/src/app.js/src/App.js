import React, { useState } from 'react';
import './App.css'; // Import the stylesheet

function App() {
  const [counter, setCounter] = useState(0);

  const incrementCounter = () => {
    setCounter(counter + 1);
  };

  const decrementCounter = () => {
    setCounter(counter - 1);
  };

  return (
    <div className="app">
      <h1>React Counter</h1>
      <div className="counter-container">
        <p className="counter">Counter: {counter}</p>
        <div className="button-container">
          <button onClick={incrementCounter} className="increment-btn">
            Increment
          </button>
          <button onClick={decrementCounter} className="decrement-btn">
            Decrement
          </button>
        </div>
      </div>
    </div>
  );
}

export default App;
