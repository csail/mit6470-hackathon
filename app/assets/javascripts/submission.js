$(document).ready(function(){
  var editor = ace.edit("editor");
  editor.setHighlightActiveLine(false);
  editor.setTheme("ace/theme/monokai");
  editor.getSession().setMode("ace/mode/javascript");
  editor.on("change", d);

  $('#submission_code').hide();
  $('#new_submission').submit(function(){
    $('#submission_code').val(editor.getSession().getValue());
  });
  
  function d(){
   $("#updated-code-alert").fadeIn()
  }
  
    code = editor.getValue();
  
  
  $("#submit_problem").click(function(){
    code = editor.getValue();
    $("#updated-code-alert").fadeOut();
  });
  
  $("#slider1").slider();
  $("#slider1").slider("value",80);
  $("#slider2").slider();
  $("#slider2").slider("value",10);
  $("#slider3").slider();
  $("#slider3").slider("value",10);
  
  $("#slider1").slider({
    slide: function( event, ui ) {
      updateDisplayValues();
      eval(code);
      updateSliderValue(1,ui.value);
    }
  });
  $("#slider2").slider({
    slide: function( event, ui ) {
      updateDisplayValues();
      eval(code);
      updateSliderValue(2,ui.value);
    }
  });
  $("#slider3").slider({
    slide: function( event, ui ) {
      updateDisplayValues();
      eval(code);
      updateSliderValue(3,ui.value);
    }
  });
  
  
  $("#reset_values").click(function(){
    $("#slider1").slider("value",80);
    $("#slider2").slider("value",10);
    $("#slider3").slider("value",10);
    updateDisplayValues();
  });
  
  updateDisplayValues();
  
  function updateDisplayValues(){
      $("#value1").text($("#slider1").slider( "value" ));
      $("#value2").text($("#slider2").slider( "value" ));
      $("#value3").text($("#slider3").slider( "value" ));
  }
  
  
  tvalue = [];
  tvalue[1] = 80;
  tvalue[2] = 10;
  tvalue[3] = 10;
  
  runSolution = function(N,K){
    
    for (i = 1; i <= 3; i ++){
      if (tvalue[i] < 0.5){
        tvalue[i] = 0.2;
      }
    }
    
    updateDisplayValues();
    hackingSolution(N,K);
    
    function normalize(){
      normalize = tvalue[1] + tvalue[2] + tvalue[3];
      tvalue[1] = (tvalue[1]/normalize) * 100;
      tvalue[2] = (tvalue[2]/normalize) * 100;
      tvalue[3] = 100 - (tvalue[1] + tvalue[2]);
      
      t1 = Math.round(tvalue[1]);
      t2 = Math.round(tvalue[2]);
      t3 = Math.round(tvalue[3]);
      
      $("#slider1").slider("value",t1);
      $("#slider2").slider("value",t2);
      $("#slider3").slider("value",t3);
    }
    
    function hackingSolution(N,K){
      nonchangedvalue = 0;
      
      for (i = 1; i <= 3; i ++){
        if (i != N){
          nonchangedvalue += tvalue[i];
        }
      }
      
      change = K - tvalue[N];
      
      tvalue[N] = K;
      for (i = 1; i <= 3; i ++){
        if (i != N){
          tvalue[i] -= (tvalue[i]/nonchangedvalue)*change;
        }
      }
      
      console.log(tvalue);
      normalize();
      updateDisplayValues();
    }
  }
  
  
});
