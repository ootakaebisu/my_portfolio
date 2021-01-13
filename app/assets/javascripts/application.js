// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require jquery3
//= require moment
//= require fullcalendar

//= require popper
//= require bootstrap-sprockets

//= require jquery-ui/widgets/sortable
//= require jquery-ui/effects/effect-highlight

//= require_tree .

// モーダル開閉
$(document).on('turbolinks:load', function() {
    $('.js-modal-open').on('click',function(){
        $('.js-modal').fadeIn();
        return false;
    });
    $('.js-modal-close').on('click',function(){
        $('.js-modal').fadeOut();
        return false;
    });
});




// ドラッグ&ドロップ
$(function(){
	function fixPlaceHolderWidth(event, ui){
		// adjust placeholder td width to original td width
		ui.children().each(function(){
			$(this).width($(this).width());
		});
		return ui;
	};

	$('#fix').sortable({
		placeholder: 'ui-state-highlight',
		start: function(event, ui){
			ui.placeholder.height(ui.helper.outerHeight());
		},
		update: function(e, ui){
      let item = ui.item;
      let item_data = item.data();
      let params = {_method: 'put'};
      // データの中身
      params['small_goal'] = { row_order_position: item.index() }
      params["authenticity_token"] = $("#authenticity_token").val()
      // ここで送ってる(submitと似た働き)
      $.ajax({
        type: 'POST',
        url: $(item).data("url"),
        // 戻り値の型の指定
        dataType: 'json',
        data: params
      });
    },
		stop: function(e, ui){
      ui.item.children('td').not('.item__status').effect('highlight', { color: "#FFFFCC" }, 500)
    },

		helper: fixPlaceHolderWidth
	});

	$('#not-fix').sortable({
		placeholder: 'ui-state-highlight',
	});
});


// $(function(){
//   $('#fix').sortable({
//     update: function(e, ui){
//       let item = ui.item;
//       let item_data = item.data();
//       let params = {_method: 'put'};
//       params[item_data.modelName] = { row_order_position: item.index() }
//       $.ajax({
//         type: 'POST',
//         url: item_data.updateUrl,
//         dataType: 'json',
//         data: params
//       });
//     },
//     stop: function(e, ui){
//       ui.item.children('td').not('.item__status').effect('highlight', { color: "#FFFFCC" }, 500)
//     },

// 		helper: fixPlaceHolderWidth
// 	});

// 	$('#not-fix').sortable({
// 		placeholder: 'ui-state-highlight',
// 	});
// });