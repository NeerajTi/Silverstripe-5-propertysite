
<div class="area_label col-md-6">$Title:</div>
  <div class="radio_group  col-md-6">
<div class="d-flex gap-5">
        <% loop $Options %>
            <label class="radio-wrapper inline-wrapper">
                <input type="radio" name="$Name" value="$Value" id="$ID" required="required" $AttributesHTML <% if $isChecked %>checked="checked"<% end_if %> />
                <span class="custom-radio"></span> $Title
            </label>
        <% end_loop %>
    </div>
    </div>
