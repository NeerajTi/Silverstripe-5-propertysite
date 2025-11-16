function novalue() {
    $("#SearchForm_SearchForm_Search").removeAttr('value');
    $("#SearchForm_SearchForm_Search").attr('placeholder', 'Zoeken...');
    $("#SearchForm_SearchForm_action_results").val('');
}

$( document ).ready(function() {

  $('span.menu-button').click(function(){
    $('.mobilemenu-filter').removeClass('active');
    $('.mobilemenu-menu').toggleClass('active');
  });
  $('span.filter-button').click(function(){
    $('.mobilemenu-menu').removeClass('active');
    $('.mobilemenu-filter').toggleClass('active');
  });  

  $(window).load(function() {
    $('.flexslider').flexslider({
      animation: "fade",
      controlNav: false,
      directionNav: false,
      slideshowSpeed: 2000
    }); // end flexslider
  }); // end window load

  novalue();

  $('ul.nav li.dropdown').hover(function() {
    $(this).find('.dropdown-menu').stop(true, true).delay(200).fadeIn(500);
    }, function() {
      $(this).find('.dropdown-menu').stop(true, true).delay(200).fadeOut(500);
  });

  //Check to see if the window is top if not then display button
  $(window).scroll(function(){
    if ($(this).scrollTop() > 100) {
      $('.scrollToTop').fadeIn();
    } else {
      $('.scrollToTop').fadeOut();
    }
  });

  //Click event to scroll to top
  $('.scrollToTop').click(function(){
    $('html, body').animate({scrollTop : 0},800);
    return false;
  });
  
  //Tab change on click
  $('li.kamer-tab a.tab').click(function(){
    var tabId = $(this).attr('tab-id');
    $('a.tab').removeClass('active');
    $(this).addClass('active');

    $(".tabContents").each(function(){
      if ($(this).attr('id') == tabId) {
        $(this).removeClass('hide');
      } else {
        $(this).addClass('hide');
      }
    });
  });


  $("p").each(function () {
    $(this).html( $(this).html().replace(/"u/g,"ü") );
    $(this).html( $(this).html().replace(/"o/g,"ö") );
  });


  $("a").each(function () {
    $(this).html( $(this).html().replace(/"u/g,"ü") );
    $(this).html( $(this).html().replace(/"o/g,"ö") );
  });


  $("h1").each(function () {
    $(this).html( $(this).html().replace(/"u/g,"ü") );
    $(this).html( $(this).html().replace(/"o/g,"ö") );
  });


}); // end document.ready





// google maps
// function initMap(): void {
//   const directionsRenderer = new google.maps.DirectionsRenderer();
//   const directionsService = new google.maps.DirectionsService();
//   const map = new google.maps.Map(
//     document.getElementById("map") as HTMLElement,
//     {
//       zoom: 14,
//       center: { lat: 37.77, lng: -122.447 },
//     }
//   );
//   directionsRenderer.setMap(map);

//   calculateAndDisplayRoute(directionsService, directionsRenderer);
//   (document.getElementById("mode") as HTMLInputElement).addEventListener(
//     "change",
//     () => {
//       calculateAndDisplayRoute(directionsService, directionsRenderer);
//     }
//   );
// }

// function calculateAndDisplayRoute(
//   directionsService: google.maps.DirectionsService,
//   directionsRenderer: google.maps.DirectionsRenderer
// ) {
//   directionsService.route(
//     {
//       origin: { lat: $lattitude, lng: $longitude },
//       destination: { lat: $lattitude, lng: $longitude },
//       travelMode: google.maps.TravelMode['DRIVING'],
//     },
//     (response, status) => {
//       if (status == "OK") {
//         directionsRenderer.setDirections(response);
//       } else {
//         window.alert("Directions request failed due to " + status);
//       }
//     }
//   );
// }
                     



