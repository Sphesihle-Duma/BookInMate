jQuery.noConflict(); 
jQuery(document).ready(function () {
    jQuery(".approve-button, .decline-button").click(function () {
      var bookingId = jQuery(this).data("booking-id");
      var newStatus = jQuery(this).hasClass("approve-button") ? "Approved" : "Declined";
      var email = jQuery(this).data('email');

      // Confirm the action with the user
      var confirmMessage = "Are you sure you want to " + newStatus.toLowerCase() + " this booking?";
      if (!confirm(confirmMessage)) {
        return; // Do nothing if the user cancels the action
      }

      // Send a PUT request to update the booking status
      jQuery.ajax({
        url: "http://dumasphesihle.tech:5001/api/update_booking_status",
        type: "PUT",
        contentType: "application/json",
        data: JSON.stringify({ booking_id: bookingId, new_status: newStatus, email: email }),
        success: function (response) {
          console.log(response);
          
          // Update the UI without reloading the page
          jQuery(`.approve-button[data-booking-id='${bookingId}'], .decline-button[data-booking-id='${bookingId}']`).parent().fadeOut();
          // Optionally display a success message
          jQuery("#email-status").show().delay(3000).fadeOut(); // Display for 3 seconds and then fade out
        },
        error: function (error) {
          console.error(error);
          alert("Booking update was not successful");
        },
      });
    });
  });
       
