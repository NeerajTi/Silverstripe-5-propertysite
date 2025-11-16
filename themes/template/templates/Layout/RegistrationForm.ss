<% include MainHeader %>

    <% include Header %>
<style>
.steps{display:none}
#Form_RegistrationForm_action_doRegister,.step1button{display:none}
.steps.active{display:block}
</style>
        <% if $Session.FormError %>
            <p class="message bad">$Session.FormError</p>
        <% end_if %>

        <div class="login_section white_card">
            <div class="container">
                <div class="login-container">
                    <h2>Vorteile, von einen account</h2>
                    <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Non pulvinar neque laoreet suspendisse interdum consectetur libero id faucibus. Faucibus nisl tincidunt eget nullam non nisi est sit. Pellentesque habitant morbi tristique senectus. Tortor dignissim convallis aenean et tortor at risus viverra adipiscing. Vulputate eu scelerisque felis imperdiet. Turpis egestas maecenas pharetra convallis. Eget egestas purus viverra accumsan in nisl nisi. Amet mauris commodo quis imperdiet massa tincidunt nunc. Sit amet porttitor eget dolor morbi non arcu risus. Lorem ipsum dolor sit amet consectetur adipiscing.</p>
                    
                    <form $Form.AttributesHTML>
                        <div class="form_card">
                            <div class="wrapper">
                                <div class="tab-buttons">
                                    <a href="/login/" class="tab-btn" data-tab="login">Einloggen</a>
                                    <a href="javascript:void(0);" class="tab-btn active" data-tab="register">Account erstellen</a>
                                </div>
                                
                                <% if $FormError %>
                                    <div class="alert alert-danger">
                                        $FormError
                                    </div>
                                <% end_if %>
<div class="steps step1 active"> 
<div class="row">
<div class="col-12">
$UserType
</div>
</div>
</div>
<div class="steps step2"> 
                                <div class="input_row">
                                    <div class="col-md-6 col-12 ">$Email</div>
                                    <div class="col-md-6 col-12 ">$Password</div>
                                </div>

                                <div class="input_row" style="margin-top:15px">
                                    <div class="col-md-6 col-12 hide-on-mobile">&nbsp;</div>
                                    <div class="col-md-6 col-12 ">$RePassword</div>
                                </div>
                                </div>
                            </div>
                            <div class="form-footer">
                            <input type="button" style='font-size: clamp(16px, 1.5vw + 1px, 22px);
    font-weight: 600;
    color: #fff;
    border-radius: 10px;
    padding: 10px 40px;
    border: none;
    background-color: #D98209;
    font-family: "Open Sans", sans-serif;' value="Back" class="action btn btn-primary step1button">
                                $Form.Actions
                                <input type="button" style='font-size: clamp(16px, 1.5vw + 1px, 22px);
    font-weight: 600;
    color: #fff;
    border-radius: 10px;
    padding: 10px 40px;
    border: none;
    background-color: #D98209;
    font-family: "Open Sans", sans-serif;' value="Weiter" class="action btn btn-primary step2button">
                            </div>
                          
                        </div>
                    </form>
                </div>
            </div>  
        </div>
<script>
document.querySelector(".step1button").addEventListener("click", function() {
    document.querySelector(".step1").classList.add("active");
    document.querySelector(".step2").classList.remove("active");
    document.querySelector(".step1button").style.display="none";
    document.querySelector(".step2button").style.display="block";
    document.getElementById("Form_RegistrationForm_action_doRegister").style.display="none";
});
document.querySelector(".step2button").addEventListener("click", function() {
  
    document.querySelector(".step2").classList.add("active");
    document.querySelector(".step1").classList.remove("active");
    document.querySelector(".step2button").style.display="none";
    document.querySelector(".step1button").style.display="block";
    document.getElementById("Form_RegistrationForm_action_doRegister").style.display="block";
});
</script>
    <% include Footer %>

<% include MainFooter %>