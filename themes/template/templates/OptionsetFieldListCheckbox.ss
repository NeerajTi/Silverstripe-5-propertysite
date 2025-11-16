<ul class="double_column">
   
  
        <% loop $Options %>
        <li>
        <div class="radio_group d-flex">
        $Title:
            <label class="radio-wrapper">
                <input type="checkbox" name="$Name" value="$Value" id="$ID" $AttributesHTML <% if $isChecked %>checked="checked"<% end_if %> />
               <span class="custom-radio"></span>
            </label>
        </div>
        </li>
        <% end_loop %>
 
</ul>
