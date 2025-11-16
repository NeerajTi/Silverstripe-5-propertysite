<% include MainHeader %>

	<% include Header %>

<input type="hidden" name="SecurityID" value="$SecurityID">
		<div class="mydata white_bg">
			<div class="container">
				<div class="user_name user_info">Hallo<br> $Name</div>
				<div class="back_btn"><a href="/dashboard/info/" class="back-link"><i class="fa-solid fa-arrow-left"></i> Zur Übersicht</a></div>
				<h1 class="title d-flex align-items-center justify-content-between">Selbstauskunft <div class="default_btn hide-on-mobile" style="margin-top:0;"><a href="javascript:void(0);" onclick="addWorkerModal()">hinzufügen</a></div></h1>
				
				<% if $FormError %>
                    <div class="alert alert-danger">
                        $FormError
                    </div>
                <% end_if %>
                <% if $FormSuccess %>
                    <div class="alert alert-success">
                        $FormSuccess
                    </div>
                <% end_if %>

				


				<% loop $getWorkerInformationByMember %>
				<input type="hidden" id="Model-Anrede-{$ID}" value="$Anrede">
				<input type="hidden" id="Model-FirstName-{$ID}" value="$FirstName">
				<input type="hidden" id="Model-LastName-{$ID}" value="$LastName">
				<input type="hidden" id="Model-Email-{$ID}" value="$Email">
				<input type="hidden" id="Model-Telefon-{$ID}" value="$Telefon">
				<input type="hidden" id="Model-Fax-{$ID}" value="$Fax">
				<input type="hidden" id="Model-PositionUnterneehmen-{$ID}" value="$PositionUnterneehmen">
				<input type="hidden" id="Model-Description-{$ID}" value="$Description">
				<input type="hidden" id="Model-StandaardContact-{$ID}" value="$StandaardContact">
				<input type="hidden" id="Model-ZusaEmail-{$ID}" value="$ZusaEmail">
				<input type="hidden" id="Model-Mobile-{$ID}" value="$Mobile">
				<input type="hidden" id="Model-CountryCode-{$ID}" value="$CountryCode">
				<input type="hidden" id="Model-Titel-{$ID}" value="$Titel">
				<input type="hidden" id="Model-WorkerID-{$ID}" value="$ID">
				<input type="hidden" id="Model-ImageIDdata-{$ID}" value="$ImageID">
				
				
					<div class="accordion">
					    <div class="accordion-header">
					        <div class="header-left d-flex align-items-center">
					            <% if $Image %>
					                <img src="$Image.URL" id="Model-Image-{$ID}" alt="$FirstName $LastName">
					            <% else %>
					                <img src="/themes/template/images/user_thumb.png" id="Model-Image-{$ID}" alt="User Thumb">
					            <% end_if %>
					            <div class="content">
					                <h3>$FirstName $LastName</h3>
					                <span><% if $Email %><a href="mailto:$Email">$Email</a><% end_if %></span>
					            </div>
					        </div>
					        <div class="arrow"><i class="fa-light fa-chevron-down"></i></div>
					    </div>
					    <div class="accordion-content">
					        <div class="d-md-flex gap-5 align-items-end">
					            <div class="contact-info">
					                <div class="wrap d-flex justify-content-between flex-sm-wrap gap-5">
					                    <div class="left_text flex-fill"><strong>$FirstName $LastName</strong></div>
					                    <div class="right_text flex-fill">
					                        <% if $StandaardContact %>Standaard contact<% end_if %>
					                    </div>
					                </div>
					                <div class="wrap d-flex justify-content-between flex-sm-wrap gap-5">
					                    <div class="left_text flex-fill">$PositionUnterneehmen</div>
					                    <div class="right_text flex-fill"></div>
					                </div>
					                <div class="wrap d-flex justify-content-between flex-sm-wrap gap-5">
					                    <div class="left_text flex-fill">E-mail: $Email</div>
					                    <div class="right_text flex-fill">Zusätizlche E-mail: $ZusaEmail</div>
					                </div>
					                <div class="wrap d-flex justify-content-between flex-sm-wrap gap-5">
					                    <div class="left_text flex-fill">Tel: $CountryCode $Telefon</div>
					                    <div class="right_text flex-fill">Mobiel: $Mobile</div>
					                </div>
					                <div class="wrap d-flex justify-content-between flex-sm-wrap gap-5">
					                    <div class="left_text flex-fill">Fax: $Fax</div>
					                    <div class="right_text flex-fill"></div>
					                </div>
					            </div>
					            <div class="area_content" style="min-height:200px;">
					                $Description
					            </div>
					            <div class="edit-link"><a href="javascript:void(0);" onclick="editWorkerModal({$ID})"><i class="fa-solid fa-pencil"></i> um zu sehen</a></div>
					        </div>
					    </div>
					</div>
				<% end_loop %>

				

				<div class="default_btn show-on-mobile"><a href="#">hinzufügen</a></div>

				<script>
					const accordions = document.querySelectorAll('.accordion');
					accordions.forEach(acc => {
						acc.querySelector('.accordion-header').addEventListener('click', () => {
							// Optional: Close others before opening
							accordions.forEach(item => {
								if (item !== acc) item.classList.remove('active');
							});
							acc.classList.toggle('active');
						});
					});
				</script>
			</div>
		</div>

<!-- Modal -->
<div class="modal fade" id="multiStepModal" tabindex="-1" aria-labelledby="multiStepModalLabel" aria-hidden="true">
<div class="modal-dialog modal-lg modal-dialog-centered">
<div class="modal-content">
<div class="modal-header">

<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
</div>



<div class="modal-body">
  <form $Form.AttributesHTML>
  <input type="hidden" name="AjaxFileUploadId" id='AjaxFileUploadId' value="Nodata">
<!-- Step 1 -->
<div class="step" data-step="0">
	<div class="global_custom_form white_100 width_1360">
	<h2>Miet arbeiter Angaben</h2>
			<div class="row mb-3">
					<div class="col-md-6 custom_radio">
					    $Anrede
					</div>
					<div class="col-md-6">
						$Titel
					</div>
				</div>
				<div class="row mb-3">
					<div class="col-md-6">
						$Vorname
					</div>
					<div class="col-md-6">
						$Nachname
					</div>
				</div>

				<div class="row mb-3">
					<div class="col-6 col-md-4 col-sm-4">
						$CountryCode
					</div>
					<div class="col-6 col-md-8 col-sm-8">
						$Telefon
					</div>
				</div>

				<div class="row mb-3">
					<div class="col-12">
						$Email
					</div>
				</div>

				<div class="row mb-3">
					<div class="col-12">
						$ZusaEmail
					</div>
				</div>

				<div class="row mb-3">
					<div class="col-12">
						$PositionUnterneehmen
					</div>
				</div>

				<div class="row mb-4">
					<div class="col-6">
						$Mobile
					</div>
					<div class="col-6">
						$Fax
					</div>
				</div>

				<div class="row last_row">
					<div class="col-md-6">
						$StandaardContact
					</div>
					<div class="col-md-6 align_right">
						<div class="side_bottom align_right">
								<div class="default_btn">
									<input type="button" value="Weiter" class="action nextstep">
								</div>
							</div>	
					</div>
				</div>
				$WorkerID
		</div>
</div>
<!-- Step 2 -->
<div class="step" data-step="1">
	<div class="global_custom_form white_100 width_1360">
	<a href='javascript:void(0);' class='prevstep'>Prev</a>
		  <h2>Firma omschijving</h2>
		
		  <div class="media file-slot">
							<!-- Progress + preview (matched via data-for) -->
<div class="upload-ui" data-for="ImageIDInput">
  <div class="progress" style="height:10px;">
    <div class="progress-bar" role="progressbar" style="width:0%;">0%</div>
  </div>
 
<img src="" id='ModalImage' class='upload-preview'>
</div>
		
									
						<span id='deleteoption'></span>
							</div>
			  	<div class="row mb-3">
					<div class="col-12">
		
			
						<!-- Upload label -->
					<label class="upload-box uploadtrigger" data-field="Image" for="fileUpload" data-table='RentalWorkerInformation' data-action='/dashboard/uploadFile' data-target="ImageIDInput">
							<div class="upload-left">
							<img src="https://img.icons8.com/ios-filled/50/image--v1.png" alt="icon">
							<span class="file-name" id="file-name" style="display: block;">Foto</span>
							</div>
							<span class="file-types">JPEG, PNG</span>
						</label>

						<!-- Hidden file input -->
						$Image

					</div>

					
				</div>

				<div class="row mb-3">
					<div class="col-12 textarea">
						$Description
						<span class="words_count"></span>
					</div>
				</div>
<input type='hidden' id='ObjectIDModal' value="0">
				<div class="side_bottom align_right">
					<div class="default_btn">
						$Form.Actions
					</div>
				</div>
			
		</div>
</div>
</form>
</div>

</div>
</div>
</div>
<script>  // PREV buttons
  document.querySelectorAll(".prevstep").forEach(btn => {
    btn.addEventListener("click", function () {
      if (current > 0) {
        current--;
        showStep(current);
      }
    });
  });
document.addEventListener("DOMContentLoaded", function () {
	const modal = document.getElementById("multiStepModal");
  const form  = modal.querySelector("form"); // target the modal form
  const steps = document.querySelectorAll(".step");
  let current = 0;

  function showStep(index) {
	
    steps.forEach((s, i) => s.classList.toggle("active", i === index));
  }

    // Validate only inputs within the given step element
  function validateStep(stepEl) {
    // selectable fields in this step (ignore hidden/disabled)
    const fields = stepEl.querySelectorAll("input, select, textarea");
    for (const el of fields) {
      // ignore hidden fields and disabled fields
      const isHidden = (el.type === "hidden") || (el.offsetParent === null);
      if (isHidden || el.disabled) continue;

      if (!el.checkValidity()) {
        // Show native validation message and focus
        el.reportValidity();
        el.focus({ preventScroll: true });
        return false;
      }
    }
    return true;
  }
  // attach click to all .nextandsubmit buttons
   modal.querySelectorAll(".nextstep").forEach(btn => {
    btn.addEventListener("click", function (e) {
      e.preventDefault();
      const stepEl = steps[current];

      if (!validateStep(stepEl)) return; // stop here if invalid

      if (current < steps.length - 1) {
        current++;
        showStep(current);
      } else {
        // last step → submit the modal form
        if (form.checkValidity()) {
          // requestSubmit triggers normal submit handlers & server-side validation
          form.requestSubmit();
        } else {
          // fallback: show any remaining invalids
          form.reportValidity();
        }
      }
    });
  });

    // PREV buttons
  document.querySelectorAll(".prevstep").forEach(btn => {
    btn.addEventListener("click", function () {
      if (current > 0) {
        current--;
        showStep(current);
      }
    });
  });

  // show only first step on load
  showStep(current);
});
</script>

<script>

function editWorkerModal(id){
	document.getElementById('ObjectIDModal').value = id;
	document.getElementById('ModalImage').style.display = "block";
	  const fields = [
    'FirstName',
    'LastName',
    'Email',
    'Telefon',
    'Fax',
    'PositionUnterneehmen',
    'Description',
    'StandaardContact',
    'ZusaEmail',
    'Mobile',
    'CountryCode',
    'Titel',
    'Anrede',
	'StandaardContact',
	'WorkerID',
  ];
    fields.forEach(field => {
    const hiddenInput = document.getElementById(`Model-${field}-${id}`);
	const modalInput = document.querySelector(`#multiStepModal [name="${field}"]`);
    if (hiddenInput) {
		if(field == 'Anrede' || field == 'StandaardContact'){
			const radios = document.querySelectorAll(`#multiStepModal [name="${field}"]`);
    radios.forEach(radio => {
      radio.checked = (radio.value === hiddenInput.value);
    });
		}else{
			if (modalInput) {
				modalInput.value = hiddenInput.value;
			}
		}
    }
  });
  
  if(document.getElementById(`Model-ImageIDdata-${id}`).value!=0){
	
	document.getElementById('ModalImage').src = document.getElementById(`Model-Image-${id}`).src;
	document.getElementById('deleteoption').style.display = "block";
	document.getElementById('deleteoption').innerHTML = `<button class="delete-btn" data-field="ImageID" data-objectId="${id}" data-table='RentalWorkerInformation' data-action='/dashboard/deleteFileImg'><i class="fa-solid fa-trash"></i></button>`;
  }
	  // reset step navigation to first step
  const modalEl = document.getElementById('multiStepModal');
  const steps = modalEl.querySelectorAll(".step");
  let current = 0;

  steps.forEach((s, i) => s.classList.toggle("active", i === current));

  // show modal
  var modal = new bootstrap.Modal(modalEl);
  modal.show();
}

function addWorkerModal()
{
	document.getElementById('ObjectIDModal').value='NewContact';
	document.getElementById('deleteoption').style.display = "none";
	document.getElementById('deleteoption').innerHTML = "";
	document.getElementById('ModalImage').style.display = "none";
const form = document.getElementById('Form_AddWorkerForm');
form.reset();
form.querySelectorAll('input[type="file"]').forEach(input => {
    input.value = "";
  });
	  // reset step navigation to first step
  const modalEl = document.getElementById('multiStepModal');
  const steps = modalEl.querySelectorAll(".step");
  let current = 0;

  steps.forEach((s, i) => s.classList.toggle("active", i === current));

  // show modal
  var modal = new bootstrap.Modal(modalEl);
  modal.show();
}
</script>
	<% include Footer %>

<% include MainFooter %>