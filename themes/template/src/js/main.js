// Import our custom CSS
import '../scss/style.scss'
import 'jquery';

// Import all of Bootstrap's JS
import * as bootstrap from 'bootstrap'

// import Swiper
import Swiper from 'swiper';
import 'swiper/swiper-bundle.min.css';

// import '@fortawesome/fontawesome-pro/js/solid';
// import '@fortawesome/fontawesome-pro/js/fontawesome';

// import GLightbox from 'glightbox';
document.querySelectorAll('.dropdown').forEach(dropdown => {
  dropdown.addEventListener('shown.bs.dropdown', () => {
    const menu = dropdown.querySelector('.dropdown-menu');
    const rect = menu.getBoundingClientRect();

    // Remove any previously set class
    menu.classList.remove('dropdown-menu-end');
    menu.classList.remove('dropdown-menu-start');

    // If overflowing on the right, align to right
    if (rect.right > window.innerWidth) {
      menu.classList.add('dropdown-menu-end');
    } else {
      menu.classList.add('dropdown-menu-start');
    }
  });
});

document.addEventListener("DOMContentLoaded", function(){
    document.querySelectorAll('.dropdown-menu').forEach(function(element){
        element.addEventListener('click', function (e) {
            e.stopPropagation();
        });
    })
    if (window.innerWidth < 992) {
        document.querySelectorAll('.navbar .dropdown').forEach(function(everydropdown){
            everydropdown.addEventListener('hidden.bs.dropdown', function () {
                // after dropdown is hidden, then find all submenus
                this.querySelectorAll('.submenu').forEach(function(everysubmenu){
                    // hide every submenu as well
                    everysubmenu.style.display = 'none';
                });
            })
        });
        document.querySelectorAll('.dropdown-menu a').forEach(function(element){
            element.addEventListener('click', function (e) {
                let nextEl = this.nextElementSibling;
                if(nextEl && nextEl.classList.contains('submenu')) {
                    e.preventDefault();
                    console.log(nextEl);
                    if(nextEl.style.display == 'block') {
                        nextEl.style.display = 'none';
                    } else {
                        nextEl.style.display = 'block';
                    }
                }
            });
        })
    }

        // Get all elements with the class ".dropdown-item.border-bottom"
        var elements = document.querySelectorAll('.dropdown-item.border-bottom');

        // Define the text you want to remove
        var textToRemove = "Wohnung mieten";

        // Iterate over each element
        elements.forEach(function(element) {
            // Get the text content of the current element
            var text = element.textContent;

            // Replace the text you want to remove with an empty string
            var newText = text.replace(textToRemove, "");

            // Update the text content of the current element with the modified text
            element.textContent = newText;
        });

    $(function() {
        const header = document.getElementById("header");
        const scrollClass = "scroll";
            if(!$(window).scrollTop()) {
                header.classList.remove(scrollClass);
            } else {
                header.classList.add(scrollClass);
            }
            $(window).scroll(function() {    
        
                    if(!$(window).scrollTop()) {
                header.classList.remove(scrollClass);
                    } else {
                header.classList.add(scrollClass);
                    }
                });
            });	


});
// document.addEventListener("DOMContentLoaded", function () {
//     // Check if there is a stored scroll position
//     const scrollPosition = localStorage.getItem("scrollPosition");
//     const logo = document.getElementById("logo");
//     if (scrollPosition) {
//       window.scrollTo(0, scrollPosition);
//     }
  
//     // Add scroll event listener
//     window.addEventListener("scroll", function () {
//       const header = document.getElementById("header");
//       const scrollClass = "scroll";
//       const scrollY = window.scrollY;
  
//       // Add or remove the 'scroll' class based on scroll position
//       if (scrollY > 0) {
//         header.classList.add(scrollClass);
//         logo.src = scrolledLogoUrl;
//       } else {
//         header.classList.remove(scrollClass);
//         logo.src = originalLogoUrl;
//       }
  
//     });
//     window.addEventListener("beforeunload", function () {
//         // Store the scroll position in localStorage just before the page is refreshed
//         localStorage.setItem("scrollPosition", window.scrollY.toString());
//     });
//   });
  
