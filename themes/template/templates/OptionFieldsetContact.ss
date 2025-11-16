
        <% loop $Options %>
        	<div class="d-flex gap-4 gap-md-5 mt-4 align-items-center">
						<div class="radio_group">
							<label class="radio-wrapper">
								 <input type="radio" name="$Name" value="$Value" id="$ID" required="required" $AttributesHTML <% if $isChecked %>checked="checked"<% end_if %> />
                <span class="custom-radio"></span> 
							</label>
						</div>
						<div class="landlord_head">
							<div class="header-left d-flex align-items-center gap-3">
								<img src="/themes/template/images/user_thumb.png" alt="User Thumb">
								<div class="content">
									<h4>Contact</h4>
									<div class="email"><i class="fa-solid fa-envelope"></i> E-mail: $Title</div>
									<div class="phone"><i class="fa-solid fa-phone"></i> Tel: 06-123456789</div>
								</div>
							</div>
						</div>
                        </div>
        <% end_loop %>

 

