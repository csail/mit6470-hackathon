var alph = "abcdefghijklmnopqrstuvwxyz";
var gameBoard = [];
var gameStarted = false;
var boardSize = 5;
var fadingIDs = []

function initializePlay() {
	var userScore = 0;
	var possibleLetters = [];

	$("#start").click(function(){
		//clear game board representation
    gameBoard = [];
		for (var i=0; i<boardSize; i++) {
		  gameBoard.push( repeatArray(0, boardSize) );
		}

		//clear game board table
		$(".square").attr("src", "/assets/asl_letters/asl_blank.png");

		//get range of letters to be used for this game
		possibleLetters = [];
		for(var i=0; i<boardSize; i++){
			var index = Math.floor(Math.random()*25);
			while($.inArray(alph[index],possibleLetters) == 1){
				index = Math.floor(Math.random()*25);
			}
			possibleLetters.push(alph[index]);
		}
		
		//choose a starting letter
		$("#letter").text(possibleLetters[Math.floor(Math.random()*5)])
      .parent().addClass("letter");

		//reset user score
		userScore = 0;
		$("#score").text(userScore);

		$("#progress").css("width", "0px");
		beginProgressBar();

		gameStarted = true;
	});


	$(".square").click(function(){
		//if this space is empty
		var row = Math.floor($(this).attr("id")/10);
		var column = $(this).attr("id")%10;
		if(gameStarted && gameBoard[row][column]==0){
			//get letter
			var letter = $("#letter").text();
			//Check to see if any surrounding tiles have the same letter
			var matchingIDs = checkNeighbors(row, column, letter);

			//if this letter matched anything, don't add it and add to user score
			//otherwise, add it to the table
			if(matchingIDs.length>0){
				$(this).attr("src", "/assets/asl_letters/asl_"+letter+".png")
				$(this).css("opacity", 100);
				userScore += 1;


				var id_string = ".square#"+String(this.id);

				//remove matching letters and add to user score
				for (var i=0; i < matchingIDs.length; i++){
          var id_str = ".square#" + String(matchingIDs[i]);
					fade_out( id_str );
					//$("#"+String(matchingIDs[i])).attr("src", "/assets/asl_letters/asl_blank.png");
					gameBoard[Math.floor(matchingIDs[i]/10)][matchingIDs[i]%10] = 0;
					userScore += 1;
				}

				//$(this).attr("src", "/assets/asl_letters/asl_blank.png");
				fade_out(".square#"+this.id);
				gameBoard[row][column] = 0;
			}
			else{
				gameBoard[row][column] = letter;
				$(this).attr("src","/assets/asl_letters/asl_"+letter+".png");
				$(this).css("opacity", 100);
			}

			$("#score").text(userScore);

			//get next letter
			//$("#letter").text(alph[Math.floor((Math.random()*4)+startPoint)]);
			$("#letter").text(possibleLetters[Math.floor(Math.random()*5)]);

			$("#progress").css("width", "0%");

		}

	});

}


function checkNeighbors(row, column, letter){
	var myID =(row*10)+column;
	var nID = ((row-1)*10)+column;
	var eID = (row*10)+column+1;
	var sID = ((row+1)*10)+column;
	var wID = (row*10)+column-1;

	var matchingIDs = []
	if(row!=0 && gameBoard[row-1][column]==letter){
		matchingIDs.push(nID);
	}
	if(row!=5 && gameBoard[row+1][column]==letter){
		matchingIDs.push(sID);
	}
	if(column!=0 && gameBoard[row][column-1]==letter){
		matchingIDs.push(wID);
	}
	if(column!=5 && gameBoard[row][column+1]==letter){
		matchingIDs.push(eID);
	}

	return matchingIDs;
}


function beginProgressBar() {
	var width = parseInt($("#progress").css("width").substring(0,$("#progress").css("width").length-2));
	if(width < 270){
		$("#progress").css("width", String(width+10)+"px");

		for(var i=0; i<fadingIDs.length; i++){
			var id = fadingIDs[i];
			var opacity = parseFloat($(id).css("opacity"));
			if(opacity>0.1){
				$(id).css("opacity", String(opacity-0.1));
			}
			else{
				$(id).css("opacity", "0");
				fadingIDs.remove(i);
				$(id).attr("src", "/assets/asl_letters/asl_blank.png");
			}
		}

		setTimeout('beginProgressBar()',100);
	}
	else if(width == 270){
		$("#progress").css("width", "273px");
		gameStarted = false;
		$("#letter").text("Game Over")
      .parent().removeClass("letter");
	}
}


function repeatArray(value, repeats) {
  array = [];
  for (i=0; i<repeats; i+=1)
    array.push(value);
  return array;
}


//animation stuff
function fade_out(id) {
	fadingIDs.push(id);
}

function fade_in(id) {
	var opacity = $(id).css("opacity");
	if(opacity < 0.9){
		$(id).css("opacity", String(parseFloat(opacity)+0.1));
		setTimeout('fade_in()',50);
	}
	else{
		$(id).css("opacity", "1");
	}
}


// Array Remove - By John Resig (MIT Licensed)
Array.prototype.remove = function(from, to) {
  var rest = this.slice((to || from) + 1 || this.length);
  this.length = from < 0 ? this.length + from : from;
  return this.push.apply(this, rest);
};


