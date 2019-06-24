// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
function addPhoneField(e) {
  e.preventDefault();
  let lastNumberField = document
    .getElementsByClassName('number-field')[0]
    .cloneNode(true);
  lastNumberField.firstElementChild.value = "";
  
  let numbers = document.getElementById('numbers');
  numbers.appendChild(lastNumberField);
  lastNumberField.addEventListener('click', removePhoneField)
}

function removePhoneField(e) {
  e.preventDefault();
  this.remove();
}