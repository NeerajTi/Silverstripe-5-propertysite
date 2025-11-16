<% if $AllQuestions %>
<section class="faq">
	<div class="container">
		<h2>Frage und antworte</h2>
		<div class="accordion" id="accordionExample" itemscope itemtype="https://schema.org/FAQPage">
			<% loop $AllQuestions %>
				<% if $Subsite == $Top.Subsite.ID %>
					<div class="accordion-item" itemprop="mainEntity" itemscope itemtype="https://schema.org/Question">
						<h3 class="accordion-header" id="heading$ID">
							<button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#question$ID" aria-expanded="true" aria-controls="question$ID" itemprop="name">
								<span itemprop="text">$Title</span>
							</button>
						</h3>
						<div id="question$ID" class="accordion-collapse collapse <% if $Pos = "1" %>show<% end_if %>" aria-labelledby="heading$ID" data-bs-parent="#accordion$ID" itemprop="acceptedAnswer" itemscope itemtype="https://schema.org/Answer">
							<div class="accordion-body" itemprop="text">
								$Antwoord
							</div>
						</div>
					</div>
				<% end_if %>
			<% end_loop %>
		</div>
	</div>	
</section>	
<% end_if %>
