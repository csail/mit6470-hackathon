# initial values
current_question = 0
current_offset = 0.0
question_margin = 400.0

# when the user is done with the form
done = () ->
  # create a list of video tags
  video_tags = []

  # iterate through the questions
  for i in [0..questions.length-1]
    # get the answers
    answers = $("div#question_"+String(i)+" div.question_answer")

    # iterate through the answers
    for j in [0..answers.length-1]
      # check if this answer was selected
      if $(answers[j]).hasClass("selected")
        # get the tag id
        tag_id = $(answers[j]).attr("id")
        tag_id = tag_id[4...tag_id.length]

        # add the tag id to the list
        video_tags.push tag_id
  
  # redirect to the results page
  if video_tags.length == 0
    window.location = "/reverse_dictionary/empty"
  else
    window.location = "/reverse_dictionary/"+encodeURIComponent(video_tags)

# reposition everything
update_state = () ->
  # update the offset
  current_offset = current_offset*0.8+(60-current_question*question_margin)*0.2

  # reposition the questions
  for i in [0..questions.length-1]
    # position the question
    $("div#question_"+String(i)).css("top", current_offset+i*question_margin)

    # get the answers
    answers = $("div#question_"+String(i)+" div.question_answer")

    # get the width of the answers
    width = answers.length*(122+10)-10

    # position the answers
    for j in [0..answers.length-1]
      $(answers[j]).css("left", (960-width)/2+j*(122+10))
  
  # set the timer
  setTimeout(update_state, 50)

# when the document loads, position everything
$(document).ready(() ->
  $('div#next_button').illuminate({
    'intensity': '0.5',
    'blink': 'false',
    'outerGlow': 'true',
    'outerGlowSize': '10px',
    'outerGlowColor': '#e38f1b'
  })

  # click handler for the answer buttons
  $("div.question_answer").click(() ->
    # toggle the selected state
    $(this).toggleClass("selected")

    # get the question id
    question_id = $(this).parent().parent().attr("id")
    question_id = question_id[9...question_id.length]

    # check the multiplicity
    if questions[Number(question_id)]["multiplicity"] == "!"
      # save the selected state
      is_selected = $(this).hasClass("selected")

      # uncheck the other answers
      $(this).parent().find("div.question_answer").removeClass("selected")

      # restore the selected state
      if is_selected
        $(this).addClass("selected")
      else
        $(this).removeClass("selected")
  )

  # click handler for the next/prev buttons
  $("div#prev_button").click(() ->
    if current_question > 0
      current_question -= 1
    if current_question == 0
      $("div#prev_button").addClass("disabled")
    $("div#next_button").html("Next")
  )
  $("div#next_button").click(() ->
    if current_question < questions.length
      current_question += 1
      $("div#prev_button").removeClass("disabled")
    if current_question == questions.length
      $("div#prev_button").addClass("disabled")
      $("div#next_button").addClass("disabled")
      done()
    if current_question == questions.length-1 || current_question == questions.length
      $("div#next_button").html("Search")
    else
      $("div#next_button").html("Next")
  )

  # position everything
  update_state()
)
