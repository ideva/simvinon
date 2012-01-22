var Photo = {

  upload: function(  ) {
    $('loading').show(  );
    $('photo_upload').submit(  );
  },

  finish: function() {
    $('loading').hide(  );
    $('photo_upload').reset(  );
  },

  show: function(url) {
    $('photo').src = url;
    $('mask').show(  );
    $('photo-wrapper').visualEffect('appear', {duration:0.5});
  },

  hide: function(  ) {
    $('mask').hide(  );
    $('photo-wrapper').visualEffect('fade', {duration:0.5});
  },

  currentIndex: function(  ) {
    return this.urls(  ).indexOf($('photo').src);
  },

  prev: function(  ) {
    if(this.urls()[this.currentIndex(  )-1]) {
      this.show(this.urls()[this.currentIndex(  )-1])
    }
  },

  next: function(  ) {
    if(this.urls()[this.currentIndex(  )+1]) {
      this.show(this.urls()[this.currentIndex(  )+1])
    }
  },

  urls: function(  ) {
    if (!this.cached_urls) {
      this.cached_urls = $$('a.show').collect(function(el){
        var onclick = el.onclick.toString(  );
        return onclick.match(/".*"/g)[0].replace(/"/g,'');
      });
    }
    return this.cached_urls;
  }

}

var temp_id = ""
var PopUp = {
    // id = 'popup'
    setPosition: function(id){
      // get browser heigh and width
      temp = getScrollXY();
      browser_Width = temp[0];
      browser_Height = temp[1];
      div_width = $(id).getWidth();
      div_height = $(id).getHeight();

      horizontal_position = (browser_Width/2) - (div_width/2);
      vertical_position = (browser_Height/2) - (div_height/2) - 100;
      
      $(id).setStyle({
        padding: 0,
        //left: horizontal_position+'px',
        //top: vertical_position+'px'
        /*
        paddingTop: vertical_position+'px',
        paddingBottom: vertical_position+'px',
        paddingLeft: horizontal_position+'px',
        paddingRight: horizontal_position+'px'
        */
        marginTop: vertical_position+'px',
        marginBottom: vertical_position+'px',
        marginLeft: horizontal_position+'px',
        marginRight: horizontal_position+'px'
      });
      //$(id).style.behavior= 'margin-left:'+horizontal_position+'px;margin-top:'+vertical_position+'px';
    },
   //function showPopUp(){
   showPopUp: function(id){
       if(temp_id != id){
           
            this.setPosition(id);
            temp_id = id;
       }
      new Effect.Appear('popup_indicator_wraper', { from: 0, to: 0.5, duration: 0.75 });
      new Effect.Appear(id, { duration: 1 });


   },
    //function hidePopUp() {
    hidePopUp: function(id) {
      $(id).fade({ duration: 1 });
      $('popup_indicator_wraper').fade({ duration: 1, from: 0.5, to: 0 });
      //browser_Width = 0;browser_Height =0
    }
}

function getScrollXY() {
  var browser_Width = 0, browser_Height = 0;
  // get browser heigh and width
      if( typeof( window.innerWidth ) == 'number' ) {
        //Non-IE
        browser_Width = window.innerWidth;
        browser_Height = window.innerHeight;
      } else if( document.documentElement && ( document.documentElement.clientWidth || document.documentElement.clientHeight ) ) {
        //IE 6+ in 'standards compliant mode'
        browser_Width = document.documentElement.clientWidth;
        browser_Height = document.documentElement.clientHeight;
      } else if( document.body && ( document.body.clientWidth || document.body.clientHeight ) ) {
        //IE 4 compatible
        browser_Width = document.body.clientWidth;
        browser_Height = document.body.clientHeight;
      }
      //window.alert( 'Width = ' + browser_Width );
      //window.alert( 'Height = ' + browser_Height );
  return [ browser_Width, browser_Height ];
}


function ajax_call_back(observe_id, loading_id, update_id){
        //alert(observe_id);
        if(!loading_id || loading_id == ''){
            loading_id = 'loading_body';
        }

        $(observe_id).observe('ajax:before', function(event) {
            $(loading_id).show();
        });
        $(observe_id).observe('ajax:success', function(event) {
            $(loading_id).hide();//ajax:complete -> ajax:success ???
        });
        if(!update_id || update_id == ''){
            $(observe_id).observe('ajax:success', function(event) {
                $(update_id).innerHTML = event.responseText;
            });
        }
        
 }

// AJAX Psgination
// http://github.com/mislav/will_paginate/wiki/ajax-pagination
document.observe("dom:loaded", function() {
  // the element in which we will observe all clicks and capture
  // ones originating from pagination links
  var container = $(document.body)

  if (container) {
    var img = new Image
    img.src = '/images/loading.gif'

    function createSpinner() {
      return new Element('img', { src: img.src, 'class': 'spinner' })
    }

    container.observe('click', function(e) {
      var el = e.element()
      if (el.match('.pagination.ajax a')) {
        el.up('.pagination.ajax').insert(createSpinner())
        new Ajax.Request(el.href, { method: 'get' })
        e.stop();
      }
    })
  }
})




var is_hide = true;
function open_small_popup(id){
   if($(id).style.display == 'none'){
    $(id).appear();
    $(id).style.display = 'block'
    is_hide = false
   }else{
    //$(id).hide();
    $(id).style.display = 'none'
    is_hide = true;
   }
 }

function clear_popup_box(){
    $('popup_box_content_message').hide();
    $('popup_box_content_error_message').hide();
    $('popup_box_content').innerHTML='Loading...';
    PopUp.showPopUp('popup').show();
 }

function isSpclChar(id){
       var text = $(id).value;
       var iChars = "!@#$%^&*()+=[]\\\';.,/{}|\":<>?";
       for (var i = 0; i < text.length; i++) {
        if (iChars.indexOf(text.charAt(i)) != -1) {
          alert ("Special characters are not allowed");
          return false;
        }
       }
       return true
    }

function isSpclChar2(id){
       var text = $(id).value;
       var iChars = "@#^*+=[]\\\'\"<>";
       for (var i = 0; i < text.length; i++) {
        if (iChars.indexOf(text.charAt(i)) != -1) {
          alert ("Special characters are not allowed");
          $(id).focus();
          return false;
        }
       }
       return true
    }

function resize_text_area(e,id){
    var Ucode = (window.Event) ? e.which : e.keyCode;
    if (Ucode == 13){
        $(id).style.height = ($(id).scrollHeight) + 'px';
    }
}

toogle_edit_meta_description = true;
function edit_meta_description(e){
  if($('edit_meta_description') && toogle_edit_meta_description){
    $('edit_meta_description').hide();
    $('hidden_meta_description').show();
    toogle_edit_meta_description = false;
  }else{
      var Ucode = (window.Event) ? e.which : e.keyCode;
    if (Ucode == 13){     
        $('label_meta_description').innerHTML = $('text_area_meta_description').value;
        $('edit_meta_description').show();
        $('hidden_meta_description').hide();
        toogle_edit_meta_description = true;
    }
  }
}

function save_meta_description(e){
     $('label_meta_description').innerHTML = $('text_area_meta_description').value;
     $('edit_meta_description').show();
     $('hidden_meta_description').hide();
    toogle_edit_meta_description = true;
}

function getValueFromNodeList(node_list){
    //alert(node_list);
    var value = '';
    for(var i = node_list.length-1; i >= 0; i--){
        //alert(i);
        var obj = node_list.item(i);
        value = obj.value+','+value;
        //alert(obj.id + " =  " + obj.value);
    }
    return value;
}

function getValueFromNodeListCheckBox(node_list){
    //alert(node_list);
    var value = '';
    for(var i = node_list.length-1; i >= 0; i--){
        //alert(i);
        var obj = node_list.item(i);
        if(obj.checked){
            value = obj.value+','+value;
        }
        //alert(obj.id + " =  " + obj.value);
    }
    return value;
}

function navigation(id){
    var link = $$('#nav a[href]'); //$A($('nav').getElementsByTagName('a'));
    link.each(function(item) {
        if(item == id){
            item.setAttribute('class', 'selected');
        }else{
            item.setAttribute('class', 'deselected');
        }
    });
}

function check_box_toggle(id){
    if($(id).checked){
        $(id).checked = false;
    }else{
        $(id).checked = true;
    }
}

function check_box_toggle_class(master_check_box_object, class_name){

    var element = jQuery('.'+class_name);
    //alert(master_check_box.checked);
    i = 0
    jQuery.each(element, function(i, l){
        if(master_check_box_object.checked){
            l.checked = true;
        }else{
            l.checked = false;
        }
    });

}

/*
 * Javascript function base on JQuery
 **/
function make_label_mandatory(){
    var element = jQuery('div').find('label.required');
    jQuery.each(element, function(i, l){
        text = jQuery(l).html();
        jQuery(l).html('<span style="color:red">*</span>'+text);
    });

    element = jQuery('table').find('th.required');
    jQuery.each(element, function(i, l){
        text = jQuery(l).html();
        jQuery(l).html('<span style="color:red">*</span>'+text);
    });
}
function make_table_tr_color(){
    var element = jQuery('div').find('table tr');
    //alert(element);
    i = 0
    jQuery.each(element, function(i, l){
        mod = i % 2
        style = jQuery(l).attr('style');
        class_ = jQuery(l).attr('class');
        if(mod == 0 && !style && !class_){
            jQuery(l).css("background-color", "#DAE8F3");
        }
        i=i+1;
    });
}
function make_text_box_focus(){
    var element = jQuery('.focus');
    jQuery.each(element, function(i, l){
        jQuery(l).focus();
    });
}
function set_check_box_padding(){
    var element = jQuery('div').find('input type="checkbox"');
    alert(element);
    i = 0
    jQuery.each(element, function(i, l){
        alert(l);
        jQuery(l).css("width", "10px");
    });
}
function ajaxifyPagination() {
    $(".pagination.ajax a").click(function() {
        $.ajax({
          type: "GET",
          url: $(this).attr("href"),
          dataType: "script",
          beforeSend: function(data) {
            $('#loading_body').toggle();
          },
          complete: function(data) {
            $('#loading_body').toggle();
          }
        });
        return false;
    });
}

/*
 * Javascript function base on JQuery
 * This code will make the Menu stick on the top of the page and make it blured after maximum_scrollbar value has been reached
 **/
function following_fixed_menu(menu_div_id, maximum_scrollbar){
                jQuery(window).scroll(function(){
                  var scrollTop = jQuery(window).scrollTop();
                    //alert(scrollTop);
                    if(scrollTop >= maximum_scrollbar){
                      jQuery('#'+menu_div_id).stop().animate({'opacity':'0.2'},400);
                      jQuery('#'+menu_div_id).css( 'position', 'fixed' );
                      jQuery('#'+menu_div_id).css( 'top', '0' );
                    }else{
                      jQuery('#'+menu_div_id).stop().animate({'opacity':'1'},400);
                      jQuery('#'+menu_div_id).css( 'position', 'relative' );
                    }
		});

		jQuery('#sub_header_2').hover(
                  function (e) {
                    var scrollTop = jQuery(window).scrollTop();
                    if(scrollTop != 0){
                      jQuery('#'+menu_div_id).stop().animate({'opacity':'1'},400);
                    }
                  },
                  function (e) {
                    var scrollTop = jQuery(window).scrollTop();
                    if(scrollTop != 0){
                      jQuery('#'+menu_div_id).stop().animate({'opacity':'0.2'},400);
                    }
                  }
		);
};


function popup(mylink, windowname, width, height){
    if (! window.focus)return true;
    var href;
    if (typeof(mylink) == 'string')
       href=mylink;
    else
       href=mylink.href;

   if(width == ""){
       width = 400
   }
   if(height == ""){
       height = 200
   }
    window.open(href, windowname, 'width='+width+',height='+height+',scrollbars=yes');
    return false;
}

/*----------------JS Function for POS---------------------*/












