<div class="radio_group form_control d-flex">
   <label class="form-label left_side">$Title:</label>
    <div class="d-flex">
        <% loop $Options %>
            <label class="radio-wrapper">
                <input type="radio" name="$Name" value="$Value" id="$ID" required="required" $AttributesHTML <% if $isChecked %>checked="checked"<% end_if %> />
                <span class="custom-radio"></span> $Title
            </label>
        <% end_loop %>
    </div>
</div>
