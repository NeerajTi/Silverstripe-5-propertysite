<% include MainHeader %>

	<% include Header %>
<style>
.contact-steps {
    display: none;
}
.contact-steps.active {
    display: block;
}
</style>

		<!--Nachrichten Start-->
		<div class="mydata white_bg" style="display:block;">
			<div class="container">
				<div class="back_btn"><a href="/stadtteile-berlins" class="back-link"><i class="fa-solid fa-arrow-left"></i> Zur Übersicht</a></div>
				<div class="intrest_section progress_form">
					<div class="head_section d-md-flex justify-content-between gap-5">
					<div class="header-left d-flex align-items-center gap-3">
                    <% if $Company.Image %>
                        <img src="$Company.Image.URL" alt="User Thumb">
                    <% else %>
                        <img src="/themes/template/images/user_thumb.png" alt="User Thumb">
                    <% end_if %>
						<div class="content">
							<h3>$MemberBasicData.FirstName $MemberBasicData.LastName</h3>
							<span>Broker</span>
						</div>
					</div>
					<div class="close_profile gap-4">
						<span><i class="fa-solid fa-envelope"></i> E-mail: $Company.Email</span>
						<span><i class="fa-solid fa-phone"></i> Tel: $Company.CountryCode $Company.Telefon</span>
                    </div>
				</div>
					<div class="row">
						<div class="col-xl-4 col-md-12">
							<div class="project_view">
								<div class="image">
									<a href="/stadtteile-berlins/view/$ID">    
								<% if $Apartment.Bilder.Exists %>
  <img src="$Apartment.Bilder.First.Fill(400,300).URL" alt="$Apartment.Bilder.First.Title.ATT">
<% else %>
  <img src="/themes/template/images/image-placeholder.svg" alt="">
<% end_if %>
									</a>
								</div>

								<div class="project_info">
									<div class="project_name_price">
										<h3>
											<a href="/stadtteile-berlins/view/$ID">$Apartment.Address.Street</a>
											<span class="small">$Apartment.Address.Stadt</span>
										</h3>
										<div class="code">$Apartment.GroupNumber</div>
									</div>
									<div class="project_extra_info d-flex">
										<div class="beschikbaarvan icon_text flex-1">
											<i class="fa-regular fa-calendar"></i>
											<div class="label">Bezugsfrei ab</div>
											<div class="value">$Apartment.Details.Abdate</div>
										</div>
										<div class="surface icon_text flex-2">
											<i class="fa-solid fa-wheelchair"></i>
											<div class="label">Bohnberchtingungschein</div>
											<div class="value">&nbsp;</div>
										</div>
									</div>
									<div class="project_extra_info d-flex">
										<div class="surface icon_text">
											<i class="fa-solid fa-house"></i>
											<div class="label">Wohnfläche</div>
											<div class="value">$Apartment.Details.Wohnflache &#13217;</div>
										</div>
										<div class="beschikbaarvan icon_text">
											<i class="fa-regular fa-calendar"></i>
											<div class="label">Badezimmer</div>
											<div class="value">$Apartment.Details.Badezimmer</div>
										</div>
										
										<div class="number_of_bed icon_text">
											<i class="fa-solid fa-bed"></i>
											<div class="label">Schlafzimmer</div>
											<div class="value">$Apartment.Details.Schlafzimmer</div>
										</div>
									</div>
								</div>
							</div>

						</div>
						<div class="col-xl-8 col-md-12">
                      <form $Form.AttributesHTML>
						<div id='contact-step1' class="contact-steps active">
							<div class="form_control">
								<div class="row">
									<div class="col-md-6 mb-4 mb-md-0">
										$FirstName
									</div>
									<div class="col-md-6">
										$LastName
									</div>
								</div>
							</div>
							<div class="form_control">
								<div class="col-md-12">
									$Email
								</div>
							</div>
							<div class="form_control">
								<div class="row">
									<div class="col-md-4 mb-4 mb-md-0">
									$CountryCode
									</div>
									<div class="col-md-8">
										$Telefon
									</div>
								</div>
							</div>
							<div class="form_control">
								<div class="col-md-12">
									$Description
									<small id="desc-error" style="color:red; display:none;">Description is required</small>
								</div>
							</div>
                            $MemberID
							$ApartmentID
		<div class="side_bottom align_right">
					<div class="default_btn text-right mt-5">
						<input type="button" value="Weiter" class="step-action">
					</div>
				</div>
				</div>
				<div id="contact-step2" class="contact-steps">
				<h3>Ihre Suche</h3>
				<div class="form_control">
								<div class="row">
									<div class="col-md-6 mb-4 mb-md-0">
									<label>Stadtteil</label>
										$Stadtteil
									</div>
									<div class="col-md-6">
										$CreditCheck
									</div>
								</div>
							</div>
								<div class="form_control">
								<div class="row">
									<div class="col-md-4 mb-4 mb-md-0">
									<label>Preis</label>
										$Preis
									</div>
									<div class="col-md-4  mb-4 mb-md-0">
									<label>Wohnungfläche</label>
									<div class="input-group">
										$Wohnungflache
										<span class="input-group-text">m²</span>
										</div>
									</div>
									<div class="col-md-4">
									<label>Zimmer</label>
										$Zimmer
									</div>
								</div>
							</div>
							<div class="form_control">
								<div class="row">
									<div class="col-md-4 mb-4 mb-md-0">
									<label>Was suchen sie?</label>
										$lookingfor
									</div>
									<div class="col-md-4  mb-4 mb-md-0">
									<label>Wohnberechtigungsschein</label>
										$Wohnberechtigungsschein
									</div>
									<div class="col-md-4">
									<label>Haustiere</label>
										$Heizungsart
									</div>
								</div>
							</div>
									<div class="form_control">
								<div class="row">
									<div class="col-md-4 mb-4 mb-md-0">
									<label>Erwachsene</label>
										$Erwachsene
									</div>
									<div class="col-md-4  mb-4 mb-md-0">
									<label>Kinder</label>
										$Kinder
									</div>
									<div class="col-md-4">
									<label>Netto Haushaltseinkommen</label>
										$HouseholdIncome
									</div>
								</div>
							</div>
								<div class="side_bottom">
					<div class="default_btn text-right">
						$Form.Actions
					</div>
				</div>
				</div>
                            </form>
						</div>
					</div>
				</div>
			</div>
		</div>
	<script>
  document.querySelector(".step-action").addEventListener("click", function () {
    const descInput = document.getElementById("Form_ContactPropertyForm_Description");
    const errorMsg = document.getElementById("desc-error");

    if (descInput.value.trim() === "") {
      // Show error
      descInput.style.border = "1px solid red";
      errorMsg.style.display = "block";
      return; // stop here
    } else {
      // Clear error if filled
      descInput.style.border = "";
      errorMsg.style.display = "none";

      // Move to step 2
      goToStep("contact-step1", "contact-step2");
    }
  });

  function goToStep(currentStep, nextStep) {
    document.getElementById(currentStep).style.display = "none";
    document.getElementById(nextStep).style.display = "block";
  }
</script>
		<!--Nachrichten End-->
    	<% include Footer %>

<% include MainFooter %>