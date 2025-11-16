<h2>Mitgliedschaft Abgelaufen</h2>

<p>Sehr geehrte(r) <% if $Member && $Member.FirstName %>$Member.FirstName<% else %>$Membership.FirstName<% end_if %>,</p>

<p>Ihre Mitgliedschaft bei $SiteConfig.Title ist abgelaufen. Ihr Kontostatus wurde auf <strong>ausstehend</strong> geändert.</p>

<p>Um Ihre Mitgliedschaft zu reaktivieren und den Zugriff auf alle Funktionen wiederherzustellen, schließen Sie bitte den Verlängerungsprozess ab.</p>

<p><a href="$AbsoluteBaseURL/dashboard/subscription/" style="background-color: #007cba; color: white; padding: 10px 20px; text-decoration: none; border-radius: 4px;">Jetzt Verlängern</a></p>

<p>Wenn Sie bereits verlängert haben, ignorieren Sie bitte diese E-Mail.</p>

<p>Mit freundlichen Grüßen,<br>
$SiteConfig.Title Team</p>