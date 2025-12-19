<% include MainHeader %>

<% include Header %>

<% include DashboardHeader %>
<h1>$Title</h1>
	<div class="progress_form contact_details_app">
					<div class="progress-container">
						<div class="progress_bar" style="width: 100%;"></div>
					</div>
<form $Form.AttributesHTML>
<input type='hidden' name='preview' value='$preview' />
<h2>Kontaktdaten diese wohung*:</h2>
<!--$ContactId-->
<% if $Contacts %>

<% loop $Contacts %>
<div class="d-flex gap-4 gap-md-5 mt-4 align-items-center">
						<div class="radio_group">
							<label class="radio-wrapper">
								 <input type="radio" name="ContactId" <% if $ID == $Up.SelectedContact %>checked="checked"<% end_if %> value="$ID" id="Form_step13Form_ContactId_$ID" required="required">
                <span class="custom-radio"></span> 
							</label>
						</div>
						<div class="landlord_head">
							<div class="header-left d-flex align-items-center gap-3">
							<% if $Image %>
								<img src="$Image.URL" alt="User Thumb">
							<% else %>
								<img src="/themes/template/images/user_thumb.png" alt="User Thumb">
							<% end_if %>
								<div class="content">
									<h4>$FirstName $LastName</h4>
									<div class="email"><i class="fa-solid fa-envelope"></i> E-mail: $Email</div>
									<div class="phone"><i class="fa-solid fa-phone"></i> Tel: $Telefon</div>
								</div>
							</div>
						</div>
                        </div>
<% end_loop %>
<% end_if %>

                                <div class="default_btn text-right">
                                    $Form.Actions
                                </div>
</form>
</div>
<% include DashboardFooter %>

<% include Footer %>

<% include MainFooter %>