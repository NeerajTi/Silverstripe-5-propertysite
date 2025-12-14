jQuery(document).ready(function($) {

	function toggleMobileNav() {
      if ($(window).width() <= 767) {
        $('.mobile-bottom-nav').show();
      } else {
        $('.mobile-bottom-nav').hide();
      }
    }

    toggleMobileNav(); // Initial check

    $(window).on('resize', function () {
      toggleMobileNav(); // Recheck on resize
    });
	

	$('.recently_projects').owlCarousel({
		loop: true,
		margin: 20,
		dots: true,
		nav: false,
		autoplay: false,
		smartSpeed: 600,
		center: true,
		responsive: {
			0: {
				items: 1
			},
			768: {
				items: 2
			},
			1280: {
				items: 3
			}
		}
	});

    $(".news-carousel").owlCarousel({
		loop: true,
		margin: 20,
		dots: true,
		nav: false,
		autoplay: true,
		smartSpeed: 600,
		responsive: {
			0: { items: 1 },
			768: { items: 2 },
			1024: { items: 3 },
			1280: { items: 4 }
		}
	});

    //tabs

	$('#horizontalTab').easyResponsiveTabs({
		type: 'default', //Types: default, vertical, accordion           
		width: 'auto', //auto or any width like 600px
		fit: true,   // 100% fit in a container
		closed: 'accordion', // Start closed if in accordion view
		activate: function(event) { // Callback function if tab is switched
		var $tab = $(this);
		var $info = $('#tabInfo');
		var $name = $('span', $info);
		$name.text($tab.text());
		$info.show();
		}

	});
	$('.dashboardwrapper').on('input', '.sumarg', function() {
		var sum = 0;
		$('.sumarg').each(function() {
			var val = parseFloat($(this).val()) || 0;
			sum += val;
		});
		// Format sum to 2 decimal places without trailing zeros
		sum = Number.parseFloat(sum.toFixed(2));
		$('.totalsum').val(sum);
	});
	$(".add-to-wishlist").on('click', function(e) {
		e.preventDefault();
		var btn = $(this);
		var objectID = btn.data('objectid');
		var icon = $(this).find('i');
		var securityID = $('input[name="SecurityID"]').val();
		$.ajax({
			url: '/wishlist/addtowishlist',
			method: 'POST',
			data: {
				SecurityID: securityID,
				objectID: objectID
			},
			success: function(res) {
				console.log(res);
				if (res.ok) {
					Swal.fire({
						title: 'Wishlist',
						text: res.message,
						icon: 'success',
						confirmButtonText: 'OK'
					});
					if(res.action=='add'){
						icon.removeClass('fa-regular').addClass('fa-solid');
					}else{
						icon.removeClass('fa-solid').addClass('fa-regular');
						if($(".wishlist-"+objectID).length>0){
							$(".wishlist-"+objectID).remove();
						}
					}
				
				} else {
					Swal.fire({
						title: 'Wishlist',
						text: res.message,
						icon: 'error',
						confirmButtonText: 'OK'
					});
				}
			},
			error: function(xhr) {
				Swal.fire({
					title: 'Wishlist',
					text: 'Serverfehler: ' + xhr.status,
					icon: 'error',
					confirmButtonText: 'OK'
				});
			}
		});
	});


	$(".start-subscription").click(function (e) {
		var actionUrl = $(this).data('action-url');
		Swal.fire({
			title: 'Starte',
			text: 'This action will start subscription. Are you sure?',
			icon: 'warning',
			confirmButtonText: 'Proceed',
			cancelButtonText: 'Cancel',
			showCancelButton: true
		}).then((result) => {
			if (result.isConfirmed) {
				// Add loader to the button or show spinner globally
				const spinner = $('<div class="text-center my-3" id="spinner-container">' +
					'<div class="spinner-border text-primary" role="status">' +
					'<span class="visually-hidden">Loading...</span>' +
					'</div>' +
					'</div>');
				Swal.fire({
					title: 'Processing...',
					html: spinner,
					allowOutsideClick: false,
					showConfirmButton: false,
					showCancelButton: false,
					didOpen: () => {
						Swal.showLoading(); // Optional: shows SweetAlert's internal loader
					}
				});
	
				$.ajax({
					url: actionUrl,
					method: 'POST',
					data: {
						SecurityID: $('input[name="SecurityID"]').val()
					},
					success: function (res) {
						Swal.close(); // Close spinner dialog
						if (res.ok) {
							//window.location.href = '/account-removed';
							Swal.fire({
								title: 'Anhalten',
								text: res.message,
								icon: 'success',
								confirmButtonText: 'OK'
							});
							$('.stop-subscription').show();
							$('.start-subscription').hide();
						} else {
							Swal.fire({
								title: 'Anhalten',
								text: res.message,
								icon: 'error',
								confirmButtonText: 'OK'
							});
						}
					},
					error: function (xhr) {
						Swal.close(); // Close spinner dialog
						Swal.fire({
							title: 'Anhalten',
							text: 'Serverfehler: ' + xhr.status,
							icon: 'error',
							confirmButtonText: 'OK'
						});
					}
				});
			} else if (result.isDismissed) {
				console.log('Cancel action triggered');
			}
		});
	});

	$(".stop-subscription").click(function (e) {
		var actionUrl = $(this).data('action-url');
		Swal.fire({
			title: 'Anhalten',
			text: 'This action will stop subscription. Are you sure?',
			icon: 'warning',
			confirmButtonText: 'Proceed',
			cancelButtonText: 'Cancel',
			showCancelButton: true
		}).then((result) => {
			if (result.isConfirmed) {
				// Add loader to the button or show spinner globally
				const spinner = $('<div class="text-center my-3" id="spinner-container">' +
					'<div class="spinner-border text-primary" role="status">' +
					'<span class="visually-hidden">Loading...</span>' +
					'</div>' +
					'</div>');
				Swal.fire({
					title: 'Processing...',
					html: spinner,
					allowOutsideClick: false,
					showConfirmButton: false,
					showCancelButton: false,
					didOpen: () => {
						Swal.showLoading(); // Optional: shows SweetAlert's internal loader
					}
				});
	
				$.ajax({
					url: actionUrl,
					method: 'POST',
					data: {
						SecurityID: $('input[name="SecurityID"]').val()
					},
					success: function (res) {
						Swal.close(); // Close spinner dialog
						if (res.ok) {
							//window.location.href = '/account-removed';
							Swal.fire({
								title: 'Anhalten',
								text: res.message,
								icon: 'success',
								confirmButtonText: 'OK'
							});
							$('.stop-subscription').hide();
							$('.start-subscription').show();
						} else {
							Swal.fire({
								title: 'Anhalten',
								text: res.message,
								icon: 'error',
								confirmButtonText: 'OK'
							});
						}
					},
					error: function (xhr) {
						Swal.close(); // Close spinner dialog
						Swal.fire({
							title: 'Anhalten',
							text: 'Serverfehler: ' + xhr.status,
							icon: 'error',
							confirmButtonText: 'OK'
						});
					}
				});
			} else if (result.isDismissed) {
				console.log('Cancel action triggered');
			}
		});
	});

	$(".remove-apartment").click(function (e) {
		var apartmentID = $(this).data('apartment-id');
		Swal.fire({
			title: 'Anhalten',
			text: 'This action will remove this property. Are you sure?',
			icon: 'warning',
			confirmButtonText: 'Proceed',
			cancelButtonText: 'Cancel',
			showCancelButton: true
		}).then((result) => {
			if (result.isConfirmed) {
				// Add loader to the button or show spinner globally
				const spinner = $('<div class="text-center my-3" id="spinner-container">' +
					'<div class="spinner-border text-primary" role="status">' +
					'<span class="visually-hidden">Loading...</span>' +
					'</div>' +
					'</div>');
				Swal.fire({
					title: 'Processing...',
					html: spinner,
					allowOutsideClick: false,
					showConfirmButton: false,
					showCancelButton: false,
					didOpen: () => {
						Swal.showLoading(); // Optional: shows SweetAlert's internal loader
					}
				});
				
				$.ajax({
					url: '/dashboard/remove-apartment',
					method: 'POST',
					data: {
						apartmentID: apartmentID,
						SecurityID: $('input[name="SecurityID"]').val()
					},
					success: function (res) {
						Swal.close(); // Close spinner dialog
						if (res.ok) {
							Swal.fire({
								title: 'Anhalten',
								text: res.message,
								icon: 'success',
								confirmButtonText: 'OK'
							});
							$('#apartment-row-'+apartmentID).remove();
						} else {
							Swal.fire({
								title: 'Anhalten',
								text: res.message,
								icon: 'error',
								confirmButtonText: 'OK'
							});
						}
					},
					error: function (xhr) {
						Swal.close(); // Close spinner dialog
						Swal.fire({
							title: 'Anhalten',
							text: 'Serverfehler: ' + xhr.status,
							icon: 'error',
							confirmButtonText: 'OK'
						});
					}
				});
			} else if (result.isDismissed) {
				console.log('Cancel action triggered');
			}
		});
	});

	$(".change-apartment-status").on('change', function() {
		var apartmentID = $(this).data('apartment-id');
		var status = $(this).val();
		Swal.fire({
			title: 'Anhalten',
			text: 'Property status will be changed. Are you sure?',
			icon: 'warning',
			confirmButtonText: 'Proceed',
			cancelButtonText: 'Cancel',
			showCancelButton: true
		}).then((result) => {
			if (result.isConfirmed) {
				// Add loader to the button or show spinner globally
				const spinner = $('<div class="text-center my-3" id="spinner-container">' +
					'<div class="spinner-border text-primary" role="status">' +
					'<span class="visually-hidden">Loading...</span>' +
					'</div>' +
					'</div>');
				Swal.fire({
					title: 'Processing...',
					html: spinner,
					allowOutsideClick: false,
					showConfirmButton: false,
					showCancelButton: false,
					didOpen: () => {
						Swal.showLoading(); // Optional: shows SweetAlert's internal loader
					}
				});
		$.ajax({
			url: '/dashboard/change-apartment-status',
			method: 'POST',
			data: {
				apartmentID: apartmentID,
				status: status,
				SecurityID: $('input[name="SecurityID"]').val()
			},
			success: function (res) {
				if (res.ok) {
					Swal.fire({
						title: 'Anhalten',
						text: res.message,
						icon: 'success',
						confirmButtonText: 'OK'
					});
				} else {
					Swal.fire({
						title: 'Anhalten',
						text: res.message,
						icon: 'error',
						confirmButtonText: 'OK'
					});
				}
			},
			error: function (xhr) {
				Swal.fire({
					title: 'Anhalten',
					text: 'Serverfehler: ' + xhr.status,
					icon: 'error',
					confirmButtonText: 'OK'
				});
			}
		});
		} else if (result.isDismissed) {
				console.log('Cancel action triggered');
			}
		});
	});
	$(".delete-account-btn").click(function (e) {
         var actionUrl=$(this).data('action-url');
		 var alertmsg=$(this).data('alert-msg');
		 var redirectUrl=$(this).data('redirect-url');
		 var msg="This action will remove your account from our site. Are you sure?";
		 if(alertmsg){
         msg=alertmsg;
		 }
		 Swal.fire({
              title: 'Delete',
              text: msg,
              icon: 'warning',
              confirmButtonText: 'Proceed',
              cancelButtonText: 'Cancel',
              showCancelButton: true

		 }).then((result) => {
if (result.isConfirmed) {
	const spinner = $('<div class="text-center my-3" id="spinner-container">' +
					'<div class="spinner-border text-primary" role="status">' +
					'<span class="visually-hidden">Loading...</span>' +
					'</div>' +
					'</div>');
				Swal.fire({
					title: 'Processing...',
					html: spinner,
					allowOutsideClick: false,
					showConfirmButton: false,
					showCancelButton: false,
					didOpen: () => {
						Swal.showLoading(); // Optional: shows SweetAlert's internal loader
					}
				});

	$.ajax({
			url: actionUrl,
			method: 'POST',
			data: {
				SecurityID: $('input[name="SecurityID"]').val()
			},
			success: function (res) {
				if (res.ok) {
					Swal.fire({
						title: 'Anhalten',
						text: res.message,
						icon: 'success',
						confirmButtonText: 'OK'
					});
					if(redirectUrl)
						window.location.href = redirectUrl;
					else
					window.location.href = '/login';
				} else {
					Swal.fire({
						title: 'Anhalten',
						text: res.message,
						icon: 'error',
						confirmButtonText: 'OK'
					});
				}
			},
			error: function (xhr) {
				Swal.fire({
					title: 'Anhalten',
					text: 'Serverfehler: ' + xhr.status,
					icon: 'error',
					confirmButtonText: 'OK'
				});
			}
		});


} else if (result.isDismissed) {
				console.log('Cancel action triggered');
			}



		 })
	})

	if(document.querySelectorAll('.notification-toggle')){
	document.querySelectorAll('.notification-toggle').forEach(checkbox => {
		checkbox.addEventListener('change', function() {
		  const isChecked = this.checked ? 1 : 0;
		  const notificationNum = this.dataset.notification;
	  
		  fetch('/renter-dashboard/savenotificationalert', {
			method: 'POST',
			headers: { 'Content-Type': 'application/json' },
			body: JSON.stringify({
			  notificationNum,
			  isChecked,
			}),
			credentials: 'same-origin'
		  })
		  .then(res => res.json())
		  .then(data => {
			if(data.ok) {
			  Swal.fire({
				title: 'Benachrichtigung',
				text: 'Your Notfication alert saved successfully',
				icon: 'success',
				confirmButtonText: 'OK'
			  });
			} else {
			  Swal.fire({
				title: 'Benachrichtigung',
				text: 'Failed to save notification toggle',
				icon: 'error',
				confirmButtonText: 'OK'
			  });
			}
		  })
		  .catch(err => {
			Swal.fire({
				title: 'Benachrichtigung',
				text: 'Failed to save notification toggle',
				icon: 'error',
				confirmButtonText: 'OK'
			  });
		  });
		});
	  });
	}


});
if (document.querySelector('.user-save-search')) {
	document.querySelector('.user-save-search').addEventListener('click', async function (e) {
	  e.preventDefault();
  
	  const btn = this;
	 
	  const payload = buildPayload();
  
	 
  
	  try {
		const res = await fetch('/save-search-action/storesearch', {
		  method: 'POST',
		  headers: {
			'X-Requested-With': 'XMLHttpRequest'
		  },
		  body: payload
		});
  
		const result = await res.json();
  
		if (result.ok) {
		  Swal.fire({
			title: '',
			text: result.message,
			icon: 'success',
			confirmButtonText: 'OK'
		  });
  
		  
		} else {
		  Swal.fire({
			title: '',
			text: result.message,
			icon: 'error',
			confirmButtonText: 'OK'
		  });
		}
  
	  } catch (err) {
		console.error('AJAX error:', err);
		Swal.fire({
		  title: '',
		  text: 'Serverfehler: ' + err.message,
		  icon: 'error',
		  confirmButtonText: 'OK'
		});
	  }
	});
  }
  
document.addEventListener('DOMContentLoaded', function () {
	const openButtons = document.querySelectorAll('.open-map');
	const closeButtons = document.querySelectorAll('.map-close');

	openButtons.forEach(button => {
		button.addEventListener('click', function (e) {
			e.preventDefault();
			const targetId = this.getAttribute('data-target');
			document.getElementById(targetId).style.display = 'block';
		});
	});

	closeButtons.forEach(button => {
		button.addEventListener('click', function () {
			this.closest('.map-modal').style.display = 'none';
		});
	});

	window.addEventListener('click', function (e) {
		if (e.target.classList.contains('map-modal')) {
			e.target.style.display = 'none';
		}
	});
});

document.addEventListener('DOMContentLoaded', function () {
    const otpFields = document.querySelectorAll('.otpCls');

    otpFields.forEach((field, index) => {
        field.setAttribute('inputmode', 'numeric'); // mobile numeric keyboard
        field.setAttribute('pattern', '[0-9]*');

        field.addEventListener('input', function () {
            const value = field.value;

            // Allow only digits
            if (!/^\d$/.test(value)) {
                field.value = '';
                return;
            }

            // Move to next field if exists
            if (value && otpFields[index + 1]) {
                otpFields[index + 1].focus();
            }
        });

        field.addEventListener('keydown', function (e) {
            // Go to previous field on Backspace if empty
            if (e.key === 'Backspace' && !field.value && otpFields[index - 1]) {
                otpFields[index - 1].focus();
            }
        });
    });
});

document.addEventListener('DOMContentLoaded', function () {
  const textareas = document.querySelectorAll('.char-count');

  textareas.forEach(textarea => {
    const max = textarea.getAttribute('data-maxlength');
    const counter = document.createElement('span');
    counter.className = 'words_count';
    textarea.parentNode.appendChild(counter);

    const updateCount = () => {
      const remaining = max - textarea.value.length;
      counter.textContent = `Noch ${remaining} zeigen`;
    };

    textarea.addEventListener('input', updateCount);
    updateCount(); // initial update
  });
});


function initMobileCarousel() {
    const $carousel = $('.icon_blocks_wrapper');
    const width = $(window).width();

    // Destroy on desktop
    if (width >= 1199) {
        if ($carousel.hasClass('owl-loaded')) {
            $carousel.trigger('destroy.owl.carousel').removeClass('owl-carousel owl-loaded');
            $carousel.find('.owl-stage-outer').children().unwrap();
        }
        return;
    }

    // Only init if not already loaded
    if (!$carousel.hasClass('owl-loaded')) {
        $carousel.addClass('owl-carousel').owlCarousel({
            items: width <= 767 ? 1 : 2, // 1 for mobile, 2 for tablet (768px–1198px)
            margin: 10,
            dots: true,
            nav: false
        });
    }
}

jQuery(document).ready(function($) {
	initMobileCarousel();
	$(window).on('resize', initMobileCarousel);
	document.addEventListener("DOMContentLoaded", function () {
	if (document.querySelector(".apartment-upload-step")) {
		$(".apartment-upload-step").on('click', '.delete-btn', function(e) {
			e.preventDefault();
		
			if (!confirm("Datei wirklich löschen?")) return;
		
			var btn = $(this);
			var field = btn.data('field');
			var fileslot = btn.closest('.file-slot');
			var apartmentID = btn.data('apartment');
			var securityID = $('input[name="SecurityID"]').val();
		
			$.ajax({
				url: '/apartment/deleteFile?apartmentID=' + apartmentID,
				method: 'POST',
				data: {
					field: field,
					SecurityID: securityID
				},
				success: function(res) {
					if (res.ok) {
						alert("Datei gelöscht: " + field);
						// update UI: remove preview, disable button
						fileslot.fadeOut();
					} else {
						alert(res.error || "Fehler beim Löschen");
					}
				},
				error: function(xhr) {
					alert("Serverfehler: " + xhr.status);
				}
			});
		});
	}
});
});

function getDistrictAjax(city,replaceID){
	let districtSelect=jQuery("#"+replaceID);
	districtSelect.html('<option>Laden…</option>');
  jQuery.ajax({
    url: '/apartment/getDistrictbyCityAjax',
    method: 'GET',
    data: {
      city: city
    },
    success: function(res) {
        // Expecting res to be JSON, e.g. ["Mitte", "Kreuzberg", "Neukölln"]
    let districts = [];

    // Parse response if it's a JSON string
    if (typeof res === 'string') {
      try {
        districts = JSON.parse(res);
      } catch (e) {
        console.error('Invalid JSON response:', res);
        Swal.fire('Fehler', 'Ungültige Serverantwort', 'error');
        return;
      }
    } else {
      districts = res;
    }

    // Build select options
    let options = '<option value="">Bitte Stadtteil wählen</option>';
    districts.forEach(function(district) {
      options += `<option value="${district}">${district}</option>`;
    });

    // Replace HTML in the select element
    jQuery("#" + replaceID).html(options);
    },
    error: function(xhr) {
      Swal.fire({
        title: 'Fehler',
        text: 'Serverfehler: ' + xhr.status,
        icon: 'error',
        confirmButtonText: 'OK'
      });
    }
  });
}

