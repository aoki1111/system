$(window).ready( function() {
	$('#user_zipcode').jpostal({
		postcode : [
			'#user_zipcode'
		],
		address : {
			'#user_pref'  : '%3',
			'#user_city'  : '%4',
			'#user_street'  : '%5%6',
			'#user_building'  : '%7'
		}
	});

    $.fn.autoKana('#user_lastname', '#user_lastname_phonetic', {
        katakana : true
    });

    $.fn.autoKana('#user_firstname', '#user_firstname_phonetic', {
        katakana : true
    });
});
