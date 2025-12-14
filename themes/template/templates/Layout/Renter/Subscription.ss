	<% include MainHeader %>

	<% include Header %>
    <!--Deine gespeicherte suche End-->
		<div class="mydata white_bg" style="display:block;">
			<div class="container">
            <form id="Form_step1Form" action="/renter-dashboard/payment-method/" method="POST" enctype="application/x-www-form-urlencoded">
            <div class="user_name user_info">Hallo<br> $Name</div>
				<div class="back_btn"><a href="/renter-dashboard" class="back-link"><i class="fa-solid fa-arrow-left"></i> Zur Übersicht</a></div>
				<h1 class="title">$Title</h1>
				<div class="rental_professional">
					<div class="plans-wrapper">
					
<% loop $plans %>
						<div class="plan-box <% if $Duration == $Up.MemberBasicData.PlanId %>active<% end_if %>">
                        <label>
							<div class="plan-header">
                            <input type="radio" name="PaymentType" value="$Duration" <% if $Duration == $Up.MemberBasicData.PlanId %>checked<% end_if %> id="Form_step1Form_PaymentType_1Monate" required="required">
								<div class="icon_wrap">
									
									<div class="month">Dein Mietprofi Abo</div>
									<div class="icon"><i class="fa-solid fa-building"></i></div>
								</div>
								<div class="price">nur $Price € pro Monat</div>
                                <% if $Discount > 0 %>
                                <div class="discount">$DiscountPrice Euro/ Monat</div>
                                <% end_if %>
							</div>
							<ul>
                         <li>Kontakt aufnehmen mit dem Anbieter</li>
						 <li>Monatlich kündbar (bis zum 15.)</li>
							</ul>
                            </label>
								<div class="default_btn">
							<% if $SubscriptionStatus == 'Active' %>
                            <% else %>
                            <input type="submit" name="action_doPaymentDiscount" value="Upgrade" class="action btn btn-primary btn-filled" id="Form_paymentForm_action_doPayment">
                            <% end_if %>
                            </div>
						</div>
<% end_loop %>
	<div class="plan-box hide-on-mobile">
							<div class="plan-header month" style="color:black">Lade hier deine Abrechnung herunter</div>
							<div class="default_btn">
							<a href="#;" class="action btn btn-primary btn-filled">Übersicht</a>
							</div>
						</div>
				
</div>
					<div class="plan-footer">
						<div class="terms">
							Die <a href="#">AGB</a> und <a href="#">Widerrufsbelehrung</a> wurden zur Kenntnis genommen und durch Klick auf „Jetzt Kaufen“ akzeptiert. Alle Preise inkl. MwSt.
							<div class="action">
						<% if $MemberBasicData.AutoSubscription == 1 %>
						
						<% else %>
							<div class="default_outline_btn"><a href="javascript:void(0)" class="btn-outline stop-subscription" data-action-url="/renter-dashboard/stop-subscription">Abo kündigen</a>
							</div>
						<% end_if %>
							
                             
						</div>
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
				
					if (radio.value !== currentPlanId) {
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