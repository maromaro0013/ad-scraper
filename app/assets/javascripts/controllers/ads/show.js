$(document).on("ajax:success", "#ad-update-form", function(e) {
  $("span.flash-successful").text("Update successful.")
  $("span.flash-successful").show()
});
