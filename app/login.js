document.querySelector('#loginForm').addEventListener('submit', function(e) {
  e.preventDefault();

  const email = document.querySelector('input[type="text"]').value.trim();
  const password = document.querySelector('input[type="password"]').value.trim();

  const existingMsg = document.querySelector('.message');
  if (existingMsg) existingMsg.remove();

  const msg = document.createElement('p');
  msg.classList.add('message');

  // Demo credentials check
  if (email === 'hire-me@anshumat.org' && password === 'HireMe@2025!') {
    // Save email in sessionStorage
    sessionStorage.setItem("email", email);

    // Redirect to welcome page
    window.location.href = "welcome.html";

  } else {
    msg.textContent = 'Invalid email or password. Please try again.';
    msg.style.color = 'red';
    this.appendChild(msg);
  }
});
