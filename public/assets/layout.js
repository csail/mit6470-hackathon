(function() {

  $(document).ready(function() {
    $("div#header_container div#header div#login_container a#sign_in_button").fancybox({
      onComplete: function() {
        return $("div#login_content form#login_form input#email").focus();
      }
    });
    $("div#header_container div#header div#login_container a#register_button").fancybox({
      onComplete: function() {
        return $("div#register_content form#registration_form input#email").focus();
      }
    });
    return $("div#main_container div#main img.flash_close").click(function() {
      $(this).parent().slideUp();
      return $(this).click(function() {
        return 0;
      });
    });
  });

}).call(this);
