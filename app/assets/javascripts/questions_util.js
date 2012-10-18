// utils for the tagging questions

function getCheckedIds() {
  return $.map( $('.question input:checked'), function(element) {
    return parseInt( $(element).attr('id') );
  });
}

function checkTags(ids) {
  $('.choices input').each( function(index) { this.checked = false; });
  for (i in ids) {
    $('.choices input#'+ids[i]).each( function(index) { this.checked = true; });
  }
}
