	<% include MainHeader %>

	<% include Header %>
    <!--Deine gespeicherte suche End-->
<div class="white_card" style="display:block;">
			<h2>Zahlungsarten</h2>
			<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Non pulvinar neque laoreet suspendisse interdum consectetur libero id faucibus. Faucibus nisl tincidunt eget nullam non nisi est sit. Pellentesque habitant morbi tristique senectus. Tortor dignissim convallis aenean et tortor at risus viverra adipiscing. Vulputate eu scelerisque felis imperdiet.</p>
			<div class="payment_option">
				<div class="payment_card">
					<i class="fa-brands fa-paypal"></i>
					<div class="card_name" id='paypal-button-container'></div>
				</div>
			
				<div class="default_btn"><a href="/apartment/listingcreated?apartmentID=$Apartment.ID" class="yellow_btn">Zahlen</a></div>
			</div>
		</div>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
      <!-- PayPal JS SDK -->
<script src="https://www.paypal.com/sdk/js?client-id=Aemuv7lmwFo-QIZTj2rFbjhk60cgh_JtCHQieITJ5rffcmstpkdj1tPWQP6xg_ETQGm9rqsy_XVzRRgz&currency=EUR&disable-funding=card"></script> 
        <script>
paypal.Buttons({
    createOrder: function(data, actions) {
        return actions.order.create({
            purchase_units: [{
                description: `Renter-{$MemberBasicData.MemberID}-{$MemberBasicData.Email}-{$PaymentType}`,
                amount: {
                    value: `${($planDetails.DiscountPrice*$planDetails.Qty).toFixed(2)}` // Price of your plan
                }
            }]
        });
    },
    onApprove: function(data, actions) {
        return actions.order.capture().then(function(details) {
            // Payment successful
          
             fetch('/payment/payment-approve', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                    'X-CSRF-TOKEN': window.SecurityID || ''
                },
                body: JSON.stringify({
                    transaction_id: details.id,
                    payer_id: details.payer.payer_id,
                    amount: details.purchase_units[0].amount.value,
                    currency: details.purchase_units[0].amount.currency_code,
                    status: details.status,
                    plan_id: `{$PaymentType}`, // <-- your custom plan ID
                    qty: `{$planDetails.Qty}`,
                    raw_response: details,
                    payment_method: 'PayPal'
                })
            }).then(res => res.json())
              .then(data => {
                
                  Swal.fire({
                    icon: 'success',
                    title: 'Payment completed!',
                    showConfirmButton: false,
                    timer: 1500
                }).then((result) => {
                    if (result.isDismissed) {
                        window.location.href = '/renter-dashboard/payment-thankyou';
                    }
                });
              });
        });
    },
    onCancel: function (data) {
       
        Swal.fire({
            icon: 'Cancelled',
            title: 'Payment cancelled!',
            showConfirmButton: false,
            timer: 1500
        }).then((result) => {
            if (result.isDismissed) {
                window.location.href = '/renter-dashboard/payment-thankyou';
            }
        });
    },
    onError: function (err) {
        console.error('Payment error:', err);
        Swal.fire({
            icon: 'error',
            title: 'Payment error, please try again !',
            showConfirmButton: false,
            timer: 1500
        });
    }
}).render('#paypal-button-container');
</script>
        <% include Footer %>

<% include MainFooter %>