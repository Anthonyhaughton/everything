// script.js

let counter = 0;

function incrementCounter() {
  counter++;
  updateCounter();
}

function decrementCounter() {
  counter--;
  updateCounter();
}

function updateCounter() {
  document.getElementById('counter').innerText = counter;
}
