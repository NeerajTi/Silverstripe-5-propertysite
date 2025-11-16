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
						<div class="plan-box <% if $Duration == $Up.MemberBasicData.PlanId %>active<% end_if %>">
                        <label>
							<div class="plan-header">
                            <input type="radio" name="PaymentType" value="$Duration" <% if $Duration == $Up.MemberBasicData.PlanId %>checked<% end_if %> id="Form_step1Form_PaymentType_1Monate" required="required">
								<div class="icon_wrap">
									<div class="icon"><i class="fa-solid fa-building"></i></div>
									<div class="month">$Duration</div>
								</div>
								<div class="price">$Price Euro/ Monat</div>
                                <% if $Discount > 0 %>
                                <div class="discount">$DiscountPrice Euro/ Monat</div>
                                <% end_if %>
							</div>
							<ul>
                            <% if $Duration == 'Top Platzierung' %>
								<li><i class="fa-solid fa-check"></i> <span>Direct contact met verhuurder</span></li>
								<li><i class="fa-solid fa-check"></i> <span>Zoekopdrachten speigeren</span></li>
                                <% end_if %>
								<li style='color:#D98209;font-weight: 700;'><span style='color:#D98209;font-weight: 700;'>In den ersten 48 std.</span></li>
                                <% if $Duration == 'Top Platzierung' %>
								<li><i class="fa-solid fa-check"></i> <span>Berichten neue woningen</span></li>
                                <% end_if %>
                                <% if $Duration == 'Top Platzierung' %>
								<li><i class="fa-solid fa-check"></i> <span>Lorem ipsum</span></li>
                                <li><i class="fa-solid fa-check"></i> <span>Lorem ipsum</span></li>
                                <% end_if %>
							</ul>
                            </label>
						</div>
<% end_loop %>
						<!--<div class="plan-box <% if $MemberBasicData.PaymentType == '3 Monate' %>active<% end_if %>">
							<label>
							<div class="plan-header">
                            <input type="radio" name="PaymentType" value="3 Monate" <% if $MemberBasicData.PaymentType == '3 Monate' %>checked<% end_if %> id="Form_step1Form_PaymentType_3Monate" required="required">
								<div class="subscription">Ihre Abbonoment</div>
								<div class="icon_wrap">
									<div class="icon"><i class="fa-solid fa-house"></i></div>
									<div class="month">3 Monate</div>
								</div>
								<div class="price">12.95 Euro/ Monat</div>
							</div>
							<ul>
								<li><i class="fa-solid fa-check"></i> <span>Direct contact met verhuurder</span></li>
								<li><i class="fa-solid fa-check"></i> <span>Zoekopdrachten speigeren</span></li>
								<li><i class="fa-solid fa-check"></i> <span>Berichten nieuwe woningen</span></li>
								<li></li>
								<li></li>
							</ul>
                            </label>
						</div>

						<div class="plan-box <% if $MemberBasicData.PaymentType == '6 Monate' %>active<% end_if %>">
                            <label>
							<div class="plan-header">
                            <input type="radio" name="PaymentType" value="6 Monate" <% if $MemberBasicData.PaymentType == '6 Monate' %>checked<% end_if %> id="Form_step1Form_PaymentType_6Monate" required="required">
								<div class="icon_wrap">
									<div class="icon"><i class="fa-solid fa-building-columns"></i></div>
									<div class="month">6 Monate</div>
								</div>
								<div class="price">9,95 Euro/ Monat</div>
							</div>
							<ul>
								<li><i class="fa-solid fa-check"></i> <span>Direct contact met verhuurder</span></li>
								<li><i class="fa-solid fa-check"></i> <span>Zoekopdrachten speigeren</span></li>
								<li><i class="fa-solid fa-check"></i> <span>Berichten nieuwe woningen</span></li>
								<li><i class="fa-solid fa-check"></i> <span>Lorem ipsum</span></li>
								<li><i class="fa-solid fa-check"></i> <span>Lorem ipsum</span></li>
							</ul>
                            </label>
						</div>-->

				</div>
				<div class="plan-footer">
						<div class="terms">
							Mindestlaufzeit 6 Monate. Danach Verlängerung auf unbestimmte Zeit zum Monatspreis von 19,99 Euro und jederzeit mit maximal 1-Monatsfrist kündbar.<br>
							Die <a href="#">AGB</a> und <a href="#">Widerrufsbelehrung</a> wurden zur Kenntnis genommen und durch Klick auf „Jetzt Kaufen“ akzeptiert. Alle Preise inkl. MwSt.
						</div>
						<div class="action">
							<div class="default_outline_btn"><a href="/dashboard/anhalten" class="btn-outline">Anhalten</a></div>
							<div class="default_btn">
                           <% if $SubscriptionStatus == 'Active' && $MemberBasicData.PlanId == 'Top Platzierung' %>
                            <% else %>
                            <input type="submit" disabled name="action_doPaymentDiscount" value="Upgrade" class="action btn btn-primary btn-filled" id="Form_paymentForm_action_doPayment">
                            <% end_if %>
                            </div>
                             
						</div>
					</div>
                </form>
			</div>
		</div>
                	<script>
			var currentPlanId = `{$MemberBasicData.PlanId}`;
			
document.addEventListener('DOMContentLoaded', function () {
    const boxes = document.querySelectorAll('.plan-box');
    const submitButton = document.getElementById('Form_paymentForm_action_doPayment');

    boxes.forEach(box => {
        const radio = box.querySelector('input[type="radio"]');

        if (radio) {
            radio.addEventListener('change', () => {
                // Remove 'active' class from all boxes
                boxes.forEach(b => b.classList.remove('active'));

                // Add 'active' class to this box
                if (radio.checked) {
					
                    box.classList.add('active');
				
					if (radio.value !== currentPlanId && currentPlanId!='Top Platzierung') {
                        submitButton.removeAttribute('disabled');
                    } else {
                        submitButton.setAttribute('disabled', 'disabled');
                    }
					
                }
            });
        }
    });
});
</script>
        <% include Footer %>

<% include MainFooter %>