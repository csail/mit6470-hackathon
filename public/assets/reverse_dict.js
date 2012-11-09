(function() {
  var current_offset, current_question, done, question_margin, update_state;

  current_question = 0;

  current_offset = 0.0;

  question_margin = 400.0;

  done = function() {
    var answers, i, j, tag_id, video_tags, _i, _j, _ref, _ref1;
    video_tags = [];
    for (i = _i = 0, _ref = questions.length - 1; 0 <= _ref ? _i <= _ref : _i >= _ref; i = 0 <= _ref ? ++_i : --_i) {
      answers = $("div#question_" + String(i) + " div.question_answer");
      for (j = _j = 0, _ref1 = answers.length - 1; 0 <= _ref1 ? _j <= _ref1 : _j >= _ref1; j = 0 <= _ref1 ? ++_j : --_j) {
        if ($(answers[j]).hasClass("selected")) {
          tag_id = $(answers[j]).attr("id");
          tag_id = tag_id.slice(4, tag_id.length);
          video_tags.push(tag_id);
        }
      }
    }
    if (video_tags.length === 0) {
      return window.location = "/reverse_dictionary/empty";
    } else {
      return window.location = "/reverse_dictionary/" + encodeURIComponent(video_tags);
    }
  };

  update_state = function() {
    var answers, i, j, width, _i, _j, _ref, _ref1;
    current_offset = current_offset * 0.8 + (60 - current_question * question_margin) * 0.2;
    for (i = _i = 0, _ref = questions.length - 1; 0 <= _ref ? _i <= _ref : _i >= _ref; i = 0 <= _ref ? ++_i : --_i) {
      $("div#question_" + String(i)).css("top", current_offset + i * question_margin);
      answers = $("div#question_" + String(i) + " div.question_answer");
      width = answers.length * (122 + 10) - 10;
      for (j = _j = 0, _ref1 = answers.length - 1; 0 <= _ref1 ? _j <= _ref1 : _j >= _ref1; j = 0 <= _ref1 ? ++_j : --_j) {
        $(answers[j]).css("left", (960 - width) / 2 + j * (122 + 10));
      }
    }
    return setTimeout(update_state, 50);
  };

  $(document).ready(function() {
    $('div#next_button').illuminate({
      'intensity': '0.5',
      'blink': 'false',
      'outerGlow': 'true',
      'outerGlowSize': '10px',
      'outerGlowColor': '#e38f1b'
    });
    $("div.question_answer").click(function() {
      var is_selected, question_id;
      $(this).toggleClass("selected");
      question_id = $(this).parent().parent().attr("id");
      question_id = question_id.slice(9, question_id.length);
      if (questions[Number(question_id)]["multiplicity"] === "!") {
        is_selected = $(this).hasClass("selected");
        $(this).parent().find("div.question_answer").removeClass("selected");
        if (is_selected) {
          return $(this).addClass("selected");
        } else {
          return $(this).removeClass("selected");
        }
      }
    });
    $("div#prev_button").click(function() {
      if (current_question > 0) {
        current_question -= 1;
      }
      if (current_question === 0) {
        $("div#prev_button").addClass("disabled");
      }
      return $("div#next_button").html("Next");
    });
    $("div#next_button").click(function() {
      if (current_question < questions.length) {
        current_question += 1;
        $("div#prev_button").removeClass("disabled");
      }
      if (current_question === questions.length) {
        $("div#prev_button").addClass("disabled");
        $("div#next_button").addClass("disabled");
        done();
      }
      if (current_question === questions.length - 1 || current_question === questions.length) {
        return $("div#next_button").html("Search");
      } else {
        return $("div#next_button").html("Next");
      }
    });
    return update_state();
  });

}).call(this);
