<div class="w-100 d-flex justify-content-center align-items-center SimpleBanner$ID"
     style="
         background-image: url($Image.URL);
         background-size: cover;
         background-repeat: no-repeat;
         height: $Height;
         font-family: $Font;
         ">
    <div class="SimpleBannerOverlay$ID h-100 w-100 d-flex justify-content-center align-items-center">
        <div class="d-flex flex-column">
            <p class="text-white fs-1 align-self-center mb-3 fw-bold">$Title</p>
            <% if $SubTitle %>
                <p class="text-gray-200 fs-5 align-self-center">$SubTitle</p>
            <% end_if %>
        </div>
    </div>
</div>
<style>
    .SimpleBannerOverlay$ID {
        color: #$TxtColor;
        background: color-mix(in lch, #$AccentColor 20%, rgba(0, 0, 0, 0) 80%);
        opacity: 10;
        transition: 1s ease;
    }

    .SimpleBanner$ID {
        transition: 1s ease;
    }

    .SimpleBanner$ID:hover .SimpleBannerOverlay$ID {
        color: #$TxtColor;
        opacity: 100;
        background: color-mix(in lch, #$AccentColor 50%, rgba(0, 0, 0, 0) 50%);
        display: flex;
    }
</style>
