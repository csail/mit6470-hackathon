(function() {

  $(document).ready(function() {
    return $("div#main div#dictionary").click(function() {
      return window.location.href = '/dictionary';
    });
  });

  $(document).ready(function() {
    return $("div#main div#reverse").click(function() {
      return window.location.href = '/reverse_dictionary';
    });
  });

  $(document).ready(function() {
    return $("div#main div#practice").click(function() {
      return window.location.href = '/practice';
    });
  });

  $(document).ready(function() {
    return $("div#main div#community").click(function() {
      return window.location.href = '/community';
    });
  });

}).call(this);
