<% include MainHeader %>

	<% include Header %>

<input type="hidden" name="SecurityID" value="$SecurityID">
		<div class="mydata white_bg">
			<div class="container">
				<div class="user_name user_info">Hallo<br> $Name</div>
				<div class="back_btn"><a href="/dashboard/info/" class="back-link"><i class="fa-solid fa-arrow-left"></i> Zur Übersicht</a></div>
				<h1 class="title">Firma</h1>
				<div class="progress_form filled_form edit_mode">
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
					<form $Form.AttributesHTML>
						<div class="row">
							<div class="col-md-8">
								<div class="form_control">
									<div class="row">
										<div class="col-md-6 mb-4 mb-md-0">
											<div class="filled_input">$Company.Firmaname</div>
										</div>
										<div class="col-md-6">
											<div class="filled_input">$Company.HRBHRA</div>
										</div>
									</div>
								</div>
								<div class="form_control">
									<div class="col-md-12">
										<div class="filled_input">
										$Company.Strabe,$Company.Nr
										<Br>
										$Company.Plz,$Company.Ort,$Company.Land
										</div>
									</div>
								</div>
								<div class="form_control">
									<div class="row">
										<div class="col-md-12">
											<div class="filled_input">Telefon: $Company.CountryCode $Company.Telefon</div>
										</div>
									</div>
								</div>
								<div class="form_control">
									<div class="col-md-12">
										<div class="filled_input">$Company.Email</div>
									</div>
								</div>
								<div class="form_control">
									<div class="row">
										<div class="col-md-6 mb-4 mb-md-0">
											<div class="filled_input">$Company.Website</div>
										</div>
										<div class="col-md-6">
											<div class="filled_input">$Company.Fax</div>
										</div>
									</div>
								</div>
							</div>
							<div class="col-md-4">
								<div class="media">
								<% if $Company && $Company.Image %>
  									<img src="$Company.Image.Link" alt="$Company.Firmaname.ATT">
								<% else %>
								<img class="rounded-3" src="https://placehold.co/122x96" alt="User Placeholder"></div>
								<% end_if %>
							</div>
							<div class="short_content">$Company.Description</div>
						</div>
						$MemberID
						<div class="default_btn text-right"><a href='javascript:void(0);' data-bs-toggle="modal" data-bs-target="#multiStepModal"><i class="fa-solid fa-pen"></i> um zu sehen</a></div>
					</form>
				</div>
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
<!-- Step 1 -->
<div class="step" data-step="0">
	<div class="global_custom_form white_100 width_1360">
			<h2>Firma</h2>
			
			

				<div class="row mb-3">
					<div class="col-md-6">
						$Firmaname
					</div>
					<div class="col-md-6">
						$HRBHRA
					</div>
				</div>
	<div class="row mb-3">
					<div class="col-md-10 col-sm-10">
						$Strabe
					</div>
					<div class="col-md-2 col-sm-2">
						$Nr
					</div>
				</div>

				<div class="row mb-3">
					<div class="col-md-2 col-sm-2">
						$Plz
					</div>
					<div class="col-md-5 col-sm-5">
						$Ort
					</div>
					<div class="col-md-5 col-sm-5">
						$Land
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

				<div class="row mb-4">
					<div class="col-12">
						$Email
					</div>
				</div>
<div class="row mb-4">
					<div class="col-12 col-sm-6">
						$Website
					</div>
					<div class="col-12 col-sm-6">
						$Fax
					</div>
				</div>
				<div class="side_bottom align_right">
					<div class="default_btn">
					<input type="button" name="action_doRegister" value="Weiter" class="action nextstep" id="Form_UpdateCompanyForm_action_doRegister">
					</div>
				</div>
		
		</div>
</div>
<!-- Step 2 -->
<div class="step" data-step="1">
	<div class="global_custom_form white_100 width_1360">
	<div class="back_btn"><a href="javascript:void(0);" class="back-link prevstep"><i class="fa-solid fa-arrow-left"></i> Zur Übersicht</a></div>
		  <h2>Firma omschijving  <i class="fa-solid fa-circle-info"></i></h2>
		
		  <div class="media file-slot">
		  <div class="upload-ui" data-for="BilderIDInput">
 
								<% if $Company && $Company.Image %>
  <img src="$Company.Image.Link" alt="$Company.Firmaname.ATT" class='upload-preview'>
  <button class="delete-btn" data-field="ImageID" data-objectid="$Company.ID" data-table='MemberCompanyData' data-action='/dashboard/deleteFileImg'><i class="fa-solid fa-trash"></i></button>
<% else %>
<img src="" alt="User Placeholder" class="upload-preview" style="max-width:180px; display:none; margin-top:10px;display:none">
<% end_if %>

</div>

</div>
			  	<div class="row mb-3">
					<div class="col-12">
		
			
						<!-- Upload label -->
					<label class="upload-box uploadtrigger" for="fileUpload" data-table='MemberCompanyData' data-field="Image" data-action='/dashboard/uploadFile' data-target="BilderIDInput">
							<div class="upload-left">
							<img src="https://img.icons8.com/ios-filled/50/image--v1.png" alt="icon">
							<span class="file-name" id="file-name" style="display: block;">Bilder</span>
							</div>
							<span class="file-types">JPEG, PNG</span>
						</label>
<!-- Progress + preview (matched via data-for) -->

						<!-- Hidden file input -->
						$Bilder

					</div>

					
				</div>

				<div class="row mb-3">
					<div class="col-12 textarea">
						$Description
						<span class="words_count"></span>
					</div>
				</div>
$MemberID
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
<script>
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
  // NEXT buttons (move forward only if current step passes)
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
 // Reset form and steps when modal is opened
  modal.addEventListener("show.bs.modal", function () {
    form.reset();        // Reset form fields
    current = 0;         // Reset step index
    showStep(current);   // Show first step
  });
  // show only first step on load
  showStep(current);
});
</script>
	<% include Footer %>

<% include MainFooter %>