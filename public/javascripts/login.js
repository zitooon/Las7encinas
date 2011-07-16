var RequestForm = {

  init: function(){

    $('#request_form input, #request_form textarea').click(function(){
      if($(this).attr('value') == $(this).attr('label')){
        $(this).attr('value', '');
      }}).focusout(function (){
      if($(this).attr('value') == ''){
        $(this).attr('value', $(this).attr('label'));
      }})
  }

};

