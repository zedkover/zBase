$(document).ready(function(){
  window.addEventListener("message", function(event) {
    if (event.data.showhud == true) {
      if (!$(".huds").is(":visible"))
        $('.huds').fadeIn();

      setProgressSpeed({speed: event.data.speed, speedUnit: event.data.speedUnit },'.progress-speed');      
      setProgressFuel(event.data.fuel,'.progress-fuel');

      if (event.data.fuel <= 20)
        $('.progress-fuel').addClass('orangeStroke');
      else if (event.data.fuel <= 10) {
        $('.progress-fuel').removeClass('orangeStroke');
        $('.progress-fuel').addClass('redStroke');
      }
    } else {
      if ($(".huds").is(":visible"))
        $('.huds').fadeOut();
    }
  });

  function setProgressFuel(percent, element){
    var circle = document.querySelector(element);
    var radius = circle.r.baseVal.value;
    var circumference = radius * 2 * Math.PI;
    var html = $(element).parent().parent().find('span');

    circle.style.strokeDasharray = `${circumference} ${circumference}`;
    circle.style.strokeDashoffset = `${circumference}`;

    const offset = circumference - ((-percent*73)/100) / 100 * circumference;
    circle.style.strokeDashoffset = -offset;

    html.text(Math.round(percent));
  }

  function setProgressSpeed(value, element){
    var circle = document.querySelector(element);
    var radius = circle.r.baseVal.value;
    var circumference = radius * 2 * Math.PI;
    var html = $(element).parent().parent().find('span');
    $(".kmh").text(value.speedUnit);
    var percent = value.speed * 100 / 220;

    circle.style.strokeDasharray = `${circumference} ${circumference}`;
    circle.style.strokeDashoffset = `${circumference}`;

    const offset = circumference - ((-percent*73)/100) / 100 * circumference;
    circle.style.strokeDashoffset = -offset;

    html.text(value.speed);
  }
});
