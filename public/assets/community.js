(function(){$(document).ready(function(){return $("a#new_discussion_link").fancybox({onComplete:function(){return $("form#new_discussion_form input#title").focus()}}),$("input#new_question_button").click(function(){return $("a#new_discussion_link").click(),!1}),$("a#confirm_link").fancybox({onComplete:function(){return $("form#confirm_form input#confirm_delete_discussion_button").focus()}})})}).call(this);