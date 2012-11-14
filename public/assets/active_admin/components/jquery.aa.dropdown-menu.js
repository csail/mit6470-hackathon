(function() {

  window.AA.DropdownMenu = AA.DropdownMenu = (function() {

    function DropdownMenu(options, element) {
      var defaults;
      this.options = options;
      this.element = element;
      this.$element = $(this.element);
      defaults = {
        fadeInDuration: 20,
        fadeOutDuration: 100,
        onClickActionItemCallback: null
      };
      this.options = $.extend({}, defaults, options);
      this.$menuButton = this.$element.find(".dropdown_menu_button");
      this.$menuList = this.$element.find(".dropdown_menu_list_wrapper");
      this.isOpen = false;
      this._buildMenuList();
      this._bind();
      return this;
    }

    DropdownMenu.prototype.open = function() {
      this.isOpen = true;
      this.$menuList.fadeIn(this.options.fadeInDuration);
      this._positionMenuList();
      this._positionNipple();
      return this;
    };

    DropdownMenu.prototype.close = function() {
      this.isOpen = false;
      this.$menuList.fadeOut(this.options.fadeOutDuration);
      return this;
    };

    DropdownMenu.prototype.destroy = function() {
      this.$element.unbind();
      this.$element = null;
      return this;
    };

    DropdownMenu.prototype.isDisabled = function() {
      return this.$menuButton.hasClass("disabled");
    };

    DropdownMenu.prototype.disable = function() {
      return this.$menuButton.addClass("disabled");
    };

    DropdownMenu.prototype.enable = function() {
      return this.$menuButton.removeClass("disabled");
    };

    DropdownMenu.prototype.option = function(key, value) {
      if ($.isPlainObject(key)) {
        return this.options = $.extend(true, this.options, key);
      } else if (key != null) {
        return this.options[key];
      } else {
        return this.options[key] = value;
      }
    };

    DropdownMenu.prototype._buildMenuList = function() {
      this.$menuList.prepend("<div class=\"dropdown_menu_nipple\"></div>");
      return this.$menuList.hide();
    };

    DropdownMenu.prototype._bind = function() {
      var _this = this;
      $("body").bind('click', function() {
        if (_this.isOpen === true) {
          return _this.close();
        }
      });
      return this.$menuButton.bind('click', function() {
        if (!_this.isDisabled()) {
          if (_this.isOpen === true) {
            _this.close();
          } else {
            _this.open();
          }
        }
        return false;
      });
    };

    DropdownMenu.prototype._positionMenuList = function() {
      var centerOfButtonFromLeft, centerOfmenuListFromLeft, menuListLeftPos;
      centerOfButtonFromLeft = this.$menuButton.offset().left + this.$menuButton.outerWidth() / 2;
      centerOfmenuListFromLeft = this.$menuList.outerWidth() / 2;
      menuListLeftPos = centerOfButtonFromLeft - centerOfmenuListFromLeft;
      return this.$menuList.css("left", menuListLeftPos);
    };

    DropdownMenu.prototype._positionNipple = function() {
      var $nipple, bottomOfButtonFromTop, centerOfmenuListFromLeft, centerOfnippleFromLeft, nippleLeftPos;
      centerOfmenuListFromLeft = this.$menuList.outerWidth() / 2;
      bottomOfButtonFromTop = this.$menuButton.offset().top + this.$menuButton.outerHeight() + 10;
      this.$menuList.css("top", bottomOfButtonFromTop);
      $nipple = this.$menuList.find(".dropdown_menu_nipple");
      centerOfnippleFromLeft = $nipple.outerWidth() / 2;
      nippleLeftPos = centerOfmenuListFromLeft - centerOfnippleFromLeft;
      return $nipple.css("left", nippleLeftPos);
    };

    return DropdownMenu;

  })();

  (function($) {
    $.widget.bridge('aaDropdownMenu', AA.DropdownMenu);
    return $(function() {
      return $(".dropdown_menu").aaDropdownMenu();
    });
  })(jQuery);

}).call(this);
