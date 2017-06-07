$(document).ready(function() {
  var liInfoBtn = $(".l1-info-btn")

  $(".l1-info-btn").click(function() {
    $(this).text(function(index, currentText) {
      if (currentText == "More Information") {
        return "Less Information";
      } else {
        return "More Information";
      }
    });
  });
});
