(function() {

  jQuery(function($) {
    $(document).delegate("#batch_actions_selector li a", "click.rails", function() {
      $("#batch_action").val($(this).attr("data-action"));
      return $("#collection_selection").submit();
    });
    if ($("#batch_actions_selector").length && $(":checkbox.toggle_all").length) {
      if ($(".paginated_collection").find("table.index_table").length) {
        $(".paginated_collection table").tableCheckboxToggler();
      } else {
        $(".paginated_collection").checkboxToggler();
      }
      return $(".paginated_collection").find(":checkbox").bind("change", function() {
        if ($(".paginated_collection").find(":checkbox").filter(":checked").length > 0) {
          return $("#batch_actions_selector").aaDropdownMenu("enable");
        } else {
          return $("#batch_actions_selector").aaDropdownMenu("disable");
        }
      });
    }
  });

}).call(this);
