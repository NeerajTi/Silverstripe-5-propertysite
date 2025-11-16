<div class="radio_group">
     <label class="form-label"></label>
  
        <% loop $Options %>
     
        <div class="d-flex">
        
            <label class="radio-wrapper">
                <input type="radio" name="$Name" value="$Value" id="$ID" $AttributesHTML <% if $isChecked %>checked="checked"<% end_if %> />
               <span class="custom-radio"></span>$Title
            </label>
        </div>
      
        <% end_loop %>
 
</div>
