$(document).ready(() ->
  # click handler for new question link
  $("a#new_discussion_link").fancybox( { onComplete: () ->
    $("form#new_discussion_form input#title").focus()
  } )

  # click handler for new question button
  $("input#new_question_button").click( () ->
    $("a#new_discussion_link").click()
    return false
  )
  # click handler for close discussion fancybox link
  $("a#confirm_link").fancybox( { onComplete: () ->
    $("form#confirm_form input#confirm_delete_discussion_button").focus()
  } )
)