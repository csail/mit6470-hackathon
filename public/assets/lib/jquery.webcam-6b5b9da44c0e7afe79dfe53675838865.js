/**
* jQuery webcam
* Copyright (c) 2010, Robert Eisele (robert@xarg.org)
* Dual licensed under the MIT or GPL Version 2 licenses.
* Date: 09/12/2010
*
* @author Robert Eisele
* @version 1.0
*
* @see http://www.xarg.org/project/jquery-webcam-plugin/
**/
(function(e){var t={extern:null,append:!0,width:320,height:240,mode:"callback",swffile:"jscam.swf",quality:85,debug:function(){},onCapture:function(){},onTick:function(){},onSave:function(){},onLoad:function(){}};window.webcam=t,e.fn.webcam=function(n){if(typeof n=="object")for(var r in t)n[r]!==undefined&&(t[r]=n[r]);var i='<object id="XwebcamXobjectX" type="application/x-shockwave-flash" data="'+t.swffile+'" width="'+t.width+'" height="'+t.height+'"><param name="movie" value="'+t.swffile+'" /><param name="FlashVars" value="mode='+t.mode+"&amp;quality="+t.quality+'" /><param name="allowScriptAccess" value="always" /></object>';null!==t.extern?e(t.extern)[t.append?"append":"html"](i):this[t.append?"append":"html"](i),(_register=function(e){var n=document.getElementById("XwebcamXobjectX");n.capture!==undefined?(t.capture=function(e){try{return n.capture(e)}catch(t){}},t.save=function(e){try{return n.save(e)}catch(t){}},t.setCamera=function(e){try{return n.setCamera(e)}catch(t){}},t.getCameraList=function(){try{return n.getCameraList()}catch(e){}},t.onLoad()):0==e?t.debug("error","Flash movie not yet registered!"):window.setTimeout(_register,1e3*(4-e),e-1)})(3)}})(jQuery);