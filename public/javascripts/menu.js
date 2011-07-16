$(function() {
  return false;
  var hideDelay = 800;
  var htimer = false;
  $('#menu ul li.big').each(function() {
    if ($(this).attr('id')) {
      var sub = $('#' + $(this).attr('id') + '_sub')
      if (sub.attr('id')) {
        $('#' + $(this).attr('id') + ', #' + sub.attr('id')).mouseover(function(){
          if (htimer) {
            clearTimeout(htimer);
          }
          $('.sub_menu').slideUp();

          sub.slideDown();	
        }).mouseout(function(){
          htimer = setTimeout(function(){
            $('.sub_menu').slideUp();
            htimer = null;
            }, hideDelay);
          });
        }
      }
    });    
  });


  var FloatingMenuInitialized = false;
  var FloatingMenuShowDelay = 300;
  var FloatingMenuHideDelay = 500;
  var FloatingMenuOutTimer = false;
  var FloatingMenuOverTimer = false;
  var FloatingMenuCurOver = false;
  var FloatingMenuDisapearing = false;

  function initFloatingMenuHtml()
  {
  	FloatingMenuInitialized = true;
  	$('#floating_menu').mouseout(function(){
  		outMenu();
  	}).mousemove(function() {
  		FloatingMenuCurOver = true;
  		if (FloatingMenuOutTimer) {
  			clearTimeout(FloatingMenuOutTimer);
  			FloatingMenuOutTimer = false;
  			$('#floating_menu').show();
  		}
  	});
  }

  function outMenu()
  {
  	FloatingMenuCurOver = false;
  	outFloatingMenu();
  }

  function outFloatingMenu()
  {
  	if (FloatingMenuOverTimer) {
  		clearTimeout(FloatingMenuOverTimer);
  		FloatingMenuOverTimer = false;
  		$("#floating_menu").stop();
  	}
  	FloatingMenuOutTimer = setTimeout(function() {
  		if (FloatingMenuCurOver) {
  			return;
  		}
  		if (FloatingMenuOverTimer) {
  			clearTimeout(FloatingMenuOverTimer);
  			FloatingMenuOverTimer = false;
  			$("#floating_menu").stop();
  		}
  		FloatingMenuDisapearing = true;
  		$("#floating_menu").fade(200, function() {
  			FloatingMenuDisapearing = false;
  		});
  	}, FloatingMenuHideDelay);
  }

  function overMenuCoord(x, y, user) {

  	var m = $('#floating_menu');

  	if (FloatingMenuOutTimer) {
  		clearTimeout(FloatingMenuOutTimer);
  		FloatingMenuOutTimer = false;
  	}

  	if (FloatingMenuOverTimer) {
    	clearTimeout(FloatingMenuOverTimer);
  		FloatingMenuOverTimer = false;
    }

  	if (FloatingMenuDisapearing) {
  		m.stop();
  		m.show();
  		m.css('opacity', 1);
  		FloatingMenuDisapearing = false;
  	} else {
  		m.stop();
  	}

  		m.animate({
  			left: x,
  			top: y
  		}, 200);

    	FloatingMenuOverTimer = setTimeout(function(){
    		FloatingMenuOverTimer = false;
  			if (m.css('display') != 'block') {
  				m.appear(150);
  			} else {
  				m.show();
  				m.css('opacity', 1);
  			}
    	}, FloatingMenuShowDelay);
  }

  function bindMenu(obj) {
  	if (!FloatingMenuInitialized) {
    	initFloatingMenuHtml();
    }
    if (!obj) {
  		obj = $('body');
  	}
   	$('div.avatar, div.avatar25', obj).each(function()
  	{
  		var aleft = 0;
  		var atop = 0;
  		var o = $(this);

  		var calcPosition = function() {
  			var of = o.offset();
  			aleft = of.left + 50;
  			atop = of.top + 30;

  			if (o.hasClass('avatar25')) {
  				aleft -= 25;
  				atop -= 25;
  			}
  		};
  		
  		var overMenu = function() {
  	  	calcPosition();
  			overMenuCoord(aleft, atop, user);
  		}
  		$(this).unbind('mouseover').mouseover(overMenu).unbind('mouseout').mouseout(outMenu);

  	});
  }

  $(function(){
  	bindMenu();
  });