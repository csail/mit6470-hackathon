/*
* Unobtrusive autocomplete
*
* To use it, you just have to include the HTML attribute autocomplete
* with the autocomplete URL as the value
*
*   Example:
*       <input type="text" data-autocomplete="/url/to/autocomplete">
*
* Optionally, you can use a jQuery selector to specify a field that can
* be updated with the element id whenever you find a matching value
*
*   Example:
*       <input type="text" data-autocomplete="/url/to/autocomplete" data-id-element="#id_field">
*/
(function(e){var t=null;e.fn.railsAutocomplete=function(){return this.live("focus",function(){this.railsAutoCompleter||(this.railsAutoCompleter=new e.railsAutocomplete(this))})},e.railsAutocomplete=function(e){_e=e,this.init(_e)},e.railsAutocomplete.fn=e.railsAutocomplete.prototype={railsAutocomplete:"0.0.1"},e.railsAutocomplete.fn.extend=e.railsAutocomplete.extend=e.extend,e.railsAutocomplete.fn.extend({init:function(t){function n(e){return e.split(t.delimiter)}function r(e){return n(e).pop().replace(/^\s+/,"")}t.delimiter=e(t).attr("data-delimiter")||null,e(t).autocomplete({source:function(n,i){e.getJSON(e(t).attr("data-autocomplete"),{term:r(n.term)},function(){e(arguments[0]).each(function(n,r){var i={};i[r.id]=r,e(t).data(i)}),i.apply(null,arguments)})},search:function(){var e=r(this.value);if(e.length<2)return!1},focus:function(){return!1},select:function(r,i){var s=n(this.value);s.pop(),s.push(i.item.value);if(t.delimiter!=null)s.push(""),this.value=s.join(t.delimiter);else{this.value=s.join(""),e(this).attr("data-id-element")&&e(e(this).attr("data-id-element")).val(i.item.id);if(e(this).attr("data-update-elements")){var o=e(this).data(i.item.id.toString()),u=e.parseJSON(e(this).attr("data-update-elements"));for(var f in u)e(u[f]).val(o[f])}}var l=this.value;return e(this).bind("keyup.clearId",function(){e(this).val().trim()!=l.trim()&&(e(e(this).attr("data-id-element")).val(""),e(this).unbind("keyup.clearId"))}),e(this).trigger("railsAutocomplete.select",i),!1}})}}),e(document).ready(function(){e("input[data-autocomplete]").railsAutocomplete()})})(jQuery);