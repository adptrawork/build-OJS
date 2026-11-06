// JRDC prototype — vanilla only (mobile nav + dropdown a11y)
(function () {
  var toggle = document.querySelector(".nav-toggle");
  var nav = document.getElementById("main-nav");
  if (toggle && nav) {
    toggle.addEventListener("click", function () {
      var open = nav.classList.toggle("open");
      toggle.setAttribute("aria-expanded", String(open));
      toggle.setAttribute("aria-label", open ? "Tutup menu" : "Buka menu");
    });
  }

  var dropdowns = document.querySelectorAll(".dropdown");
  dropdowns.forEach(function (dd) {
    var btn = dd.querySelector(".dropdown-btn");
    if (!btn) return;
    btn.addEventListener("click", function () {
      var wasOpen = dd.classList.contains("open");
      dropdowns.forEach(function (d) {
        d.classList.remove("open");
        d.querySelector(".dropdown-btn").setAttribute("aria-expanded", "false");
      });
      if (!wasOpen) {
        dd.classList.add("open");
        btn.setAttribute("aria-expanded", "true");
      }
    });
  });

  document.addEventListener("click", function (e) {
    if (!e.target.closest(".dropdown")) {
      dropdowns.forEach(function (d) {
        d.classList.remove("open");
        d.querySelector(".dropdown-btn").setAttribute("aria-expanded", "false");
      });
    }
  });

  document.addEventListener("keydown", function (e) {
    if (e.key !== "Escape") return;
    dropdowns.forEach(function (d) {
      d.classList.remove("open");
      d.querySelector(".dropdown-btn").setAttribute("aria-expanded", "false");
    });
    if (nav && nav.classList.contains("open")) {
      nav.classList.remove("open");
      toggle.setAttribute("aria-expanded", "false");
    }
  });
})();
