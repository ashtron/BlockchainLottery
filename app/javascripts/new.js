$(document).ready(function() {
  $("#expiration-date").datepicker();

  $(".submit").click(function() {
    $("input").addClass("well well-sm");
  });

  $('.hastip').tooltipsy({
    css: {
    'padding': '10px',
    'max-width': '200px',
    'color': '#303030',
    'background-color': '#f5f5b5',
    'border': '1px solid #deca7e',
    '-moz-box-shadow': '0 0 10px rgba(0, 0, 0, .5)',
    '-webkit-box-shadow': '0 0 10px rgba(0, 0, 0, .5)',
    'box-shadow': '0 0 10px rgba(0, 0, 0, .5)',
    'text-shadow': 'none'
    }
  });
});
