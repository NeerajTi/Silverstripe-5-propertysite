<div class="area_label">$Title:</div>
<ul>
   
  
        <% loop $Options %>
        <li>
       <div class="radio_group d-flex justify-content-between">
        $Title
            <label class="radio-wrapper">
                <input type="radio" name="$Name" value="$Value" id="$ID" required="required" $AttributesHTML <% if $isChecked %>checked="checked"<% end_if %> />
               <span class="custom-radio"></span>
            </label>
        </div>
        </li>
        <% end_loop %>
 
</ul>
