<% include MainHeader %>

    <% include Header %>

        <% if $Session.FormError %>
            <p class="message bad">$Session.FormError</p>
        <% end_if %>

        <div class="login_section white_card white_85 width_1088 pl-53 pr-53 pt-87 pt-27">
            <div class="container">
                <div class="login-container">
                    <h2>Neues passwort</h2>
                    <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Non pulvinar neque laoreet suspendisse interdum consectetur libero id faucibus. Faucibus nisl tincidunt eget nullam non nisi est sit. Pellentesque habitant morbi tristique senectus. Tortor dignissim convallis aenean et tortor at risus viverra adipiscing. Vulputate eu scelerisque felis imperdiet. Turpis egestas maecenas pharetra convallis. Eget egestas purus viverra accumsan in nisl nisi. Amet mauris commodo quis imperdiet massa tincidunt nunc. Sit amet porttitor eget dolor morbi non arcu risus. Lorem ipsum dolor sit amet consectetur adipiscing.</p>
                    <form $Form.AttributesHTML>
                        <div class="form_card">
                            <div class="wrapper">
                                <% if $FormError %>
                                    <div class="alert alert-danger">
                                        $FormError
                                    </div>
                                <% end_if %>
                                
                                <div class="input_row mb-3">
                                    <div class="col-12">$NewPassword</div>
                                </div>

                                <div class="input_row">
                                    <div class="col-12">$ConfirmPassword</div>
                                </div>
                            </div>
                            <div class="form-footer">
                                $Form.Actions
                            </div>
                        </div>
                    </form>
                </div>
            </div>  
        </div>

        <% include Questions %>

    <% include Footer %>

<% include MainFooter %>
