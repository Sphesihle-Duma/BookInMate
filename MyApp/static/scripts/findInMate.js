
  jQuery.noConflict();
  jQuery(document).ready(function($) { // Use $ inside the function
    console.log("testing");

    $('.searchButton').on('click', function() {
      var inputId = $('.searchInput').val();
      console.log(inputId);

      // Call the API
      $.ajax({
        url: 'http://127.0.0.1:5001/api/all_inmate',
        method: 'GET',
        success: function(data) {
          console.log('Success:', data);
          var filteredResults = data.filter(function(item) {
            return item.inmate_id === inputId;
          });

          // Display results
          displayResults(filteredResults);
        },
        error: function(error) {
          console.error('Error fetching data:', error);
        }
      });
    });

    function displayResults(results) {
      var resultsContainer = $('#resultsContainer');
      resultsContainer.empty(); // Clear previous results

      if (!results || results.length === 0) {
        resultsContainer.append('<p>No results found.</p>');
      } else {
        results.forEach(function(result) {
          var resultItem = $('<div class="resultItem"></div>');
          resultItem.append('<p>Inmate ID: ' + result.inmate_id + '</p>');
          resultItem.append('<p>Name: ' + result.name + '</p>');
          resultItem.append('<p>Facility ID: ' + result.facility_id + '</p>');

          resultsContainer.append(resultItem);
        });
      }
    }
  });
