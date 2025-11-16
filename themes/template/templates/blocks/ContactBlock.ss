<div class="Contact-block">
    <div id="contact"></div>
    <div id="Contact"></div>
    <div class="container col-xxl-8 px-4 pt-5 mb-5">
        <div class="contact_sub h4">$TitleColored</div>
        <div class="text-black font-bold h1">$Title</div>
        <div>
            <p class="lead">
                $Content
            </p>
        </div>
        <div class="row">
            <div class="col-12 col-lg-4 mt-1">
                <% loop $ContactOptions %>
                    <div class="row flex flex-row mb-4 ml-1 items-center ">
                        <div class="icon-wrapper p-3 rounded-icon tooltip-activate flex items-center justify-content-center" style="background-color: #$Kleur;">
                            <i class="fa $icon fa-2x" style="color:#ffffff ;"></i>
                            <div class="tooltip">
                                <span class="tooltiptext">$Title</span>
                            </div>
                        </div>
                        <div class="flex items-center h-full">
                            <% if $Link %>
                                <a class="contact-link flex items-center h-full" href="$Link">
                                    <p class="text-center h-full mb-0 ml-3 text-lg">
                                        $Content
                                    </p>
                                </a>
                            <% else %>
                                <p class="text-center h-full mb-0 ml-3 text-lg">
                                    $Content
                                </p>
                            <% end_if %>
                        </div>
                    </div>
                <% end_loop %>
            </div>
            <div class="col-12 col-lg-8">$CurrContactForm</div>
        </div>
    </div>
</div>
