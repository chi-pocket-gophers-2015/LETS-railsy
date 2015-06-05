// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(document).ready(function() {
  // debugger;
  if($('.decision').length > 0) {
    setInterval(function() {
      var request = $.ajax({
        url: window.location.href+"/something_changed",
        method: 'get',
        dataType: 'json'
      });
      request.done(function(response) {
        // debugger;
        if(response === true) {
          location.reload();
        }
      });
    }, 6000);
  }
});
