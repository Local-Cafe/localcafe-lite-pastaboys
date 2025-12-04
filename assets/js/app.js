// Close mobile menu when clicking a nav link (UX enhancement)
document.addEventListener('DOMContentLoaded', () => {
  const navToggle = document.getElementById('nav-toggle');
  const navLinks = document.querySelectorAll('.nav-links a');

  if (!navToggle || navLinks.length === 0) {
    return; // No mobile menu on this page
  }

  navLinks.forEach(link => {
    link.addEventListener('click', () => {
      navToggle.checked = false;
    });
  });
});
