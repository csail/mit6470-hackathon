$(document).ready(() ->
  # focus the first field of the login/registration forms
  $("div#actual_login_page form#login_form input#email").focus()
  $("div#actual_registration_page form#registration_form input#email").focus()

  # email editing stuff
  $("div#main_container div#main a#edit_email_link").fancybox( { onComplete: () ->
    $("div#edit_email_content form#edit_email_form input#email").focus()
  } )

  # name editing stuff
  $("div#main_container div#main a#edit_name_link").fancybox( { onComplete: () ->
    $("div#edit_name_content form#edit_name_form input#name").focus()
  } )

  # password editing stuff
  $("div#main_container div#main a#edit_password_link").fancybox( { onComplete: () ->
    $("div#edit_password_content form#edit_password_form input#password").focus()
  } )

  # account deletion stuff
  $("div#main_container div#main a#delete_account_link").fancybox( { onComplete: () ->
    $("div#delete_account_content form#delete_account_form input#confirm_delete_account_button").focus()
  } )
)