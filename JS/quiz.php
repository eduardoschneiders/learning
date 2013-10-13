<script type="text/javascript">

function inheritPrototype(childObject, parentObject) {
	var copyOfParent = Object.create(parentObject.prototype);
	copyOfParent.constructor = childObject;
	childObject.prototype = copyOfParent;
}

function User (theName, theEmail) {
	this.name = theName;
	this.email = theEmail;
	this.quizScores = [];
	this.currentScore = 0;
}

User.prototype = {
	constructor: User,
	saveScore:function (theScoreToAdd){
		this.quizScores.push(theScoreToAdd);
	},
	showNameAndScores:function () {
		var scores = this.quizScores.length > 0 ? this.quizScores.join(",") : "No Scores Yet";
		return this.name + " - Scores: " + scores;
	},
	changeEmail:function (newEmail){
		this.email = newEmail;
		return "New Email Saved: " + this.email;
	}
}

function Question(theQuestion, theChoices, theCorrectAnswer){
	this.question = theQuestion;
	this.choices = theChoices;
	this.correctAnswer = theCorrectAnswer;
	this.userAnswer = "";

	var newDate = new Date();

	QUIZ_CREATED_DATE = newDate.toLocaleDateString();


	this.getQuizDate = function(){
		return QUIZ_CREATED_DATE;
	}

	console.log("Quiz Created On: " + this.getQuizDate());

}

Question.prototype.getCorrectAnswer = function(){
	return this.correctAnswer;
}

Question.prototype.getUserAnswer = function(){
	return this.userAnswer;
}


Question.prototype.displayQuestion = function(){
	var questionToDisplay = "<div class='question'>" + this.question + "</div><ul>";
	choiceCounter = 0;

	this.choices.forEach(function(eachChoice){
		questionToDisplay += '<li><input type="radio" name="choice" value="' + choiceCounter + '">' + eachChoice + '</li>';
		choiceCounter++;
	});

	questionToDisplay += "</ul>";

	document.write(questionToDisplay);
}

function MultipleChoiceQuestion(theQuestion, theChoices, theCorrectAnswer){
	Question.call(this, theQuestion, theChoices, theCorrectAnswer);
}

inheritPrototype(MultipleChoiceQuestion, Question);

function DragDropQuestion(theQuestion, theChoices, theCorrectAnswer){
	Question.call(this, theQuestion, theChoices, theCorrectAnswer);
}

inheritPrototype(DragDropQuestion, Question);

DragDropQuestion.prototype.displayQuestion = function(){
	document.write(this.question);
}

var allQuestions = [
	new MultipleChoiceQuestion("Who is the Prime Minister of England", ["Obama", "Blair"], 3),
	new MultipleChoiceQuestion("What is the Capital of Brazil?", ["São Paulo", "Rio de Janeiro", "Brasília"], 2),
	new DragDropQuestion("Drag the correct City to the world map.", ["Washington, DC", "Rio de Janeiro", "Stockholm"], 0)
];

allQuestions.forEach(function(eachQuestion){
	eachQuestion.displayQuestion();
});

var eduardo = new User('Eduardo Schneiders', 'eduardo.m.schneiders@gmail.com');
window.document.write(eduardo.changeEmail("eduardo.schneiders@tca.com.br") + '<br />');
eduardo.saveScore(10);
eduardo.saveScore(15);

window.document.write(eduardo.name + '<br />');
window.document.write(eduardo.email + '<br />');
window.document.write(eduardo.showNameAndScores() + '<br />');

var teste = new Question("a", "b", "c");


</script>