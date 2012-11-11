(function() {

  $(document).ready(function() {
    $("a#new_discussion_link").fancybox({
      onComplete: function() {
        return $("form#new_discussion_form input#title").focus();
      }
    });
    $("input#new_question_button").click(function() {
      $("a#new_discussion_link").click();
      return false;
    });
    return $("a#confirm_link").fancybox({
      onComplete: function() {
        return $("form#confirm_form input#confirm_delete_discussion_button").focus();
      }
    });
  });

}).call(this);
