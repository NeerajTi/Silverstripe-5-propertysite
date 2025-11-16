<% include MainHeader %>

<% include Header %>

<% include DashboardHeader %>
<h1>$Title</h1>

		<!--Deine gespeicherte suche End-->
		<div class="mydata white_bg">
        <form id="Form_step1Form" action="/apartment/doPayment/?apartmentID=$Apartment.ID" method="POST" enctype="application/x-www-form-urlencoded">
				<div class="rental_professional">
					<div class="plans-wrapper">
						<div class="plan-box hide-on-mobile">
							<div class="plan-header"></div>
							<ul>
								<li>Inserat wird jede Woche noch oben geschoben</li>
								<li>Nur kontaktanfragen von Mitgliedern</li>
								<li>Sie stehn immer Oben die privat anbieter</li>
								<li>???</li>
								<li>???</li>
                        
							</ul>
						</div>
<% loop $Plans %>
						<div class="plan-box <% if $Up.MemberBasicData.PlanId == $Duration %>active<% end_if %>">
							<label>
								<div class="bar-header" aria-hidden="true">Beliebt</div>
								<input type="radio" name="PaymentType" value="$Duration" <% if $Up.MemberBasicData.PlanId == $Duration %>checked<% end_if %> id="Form_step1Form_PaymentType_$Duration" required="required">
							<div class="plan-header">
								<div class="icon_wrap">
									<div class="icon"><i class="fa-solid fa-building"></i></div>
									<div class="month">$Duration</div>
								</div>
								<div class="price">$Price Euro</div>
							</div>
							<ul class="plan_info_list">
								<li>In den ersten 48 std.</li>
								<% if $Duration == 'Top Platzierung' %>
								<li><i class="fa-solid fa-check"></i></li>
								<li><i class="fa-solid fa-check"></i></li>
                                <li><i class="fa-solid fa-check"></i></li>
                                <li><i class="fa-solid fa-check"></i></li>
								<% end_if %>
							</ul>
                
                
            </label>
						</div>
<% end_loop %>
						

					</div>
					<div class="plan-footer">
						<div class="terms">
							Mindestlaufzeit 6 Monate. Danach Verlängerung auf unbestimmte Zeit zum Monatspreis von 19,99 Euro und jederzeit mit maximal 1-Monatsfrist kündbar.<br>
							Die <a href="#">AGB</a> und <a href="#">Widerrufsbelehrung</a> wurden zur Kenntnis genommen und durch Klick auf „Jetzt Kaufen“ akzeptiert. Alle Preise inkl. MwSt.
						</div>
						<div class="action">
						
							<div class="default_btn">
                            <input type="submit" name="action_doPayment" value="Weiter" class="action btn btn-primary" id="Form_paymentForm_action_doPayment">
                            </div>
						</div>
					</div>
				</div>
            </form>
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

        <% include DashboardFooter %>

<% include Footer %>

<% include MainFooter %>