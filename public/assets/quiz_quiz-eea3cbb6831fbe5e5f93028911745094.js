// var curIndex=0;
// var wordList=[];
// var urlList=[];
// var previewList=[];
// var wordListString="";
// var urlListString="";
// var previewListString="";
// function initializeQuiz() {
//   //console.log($("#category").val());
//   //get wordlists?
//   $.get("quizzes/"+$("#category").val()+"/json", function(result){
//     result
//     curIndex = 0;
//     wordList = wordListString.split(",");
//     urlList = urlListString.split(",");
//     previewList = previewListString.split(",");
//     wordList.pop();
//     urlList.pop();
//     previewList.pop();
//     //console.log(wordList);
//     //console.log(urlList);
//     $("#remaining").text(wordList.length);
//     $("#word_list").attr("disabled", "false");
//     //if there is a valid video, load the video
//     if(urlList[0]!="" && previewList[0]!=""){
//       $("#video").html("<video class=\"video-js vjs-default-skin\" controls preload=\"none\" width=\"480\" height=\"264\" poster="+previewList[0]+"><source src="+urlList[0]+" type='video/mp4' /></video>);");
//     }
//     else{
//       $("#video").html("No video found");
//     }
//   });
//   $("#newquiz_button").fancybox();
//   $("#login_button").fancybox();
//   $('#tags_1').tagsInput();
// }
// function onAddTag(tag) {
//   alert("Added a tag: " + tag);
// }
// function onRemoveTag(tag) {
//   alert("Removed a tag: " + tag);
// }
// function onChangeTag(input,tag) {
//   alert("Changed a tag: " + tag);
// }
// // Make sure that every Ajax request sends the CSRF token
// function CSRFProtection(xhr) {
//  var token = $('meta[name="csrf-token"]').attr('content');
//  if (token) xhr.setRequestHeader('X-CSRF-Token', token);
// }
// if ('ajaxPrefilter' in $) $.ajaxPrefilter(function(options, originalOptions, xhr) { CSRFProtection(xhr); });
// else $(document).ajaxSend(function(e, xhr) { CSRFProtection(xhr); });
// function handleKeyPress(e,form){
//   var key=e.keyCode || e.which;
//   if (key==13){
//     $("#remaining").text(String(parseInt($("#remaining").text())-1));
//     if(curIndex >= wordList.length){
//     }
//     else if($("#word_guess").val().toLowerCase()==wordList[curIndex].toLowerCase()){
//       //console.log("correct");
//       $("#right").text(String(parseInt($("#right").text())+1));
//     }
//     else{
//       //console.log("incorrect");
//       $("#wrong").text(String(parseInt($("#wrong").text())+1));
//     }
//     $("#word_guess").val("");
//     $("video").attr("poster", previewList[curIndex+1]);
//     $("video").attr("url", previewList[curIndex+1]);
//     curIndex += 1;
//     if(curIndex == wordList.length){
//       $("#word_guess").val("Pick a New Quiz");
//       $("#word_guess").attr("disabled", "true");
//       $.get("quizzes/"+$("#category").val()+"/"+$("#right").text()+"/"+$("#wrong").text(), function(result){
//       });
//     }
//   }
// }
// $(".categories").click(function(){
//   $.get("quizzes/quiz/"+String(this.id), function(result){
//     $("#content").html(result);
//   });
// });
;