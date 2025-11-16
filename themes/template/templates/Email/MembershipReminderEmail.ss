<h2>Mitgliedschaft Verlängerungserinnerung</h2>

<p>Sehr geehrte(r) <% if $Member && $Member.FirstName %>$Member.FirstName<% else %>$Membership.FirstName<% end_if %>,</p>

<p>dies ist eine freundliche Erinnerung, dass Ihre Mitgliedschaft bei $SiteConfig.Title am <strong>$RenewalDate.Format(d.M.Y)</strong> abläuft.</p>

<p>Um weiterhin von Ihren Mitgliedschaftsvorteilen zu profitieren, verlängern Sie bitte Ihre Mitgliedschaft vor dem Ablaufdatum.</p>

<p><a href="$AbsoluteBaseURL/dashboard/subscription/" style="background-color: #007cba; color: white; padding: 10px 20px; text-decoration: none; border-radius: 4px;">Jetzt Verlängern</a></p>

<p>Bei Fragen kontaktieren Sie bitte unser Support-Team.</p>

<p>Mit freundlichen Grüßen,<br>
$SiteConfig.Title Team</p>