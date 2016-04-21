$(document).ready(function(){

  setInitialCards();


  var card_position = 2;
  var array_length_number = Number($('#playercard_array_length').text());

  $('#left-button').click(function(){
    $(".playercard-wrapper:nth-of-type(" + parseInt(card_position) + ")").css("display", "none");
    if (card_position === 2){
      card_position = array_length_number + 1;
    } else {
      card_position -= 1;
    };
    $(".playercard-wrapper:nth-of-type(" + parseInt(card_position) + ")").css("display", "flex");
    return card_position
  });

  $('#right-button').click(function(){
    $(".playercard-wrapper:nth-of-type(" + parseInt(card_position) + ")").css("display", "none");
    if (card_position === array_length_number + 1){
      card_position = 2;
    } else {
      card_position += 1;
    };
    $(".playercard-wrapper:nth-of-type(" + parseInt(card_position) + ")").css("display", "flex");
    return card_position;
  });

});

function setInitialCards() {
  $(".playercard-wrapper:nth-of-type(2)").css("display", "flex");
};
