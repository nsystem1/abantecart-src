<?php if (!empty($error['warning'])) { ?>
	<div class="warning alert alert-error alert-danger"><?php echo $error['warning']; ?></div>
<?php } ?>
<?php if ($success) { ?>
	<div class="success alert alert-success"><?php echo $success; ?></div>
<?php } ?>

<?php echo $summary_form; ?>

<?php echo $product_tabs ?>

<div id="content" class="tab-content">

	<div class="panel-heading">

		<div class="pull-left form-inline">
			<div class="form-group">
				<div class="input-group input-group-sm">
					<label><?php echo $tab_option; ?></label>
				</div>
			</div>			
			<div class="form-group">
				<div class="input-group input-group-sm">
				<?php echo $options; ?>
				</div>
			</div>			
			<div class="btn-group ml10 toolbar">
                    <a class="btn btn-white tooltips" href="#"
					   title="<?php echo $text_new_option; ?>"
					   data-original-title="<?php echo $text_new_option; ?>"
					   data-target="#option_modal" data-toggle="modal">
                    <i class="fa fa-plus"></i>
                    </a>
			</div>
		</div>

		<div class="pull-right">

			<div class="btn-group mr10 toolbar">
				<?php echo $form_language_switch; ?>
			</div>

			<div class="btn-group mr10 toolbar">
				<?php if (!empty ($help_url)) : ?>
					<a class="btn btn-white tooltips" href="<?php echo $help_url; ?>" target="new" data-toggle="tooltip"
					   title="" data-original-title="Help">
						<i class="fa fa-question-circle"></i>
					</a>
				<?php endif; ?>
			</div>
		</div>

	</div>

	<div class="panel-body panel-body-nopadding" id="option_values">
		<?php //# Options HTML loaded from responce controller rt=product/product/load_option ?>		
	</div>
</div>

<?php


$modal_content = '<div class="add-option-modal" >
			<div class="panel panel-default">
			    <div id="collapseTwo" >
			    	'.$form['form_open'].'
			    	<div class="panel-body panel-body-nopadding">
			    		'.$attributes.'
			    		<div class="mt10 options_buttons" id="option_name_block">
			    			<div class="form-group '. (!empty($error['status']) ? "has-error" : "") .'">
			    				<label class="control-label col-sm-3 col-xs-12" for="'.$field->element_id.'">'. $entry_status.'</label>
			    				<div class="input-group afield ">
			    					'.$status.'
			    				</div>
			    			</div>
			    			<div class="form-group '.(!empty($error['option']) ? "has-error" :"").'">
			    				<label class="control-label col-sm-3 col-xs-12" for="'.$field->element_id.'">'.$entry_option.'</label>
			    				<div class="input-group afield ">
			    					'.$option_name.'
			    				</div>
			    			</div>
			    			<div class="form-group '.(!empty($error['element_type']) ? "has-error" : "").'">
			    				<label class="control-label col-sm-3 col-xs-12" for="'.$field->element_id.'">'.$entry_element_type.'</label>
			    				<div class="input-group afield ">
			    					'.$element_type.'
			    				</div>
			    			</div>
			    			<div class="form-group '.(!empty($error['sort_order']) ? "has-error" : "") .'">
			    				<label class="control-label col-sm-3 col-xs-12" for="'.$field->element_id.'">'.$entry_sort_order.'</label>
			    				<div class="input-group afield ">
			    					'.$sort_order.'
			    				</div>
			    			</div>
			    			<div class="form-group '.(!empty($error['required']) ? "has-error" : "").'">
			    				<label class="control-label col-sm-3 col-xs-12" for="'.$field->element_id.'">'.$entry_required.'</label>
			    				<div class="input-group afield ">
			    					'.$required.'
			    				</div>
			    			</div>
			    		</div>
			    	</div>
			    	<div class="panel-footer">
			    		<div class="row">
			    		   <div class="center">
			    			 <button class="btn btn-primary">
			    			 <i class="fa fa-save"></i> '.$form['submit']->text.'
			    			 </button>&nbsp;
			    			 <button type="button" class="btn btn-default" data-dismiss="modal">
			    			 <i class="fa fa-times"></i> '.$form['cancel']->text.'
			    			 </button>
			    		   </div>
			    		</div>
			    	</div>
			    	</form>
			    </div>
			</div>
		</div>';

echo $this->html->buildElement(
		array('type' => 'modal',
				'id' => 'option_modal',
				'name' => 'option_modal',
				'modal_type' => 'lg',
				'title' => $text_add_new_option,
				'content' => $modal_content));
?>



<?php echo $resources_scripts; ?>
<script type="text/javascript"><!--

var setRLparams = function (attr_val_id) {
	urls.resource_library = '<?php echo $rl_rl_path; ?>&object_id=' + attr_val_id;
	urls.resources = '<?php echo $rl_resources_path; ?>&object_id=' + attr_val_id;
	urls.unmap = '<?php echo $rl_unmap_path; ?>&object_id=' + attr_val_id;
	urls.attr_val_id = attr_val_id;
}

var openRL = function (attr_val_id) {
	setRLparams(attr_val_id);
	mediaDialog('image', 'add', attr_val_id);
}


// override rl js-script function
var loadMedia = function (type) {
	if (!urls.attr_val_id) return;
	var type = "image";
	$.ajax({
		url: urls.resources,
		type: 'GET',
		data: { type: type },
		dataType: 'json',
		success: function (json) {


			var html = '';
			$(json.items).each(function (index, item) {
				var src = '<img src="' + item['thumbnail_url'] + '" title="' + item['name'] + '" />';
				if (type == 'image' && item['resource_code']) {
					src = item['thumbnail_url'];
				}
				html += '<span id="image_row' + item['resource_id'] + '" class="image_block">\
                <a class="resource_edit" type="' + type + '" id="' + item['resource_id'] + '">' + src + '</a><br /></span>';
			});
			html += '<span class="image_block"><a title="<?php echo $text_add_media; ?>" class="resource_add" data-type="' + type + '"><i class="fa fa-plus-circle fa-5x"></i></a></span>';

			$('#rl_' + urls.attr_val_id).html(html);
			if ($(json.items).length) {
				$('a.resource_edit').unbind('click');
				$('a.resource_edit').click(function () {
					setRLparams($(this).parents('.add_resource').attr('id').replace('rl_', ''));
					mediaDialog($(this).attr('data-type'), 'update', $(this).attr('id'));
					return false;
				})
			}
			$('a.resource_add').unbind('click');
			$('a.resource_add').click(function () {

				setRLparams($(this).parents('.add_resource').attr('id').replace('rl_', ''));
				mediaDialog($(this).attr('data-type'), 'add', $(this).attr('id'));
				return false;
			});
		},
		error: function (jqXHR, textStatus, errorThrown) {
			$('#type_' + type).show();
			$('#rl_' + urls.attr_val_id).html('<div class="error" align="center"><b>' + textStatus + '</b>  ' + errorThrown + '</div>');
		}
	});

}


var mediaDialog = function (type, action, id) {

	$('#dialog').remove();

	var src = urls.resource_library + '&' + action + '=1&type=' + type;

	if (id) {
		src += '&resource_id=' + id;
	}
	$('#content').prepend('<div id="dialog" style="padding: 3px 0px 0px 0px;"><iframe src="' + src + '" style="padding:0; margin: 0; display: block; width: 100%; height: 100%;" frameborder="no" scrolling="auto"></iframe></div>');
	$('#dialog iframe').load(function (e) {
		try {
			var error_data = $.parseJSON($(this).contents().find('body').html());
		} catch (e) {
			var error_data = null;
		}
		if (error_data && error_data.error_code) {
			$('#dialog').dialog('close');
			httpError(error_data);
		}
	});

	$('#dialog').dialog({
		title: '<?php echo $text_resource_library; ?>',
		close: function (event, ui) {
			loadMedia(type);
		},
		width: 900,
		height: 500,
		resizable: false,
		modal: true
	});
};

var text = {
	error_attribute_not_selected: '<?php echo $error_attribute_not_selected ?>',
	text_expand: '<?php echo $text_expand ?>',
	text_hide: '<?php echo $text_hide ?>'
};
var opt_urls = {
	load_option: '<?php echo $url['load_option'] ?>',
	update_option: '<?php echo $url['update_option'] ?>',
	get_options_list: '<?php echo $url['get_options_list'] ?>'
};
var current_option_id = null;
var row_id = 1;

jQuery(function ($) {

	$(document).on('change', '#new_option_form_attribute_id', function () {
		var current_opt_attr_id = $(this).val();
		if ( current_opt_attr_id != 'new' ) {
			$("#option_name_block").hide();
		} else {
			$("#option_name_block").show();
			$("#option_name_reset").show();		
		}

	});

	$("#product_form").submit(function () {
	
		if ($("#new_option_form_attribute_id").val() == 'new' && ( $("#new_option_form_option_name").val() == '' || $("#new_option_form_element_type").val() == ''  )) {
			if ($("#new_option_form_option_name").val() == '') {
				$("#new_option_form_option_name").focus();
				$("#new_option_form_option_name").closest("span").next().next().show();
			} else {
				$("#new_option_form_option_name").closest("span").next().next().hide();
			}

			if ($("#new_option_form_element_type").val() == '') {
				$("#new_option_form_element_type").focus();
				$("#new_option_form_element_type").closest("span").next().next().show();
			} else {
				$("#new_option_form_element_type").closest("span").next().next().hide();
			}
			return false;
		} else if( $("#new_option_form_attribute_id").val() != 'new' ) {
			$("#new_option_form_option_name").val('');
			$("#new_option_form_element_type").val('');
		}
	});

	var updateOptions = function () {
		$.ajax({
			url: opt_urls.get_options_list,
			type: 'GET',
			dataType: 'json',
			success: function (json) {
				$("#option option").remove();
				for (var key in json) {
					var selected = '';
					if (key == current_option_id) { 
						selected = ' selected ';
					}
					$("#option").append($('<option value="' + key + '"'+selected+'>' + json[key] + '</option>'));
				}
			},
			error: function (jqXHR, textStatus, errorThrown) {
				error_alert(errorThrown);
			},
			complete: function() {
				bindEvents();
			}
		});
	}

	var editOption = function (id) {
		$('#notify_error').remove();
		$.ajax({
			url: opt_urls.update_option,
			data: {
				option_id: current_option_id,
				status: ( $('#status').val() ),
				sort_order: $('#sort_order').val(),
				name: $('#name').val(),
				option_placeholder: ($('#option_placeholder') ? $('#option_placeholder').val() : ''),
				regexp_pattern: ($('#regexp_pattern') ? $('#regexp_pattern').val() : ''),
				error_text: ($('#error_text') ? $('#error_text').val() : ''),
				required: ($('#required').is(':checked') ? 1 : 0)
			},
			type: 'GET',
			success: function (html) {
				$('#option_name').html($('#name').val());
				updateOptions();
				//Reset changed values marks
				resetAForm($("input, checkbox, select", '#option_edit_form'));
				success_alert('<?php echo $text_success_option?>',true);
			},
			error: function (jqXHR, textStatus, errorThrown) {
				error_alert(errorThrown);
			}
		});
		return false;
	}

	$(document).on('click', "#option_values_tbl a.remove", function () {
		if ($(this).closest('tr').find('input[name^=product_option_value_id]').val() == 'new') {
			//remove new completely
			$(this).closest('tr').next().remove();
			$(this).closest('tr').remove();
		} else {
			//mark for delete and set disabled
			$(this).closest('tr').toggleClass('toDelete').toggleClass('transparent');
		}
		return false;
	});

	$(document).on('click',"#option_values_tbl a.expandRow",function () {

		var row_id = $(this).parents('tr').attr('id');
		var additional_row = $('#add_'+row_id +'div.additionalRow');
		var icon = $(this).find('i');
		if (icon.hasClass("fa-expand")) {
			$(this).attr('title', text.text_hide);
			icon.removeClass('fa-expand').addClass('fa-compress');
			setRLparams($(this).attr('id'));
			loadMedia('image');
		} else {
			$(this).attr('title', text.text_expand);
			icon.removeClass('fa-compress').addClass('fa-expand');
			additional_row.find('div.add_resource').html();
		}

		return false;
	});

	$(document).on('click', '.open_newtab', function () {
		var href = $(this).attr('link');
		top.open(href, '_blank');
		return false;
	});


	$(document).on('click', '.uncheck', function () {
		$("input[name='default_value']").removeAttr('checked');
		return false;
	});

	$(document).on('click',"#add_option_value", function () {
		var new_row = $('#new_row').parent().find('tr').clone();
		$(new_row).attr('id', 'new' + row_id);

		//find next sort order number
		var so = $('#option_values_tbl').find("input[name^='sort_order']");
		if (so.length > 0) {
			var highest = 0;
			so.each(function () {
				highest = Math.max(highest, parseInt(this.value));
			});
			$(new_row).find("input[name^='sort_order']").val(highest + 1);
		} else {
			$(new_row).find("input[name^='sort_order']").val(0);
		}

		if($('#option_values_tbl tbody').length){
			//add one more row
			$('#option_values_tbl tbody tr:last-child').after(new_row);
		} else {
			//we insert first row
			$('#option_values_tbl tr:last-child').after(new_row);			
		}
		bindAform($("input, checkbox, select", new_row));
		//Mark rows to be new
		$('#new' + row_id + ' input[name=default_value]').last()
				.val('new' + row_id)
				.attr('id', 'option_value_form_default_new' + row_id)
				.removeAttr('checked')
				.parent('label')
				.attr('for', 'option_value_form_default_new' + row_id);
		$('#new' + row_id + ' input[name^=product_option_value_id]').val('new');
		$("#new" + row_id + " input, #new" + row_id + " textarea, #new" + row_id + " select").each(function (i) {
			var new_name = $(this).attr('name');
			new_name = new_name.replace("[]", "[new" + row_id + "]");
			$(this).attr('name', new_name);
		});
		row_id++;
		return false;
	});

	$('#option').change(function () {
		current_option_id = $(this).val();
		$.ajax({
			url: opt_urls.load_option,
			type: 'GET',
			data: { option_id: current_option_id },
			success: function (html) {
				$('#option_values').html(html);
			},
			error: function (jqXHR, textStatus, errorThrown) {
				error_alert(errorThrown);
			},
			complete: function() {
				bindAform($("input, checkbox, select", '#option_edit_form'));
				bindAform($("input, checkbox, select", '#update_option_values'));
				bindEvents();
			}
		});
	});


	//select option and load data for it
	$('#option option:first-child').attr("selected", "selected").change();

	$(document).on('click','#update_option', function () {
		editOption('#update_option');
	});

	$(document).on('click','#reset_option',function () {
		$('#option').change();
		return false;
	});
		
	$(document).on('click','#option_values button[type="submit"]', function () {
		//Mark rows to be deleted
		$('#option_values_tbl .toDelete input[name^=product_option_value_id]').val('delete');
		$(this).attr('disabled', 'disabled');

		editOption('#update_option');

		var that = this;
		$.ajax({
			url: $(that).closest('form').attr('action'),
			type: 'POST',
			data: $(that).closest('form').serializeArray(),
			success: function (html) {
				$('#option_values').html(html);
			},
			error: function (jqXHR, textStatus, errorThrown) {
				error_alert(errorThrown);
			},
			complete: function() {
				bindAform($("input, checkbox, select", '#option_edit_form'));
				bindAform($("input, checkbox, select", '#update_option_values'));
				bindEvents();
			}			
		});
		return false;
	});

});

// Function to delete option. NOTE. Needs to be here (global)
function optionDelete ( url ) {
		$.ajax({
			url: url,
			type: 'GET',
			success: function (html) {
				//remove option and reload the section
				$('#option option:selected').remove();
				$("#option").trigger("change");
				success_alert(html,true);
			},
			error: function (jqXHR, textStatus, errorThrown) {
				error_alert(errorThrown);
			},
			complete: function() {
				bindEvents();
			}
		});
		return false;
}

//--></script>