

window.addEventListener("turbolinks:load", () => {
    // Open
    document.getElementById('menu-a').addEventListener("click", e => {
        e.preventDefault();
        document.getElementById("translate").classList.toggle('translate-page');
    });
});



