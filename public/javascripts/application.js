$( document ).ready(function() {
	$('#add_catalogimgs_link').click( function (){
		catimg_attr_counter = catimg_attr_counter + 1 ;
    $('#add_catalogimgs_block').append(
    	'<input id="publication_images_attributes_'+ catimg_attr_counter +
    	'_picture" name="publication[images_attributes]['+ catimg_attr_counter +'][picture]" type="file" />');
    $('#add_catalogimgs_block').append(
    	'<input id="publication_images_attributes_'+ catimg_attr_counter +
    	'_user_id" name="publication[images_attributes]['+ catimg_attr_counter +'][user_id]" type="hidden" value="'+user_id+'" />');
    $('#add_catalogimgs_block').append(
        '<input id="publication_images_attributes_'+ catimg_attr_counter +
        '_size" name="publication[images_attributes]['+ catimg_attr_counter +'][size]" type="text" value="300x250" /><br>');
    return false ;
  });
});