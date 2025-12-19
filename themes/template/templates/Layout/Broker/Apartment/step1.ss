<% include MainHeader %>

<% include Header %>

<% include DashboardHeader %>
<h1>$Title</h1>
$preview
<div class="progress_form">
	<div class="progress-container">
		<div class="progress_bar" style="width: 0;"></div>
	</div>
<form $Form.AttributesHTML>
<input type='hidden' name='preview' value='$preview' />
	<div class="row">
						<div class="col-12 col-lg-10 col-md-8">
                        <div class="form_control d-flex">
                    <label for="ObjectNumber" class="left_side">$ObjectNumber.Title:</label>
						$ObjectNumber
                        </div>
					
					<div class="form_control d-flex">
                    <label for="GroupNumber" class="left_side">$GroupNumber.Title:</label>
						$GroupNumber
					</div>
				</div>
                	<div class="col-lg-2 col-md-4">
							<div class="tipp">
								<h3><i class="bulb"><img src="/themes/template/images/bulb.svg" alt="Tips"></i> Tipp:</h3>
								<div class="small_text">Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation</div>
							</div>
						</div>
                        </div>
             
					    $WohnungType
					
                  
                 
                                <div class="default_btn text-right">
                                    $Form.Actions
                                </div>
                    </div>
                </form>
</div>
<% include DashboardFooter %>

<% include Footer %>

<% include MainFooter %>