function toggle(element) {
  if(displayStyle(element) === 'none') {
    element.style.display = 'block';
  } else {
    element.style.display = 'none';
  }
}

function displayStyle(element) {
  return getComputedStyle(element, null).display;
}

window.onload = function() {
  document.getElementById("toggle-bis").onclick = function fun() {
    toggle(document.getElementById("bis"));
  }
}

