	<% include MainHeader %>

	<% include Header %>
    <!--Deine gespeicherte suche End-->
		<div class="mydata white_bg" style="display:block;">
			<div class="container">
            <form id="Form_step1Form" action="/dashboard/payment-method/" method="POST" enctype="application/x-www-form-urlencoded">
            <div class="user_name user_info">Hallo<br> $Name</div>
				<div class="back_btn"><a href="/dashboard" class="back-link"><i class="fa-solid fa-arrow-left"></i> Zur Übersicht</a></div>
				<h1 class="title">$Title</h1>
				<div class="rental_professional">
					<div class="plans-wrapper">
						<div class="plan-box hide-on-mobile">
							<div class="plan-header"></div>
							<ul>
								<li>Direct contact met verhuurder</li>
								<li>Zoekopdrachten speigeren</li>
								<li>Berichten nieuwe woningen</li>
								<li>Lorem ipsum</li>
								<li>Lorem ipsum</li>
							</ul>
						</div>
<% loop $plans %>
						<div class="plan-box <% if $Duration == $Up.PaymentType %>active<% end_if %>">
                        <label>
							<div class="plan-header">
                            <input type="radio" name="PaymentType" value="$Duration" <% if $Duration == $Up.PaymentType %>checked<% end_if %> id="Form_step1Form_PaymentType_1Monate" required="required">
								<div class="icon_wrap">
									<div class="icon"><i class="fa-solid fa-building"></i></div>
									<div class="month">$Duration</div>
								</div>
								<div class="price">$Price Euro/ Monat
                                <% if $Discount > 0 %><br>$DiscountPrice Euro/ Monat<% end_if %>
                                </div>
							</div>
							<ul>
                            <% if $Duration == '1 Monate' || $Duration == '3 Monate' || $Duration == '6 Monate' %>
								<li><i class="fa-solid fa-check"></i> <span>Direct contact met verhuurder</span></li>
								<li><i class="fa-solid fa-check"></i> <span>Zoekopdrachten speigeren</span></li>
                                <% end_if %>
                                <% if $Duration == '3 Monate' || $Duration == '6 Monate' %>
								<li><i class="fa-solid fa-check"></i> <span>Berichten neue woningen</span></li>
                                <% end_if %>
                                <% if $Duration == '6 Monate' %>
								<li><i class="fa-solid fa-check"></i> <span>Lorem ipsum</span></li>
                                <li><i class="fa-solid fa-check"></i> <span>Lorem ipsum</span></li>
                                <% end_if %>
							</ul>
                            </label>
						</div>
<% end_loop %>
			

					<div class="plan-footer">
						<div class="terms">
							Mindestlaufzeit 6 Monate. Danach Verlängerung auf unbestimmte Zeit zum Monatspreis von 19,99 Euro und jederzeit mit maximal 1-Monatsfrist kündbar.<br>
							Die <a href="#">AGB</a> und <a href="#">Widerrufsbelehrung</a> wurden zur Kenntnis genommen und durch Klick auf „Jetzt Kaufen“ akzeptiert. Alle Preise inkl. MwSt.
						</div>
						<div class="action">
							<div class="default_outline_btn"><a href="#" class="btn-outline">Anhalten</a></div>
							<div class="default_btn">
                            <input type="submit" name="action_doPayment" value="Upgrade" class="action btn btn-primary btn-filled" id="Form_paymentForm_action_doPayment">
                            </div>
                             
						</div>
					</div>
				</div>
                </form>
			</div>
		</div>
        	<script>
			document.addEventListener('DOMContentLoaded', function(){
				const boxes = document.querySelectorAll('.plan-box');
				boxes.forEach(box => {
					const radio = box.querySelector('input[type="radio"]');
					radio.addEventListener('change', () => {
					boxes.forEach(b => {
						b.classList.remove('selected');
					});
					if (radio.checked) {
						box.classList.add('selected');
					}
					});
				});
			});
		</script>
        <% include Footer %>

<% include MainFooter %>