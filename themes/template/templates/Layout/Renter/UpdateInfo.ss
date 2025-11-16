<% include MainHeader %>

	<% include Header %>

<input type="hidden" name="SecurityID" value="$SecurityID">
<input type='hidden' id='ObjectIDModal' value="$PersonalInformation.ID">
		<div class="mydata white_bg">
			<div class="container">
				<div class="user_name user_info">Hallo<br> $Name</div>
				<div class="back_btn"><a href="/renter-dashboard/info/" class="back-link"><i class="fa-solid fa-arrow-left"></i> Zur Übersicht</a></div>
				<h1 class="title">$Title</h1>
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
										<div class="col-md-12 mb-4 mb-md-0">
											<div class="filled_input">$PersonalInformation.Anrede $PersonalInformation.FirstName</div>
										</div>
										
									</div>
								</div>
								<div class="form_control">
									<div class="col-md-12">
										<div class="filled_input">
										$PersonalInformation.Strabe,$PersonalInformation.Nr
										<Br>
										$PersonalInformation.Plz,$PersonalInformation.Ort,$PersonalInformation.Land
										</div>
									</div>
								</div>
								<div class="form_control">
									<div class="row">
										<div class="col-md-12">
											<div class="filled_input">Telefon: $PersonalInformation.CountryCode $PersonalInformation.Telefon</div>
										</div>
									</div>
								</div>
								<div class="form_control">
									<div class="col-md-12">
										<div class="filled_input">$PersonalInformation.Email</div>
									</div>
								</div>
								<div class="form_control">
									<div class="row">
										
										<div class="col-md-12">
											<div class="filled_input">Fax: $PersonalInformation.Fax</div>
										</div>
									</div>
								</div>
							</div>
							<div class="col-md-4">
								<div class="media">
								<% if $PersonalInformation && $PersonalInformation.Bilder %>
  									<img src="$PersonalInformation.Bilder.Link" alt="$PersonalInformation.Firmaname.ATT">
								<% else %>
								<img class="rounded-3" src="https://placehold.co/122x96" alt="User Placeholder"></div>
								<% end_if %>
							</div>
							
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
<div class="step active" data-step="0">
	<div class="global_custom_form white_100 width_1360">
			<h2>$Title</h2>
			
			

				<div class="row mb-3">
					<div class="col-12 col-md-6">
						$Anrede
					</div>
					<div class="col-12 col-md-6">
					 <div class="media file-slot">
		  <div class="upload-ui" data-for="BilderIDInput">
									<% if $PersonalInformation && $PersonalInformation.Bilder %>
  <img src="$PersonalInformation.Bilder.Link" width="122" height="96" alt="$PersonalInformation.Firmaname.ATT" class='upload-preview'>
  <button class="delete-btn" data-field="BilderID" data-objectid="$PersonalInformation.ID" data-table='PersonalInformation' data-action='/renter-dashboard/deleteFileImg'><i class="fa-solid fa-trash"></i></button>
<% end_if %>
</div></div>
							<!-- Upload label -->
					<label class="upload-box uploadtrigger" for="fileUpload" data-objectid="$PersonalInformation.ID" data-table='PersonalInformation' data-field="Bilder" data-action='/renter-dashboard/uploadFile' data-target="BilderIDInput">
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
					<div class="col-md-10 col-sm-6">
						$FirstName
					</div>
					<div class="col-md-2 col-sm-6">
						$LastName
					</div>
				</div>
				<div class="row mb-3">
				<div class="col-sm-12">
					$Geburtsdatum
				</div>
				</div>
	<div class="row mb-3">
					<div class="col-md-10 col-sm-12">
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
					<div class="col-12 col-sm-6">
						$Email
					</div>
					<div class="col-12 col-sm-6">
						$Fax
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

	<% include Footer %>

<% include MainFooter %>