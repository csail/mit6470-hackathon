var urls = {
  "flashcards": "/practice/learn/all",
  "quizzes": "/practice/quiz/colors",
  "fingerspelling": "/practice/play/easy"
  };

$(document).ready(function() {
  if ($.bbq.getState("tab") == null)
    activateTab('fingerspelling');

  // hash changes
  $(window).bind( "hashchange", function(e) {
    var tab = $.bbq.getState("tab");
    if (tab != null) {
      activateTab( tab );
    }
  });
  $(window).trigger( "hashchange" );

  $('li.tab-container').click( function() {
    activateTab( this.children[0].id );
    $.bbq.pushState({ tab: this.children[0].id });
  });

});


function activateTab(tab) {
  for (t in urls) {
    $('#'+t).parent().removeClass('active');
    $('#content').removeClass(t);
  }
  $('#'+tab).parent().addClass('active');
  $('#content').addClass(tab);

  $.get(urls[tab], function(result){
    $("#content").html(result);
    initQuizTab(tab);
  });
}


function initQuizTab(tab) {
  switch(tab) {
    case "fingerspelling":
      initializePlay();
      break;
    case "flashcards":
      //initializeLearn();
      break;
    case "quizzes":
      //initializeQuiz();
      break;
  }
}
;
