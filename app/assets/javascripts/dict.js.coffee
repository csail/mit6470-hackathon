$(document).ready(() ->
 # autofocus the input field
  $("form#dictionary_form input#word").focus()

  # search form submit hook
  $("form#dictionary_form").submit(() ->
    window.location.href = "/dictionary/"+$("form#dictionary_form input#word").val()
    return false
  )

  # new word form submit hook
  $("form#new_word_form").submit(() ->
    $("a#new_word_fancybox_link").click()
    return false
  )

  # upload fancybox link
  $("a#upload_fancybox_link").fancybox()

  # new word fancybox link
  $("a#new_word_fancybox_link").fancybox( { onComplete: () ->
    $("form#new_word_fancybox_form input#name").focus()
  })

  # upload stuff
  actually_upload = false
  window.upload_form_for_word = (word_index, num_videos) ->
    $("form#upload_form").submit(() ->
      if actually_upload
        $("form#upload_form input#upload_form_submit").attr("disabled", "disabled");
        $("form#upload_form input#upload_form_submit").val("Uploading...");
        return true
      else
        file_name_s3 = file_prefix+$("form#upload_form input.file").val().split('\\').pop()
        file_name = "https://s3.amazonaws.com/asler/"+file_name_s3
        $("form#upload_form input.filename").val(file_name_s3)
        metadata = []
        for tag in $("form#upload_form input:visible")
          if $(tag).prop("checked")
            metadata = metadata.concat [$(tag).attr("id")]
        $.ajax({
          url: "/upload",
          data: { word_id: String(word_index), url: file_name, metadata: JSON.stringify(metadata) },
          success: () ->
            actually_upload = true
            $("form#upload_form").submit()
        });
        return false
    )
    $("a#upload_fancybox_link").click()

  # delete video
  $("a#delete_video_link").fancybox()
  $("div.video_container img.video_close").click(() ->
    video_id = $(this).parent().find("div.video_id").html()
    $("form#delete_video_form input#video_id").val(video_id)
    $("a#delete_video_link").click()
  )

  # delete word
  $("a#delete_word_link").fancybox()
  $("div.word_container img.word_close").click(() ->
    word_id = $(this).parent().find("div.word_id").html()
    $("form#delete_word_form input#word_id").val(word_id)
    $("a#delete_word_link").click()
  )

  # make slides out of upload questions
  $('#slides').slides();
)
