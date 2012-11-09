(function() {

  $(document).ready(function() {
    var actually_upload;
    $("form#dictionary_form input#word").focus();
    $("form#dictionary_form").submit(function() {
      window.location.href = "/dictionary/" + $("form#dictionary_form input#word").val();
      return false;
    });
    $("form#new_word_form").submit(function() {
      $("a#new_word_fancybox_link").click();
      return false;
    });
    $("a#upload_fancybox_link").fancybox();
    $("a#new_word_fancybox_link").fancybox({
      onComplete: function() {
        return $("form#new_word_fancybox_form input#name").focus();
      }
    });
    actually_upload = false;
    window.upload_form_for_word = function(word_index, num_videos) {
      $("form#upload_form").submit(function() {
        var file_name, file_name_s3, metadata, tag, _i, _len, _ref;
        if (actually_upload) {
          $("form#upload_form input#upload_form_submit").attr("disabled", "disabled");
          $("form#upload_form input#upload_form_submit").val("Uploading...");
          return true;
        } else {
          file_name_s3 = file_prefix + $("form#upload_form input.file").val().split('\\').pop();
          file_name = "https://s3.amazonaws.com/asler/" + file_name_s3;
          $("form#upload_form input.filename").val(file_name_s3);
          metadata = [];
          _ref = $("form#upload_form input:visible");
          for (_i = 0, _len = _ref.length; _i < _len; _i++) {
            tag = _ref[_i];
            if ($(tag).prop("checked")) {
              metadata = metadata.concat([$(tag).attr("id")]);
            }
          }
          $.ajax({
            url: "/upload",
            data: {
              word_id: String(word_index),
              url: file_name,
              metadata: JSON.stringify(metadata)
            },
            success: function() {
              actually_upload = true;
              return $("form#upload_form").submit();
            }
          });
          return false;
        }
      });
      return $("a#upload_fancybox_link").click();
    };
    $("a#delete_video_link").fancybox();
    $("div.video_container img.video_close").click(function() {
      var video_id;
      video_id = $(this).parent().find("div.video_id").html();
      $("form#delete_video_form input#video_id").val(video_id);
      return $("a#delete_video_link").click();
    });
    $("a#delete_word_link").fancybox();
    $("div.word_container img.word_close").click(function() {
      var word_id;
      word_id = $(this).parent().find("div.word_id").html();
      $("form#delete_word_form input#word_id").val(word_id);
      return $("a#delete_word_link").click();
    });
    return $('#slides').slides();
  });

}).call(this);
