$(document).ready(() ->
  # click handler for login button
  $("div#header_container div#header div#login_container a#sign_in_button").fancybox( { onComplete: () ->
    $("div#login_content form#login_form input#email").focus()
  } )

  # click handler for registration button
  $("div#header_container div#header div#login_container a#register_button").fancybox( { onComplete: () ->
    $("div#register_content form#registration_form input#email").focus()
  } )

  # click handler for the close button for flash messages
  $("div#main_container div#main img.flash_close").click(() ->
    $(this).parent().slideUp()
    $(this).click(() -> return 0)
  )
)