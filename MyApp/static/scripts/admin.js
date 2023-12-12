 $(document).ready(function () {
    $(".approve-button, .decline-button").click(function () {
      var bookingId = $(this).data("booking-id");
      var newStatus = $(this).hasClass("approve-button") ? "Approved" : "Declined";
      var email = $(this).data('email');

      // Confirm the action with the user
      var confirmMessage = "Are you sure you want to " + newStatus.toLowerCase() + " this booking?";
      if (!confirm(confirmMessage)) {
        return; // Do nothing if the user cancels the action
      }

      // Send a PUT request to update the booking status
      $.ajax({
        url: "http://127.0.0.1:5001/api/update_booking_status",
        type: "PUT",
        contentType: "application/json",
        data: JSON.stringify({ booking_id: bookingId, new_status: newStatus, email: email }),
        success: function (response) {
          console.log(response);
          
          // Update the UI without reloading the page
          $(`.approve-button[data-booking-id='${bookingId}'], .decline-button[data-booking-id='${bookingId}']`).parent().fadeOut();
          // Optionally display a success message
          $("#email-status").show().delay(3000).fadeOut(); // Display for 3 seconds and then fade out
        },
        error: function (error) {
          console.error(error);
          alert("Booking update was not successful");
        },
      });
    });
  });
       
