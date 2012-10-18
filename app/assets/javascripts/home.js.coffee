# click handler for dictionary button
$(document).ready(() ->
  $("div#main div#dictionary").click(() ->
    window.location.href = '/dictionary'
  )
)

# click handler for reverse dictionary button
$(document).ready(() ->
  $("div#main div#reverse").click(() ->
    window.location.href = '/reverse_dictionary'
  )
)

# click handler for practice button
$(document).ready(() ->
  $("div#main div#practice").click(() ->
    window.location.href = '/practice'
  )
)

# click handler for community button
$(document).ready(() ->
  $("div#main div#community").click(() ->
    window.location.href = '/community'
  )
)
