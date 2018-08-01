$(document).on('turbolinks:load', function() {
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

    function decideArea(){
        var hokkaido = ["北海道"];
        var touhoku = ["青森県", "岩手県" ,"秋田県" ,"宮城県", "山形県", "福島県"];
        var shinetsu = ["新潟県" ,"長野県"];
        var kantou = ["茨城県", "群馬県", "東京都", "埼玉県", "神奈川県", "栃木県", "千葉県", "山梨県"];
        var hokuriku = ["富山県", "石川県", "福井県"];
        var chubu = ["愛知県", "岐阜県", "三重県", "静岡県"];
        var kansai = ["大阪府", "京都府", "滋賀県", "奈良県", "和歌山県", "兵庫県"];
        var chugoku = ["岡山県", "島根県", "鳥取県", "広島県", "山口県"];
        var shikoku = ["徳島県", "香川県", "高知県", "愛媛県"];
        var kyushu = ["福岡県", "佐賀県", "大分県", "鹿児島県", "熊本県", "長崎県", "宮崎県"];
        var okinawa = ["沖縄県"];
        var pref = $('#user_pref').val();
        if ($.inArray(pref, hokkaido) >= 0) {
            $('#user_area').val("Hokkaido");
        }else if ($.inArray(pref, touhoku) >= 0) {
            $('#user_area').val("Touhoku");
        }else if ($.inArray(pref, shinetsu) >= 0) {
            $('#user_area').val("Shinetsu");
        }else if ($.inArray(pref, kantou) >= 0) {
            $('#user_area').val("Kantou");
        }else if ($.inArray(pref, hokuriku) >= 0) {
            $('#user_area').val("Hokuriku");
        }else if ($.inArray(pref, chubu) >= 0) {
            $('#user_area').val("Chubu");
        }else if ($.inArray(pref, kansai) >= 0) {
            $('#user_area').val("Kansai");
        }else if ($.inArray(pref, chugoku) >= 0) {
            $('#user_area').val("Chugoku");
        }else if ($.inArray(pref, shikoku) >= 0) {
            $('#user_area').val("Shikoku");
        }else if ($.inArray(pref, kyushu) >= 0) {
            $('#user_area').val("Kyushu");
        }else if ($.inArray(pref, okinawa) >= 0) {
            $('#user_area').val("Okinawa");
        } else {
            $('#user_area').val("error");
        }
    }

    $('#user_pref').change(function(){
        decideArea();
    });
    $('#user_zipcode').change(function(){
        decideArea();
    });

    $.fn.autoKana('#user_lastname', '#user_lastname_phonetic', {
        katakana : true
    });

    $.fn.autoKana('#user_firstname', '#user_firstname_phonetic', {
        katakana : true
    });
});
