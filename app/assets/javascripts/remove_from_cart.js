document.addEventListener('DOMContentLoaded', function () {
  const removeButtons = document.querySelectorAll('.remove-button');
  removeButtons.forEach(function (button) {
    button.addEventListener('click', function (event) {
      event.preventDefault();
      const url = button.getAttribute('data-url');
      fetch(url, { method: 'DELETE' })
        .then(response => response.json())
        .then(data => {
          if (data.success) {
            // Optionally, update the cart display or do other actions
          }
        });
    });
  });
});
