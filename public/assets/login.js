(function() {

  $(document).ready(function() {
    $("div#actual_login_page form#login_form input#email").focus();
    $("div#actual_registration_page form#registration_form input#email").focus();
    $("div#main_container div#main a#edit_email_link").fancybox({
      onComplete: function() {
        return $("div#edit_email_content form#edit_email_form input#email").focus();
      }
    });
    $("div#main_container div#main a#edit_name_link").fancybox({
      onComplete: function() {
        return $("div#edit_name_content form#edit_name_form input#name").focus();
      }
    });
    $("div#main_container div#main a#edit_region_link").fancybox({
      onComplete: function() {
        return $("div#edit_region_content form#edit_region_form input#region").focus();
      }
    });
    $("div#main_container div#main a#edit_password_link").fancybox({
      onComplete: function() {
        return $("div#edit_password_content form#edit_password_form input#password").focus();
      }
    });
    return $("div#main_container div#main a#delete_account_link").fancybox({
      onComplete: function() {
        return $("div#delete_account_content form#delete_account_form input#confirm_delete_account_button").focus();
      }
    });
  });

}).call(this);
