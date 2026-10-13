document.addEventListener("DOMContentLoaded", function () {
  var toggle = document.querySelector(".menu-toggle");
  var nav = document.querySelector(".nav");
  if (toggle && nav) {
    toggle.addEventListener("click", function () {
      var open = nav.classList.toggle("open");
      toggle.setAttribute("aria-expanded", open);
    });
    nav.querySelectorAll("a").forEach(function (a) {
      a.addEventListener("click", function () { nav.classList.remove("open"); });
    });
  }

  var form = document.querySelector("#contact-form");
  if (form) {
    form.addEventListener("submit", function (e) {
      e.preventDefault();
      var d = new FormData(form);
      var body =
        "Name: " + d.get("first") + " " + d.get("last") + "\n" +
        "Email: " + d.get("email") + "\n" +
        "Phone: " + (d.get("phone") || "-") + "\n\n" +
        d.get("message");
      window.location.href =
        "mailto:contact@tekma-dmp.ai?subject=" +
        encodeURIComponent("Website inquiry") +
        "&body=" + encodeURIComponent(body);
    });
  }
});
