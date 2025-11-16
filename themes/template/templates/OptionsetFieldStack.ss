<ul>
   
  
        <% loop $Options %>
        <li>
        	<div class="radio_group">
												<div class="row">
													<div class="col-md-6 col-8">$Title:</div>
													<div class="col-md-6 col-4">
														<label class="radio-wrapper justify-content-md-start justify-content-sm-end">
															<input type="radio" name="$Name" value="$Value" id="$ID" required="required" $AttributesHTML <% if $isChecked %>checked="checked"<% end_if %> />
															<span class="custom-radio"></span>
														</label>
													</div>
												</div>	
											</div>
        
            
        </li>
        <% end_loop %>
 
</ul>
