$(function() {
	window.addEventListener('message', function(event) {
		switch (event.data.action) {
			case 'toggle':
				$('#wrap').fadeIn();
				break;

			case 'toggle2':
				$('#wrap2').fadeIn();
				break;

			case 'close':
				$('#wrap').fadeOut();
				$('#wrap2').fadeOut();
				break;

			case 'updatePlayerList':
				$('#playerlist tr:gt(0)').remove();
				$('#playerlist').append(event.data.players);
				$('#criminals').html(event.data.count);
				break;

			default:
				console.log('unknown action!');
				break;
		}
		if (event.data.type == 'shop') {
			$('#wrapper').show("fast");


		var i1;
		var id = 750;

		if (event.data.result.length > 10) {
			for (i1 = 0; i1 < (event.data.result.length -10) / 5; i1++) { 
				
				$('#wrapper').append(
					`<div class="line" style = "top: ${id}px; position: relative;"></div>`
				);

				id = id + 375
			}
		}

		var i;
		
		for (i = 0; i < event.data.result.length; i++) {
	
			if (event.data.result[i].level !== 0) {
				$('#wrapper').append(
					`<div class = "image" id = ${event.data.result[i].item} label = ${event.data.result[i].label} count = ${event.data.result[i].count} price = ${event.data.result[i].price}>
						<img src="${event.data.result[i].src}"/>
						<h3 class = "h4"><font color=FFAE00>${event.data.result[i].label}</font></h3>
						<h4 class = "h4"><font color=00EE4F>$</font>${event.data.result[i].price} للحبة</h4>
						<h4 class = "h4"><font color=orange>خبرة [ ${event.data.result[i].level} ]</font></h4>
						<h5 class = "h4"><font color=999999>في المخزن</font>: <font color=00A1FF>${event.data.result[i].count}</font>x</h5>
					</div>`
				);
			} else {
				$('#wrapper').append(
					`<div class = "image" id = ${event.data.result[i].item} label = ${event.data.result[i].label} count = ${event.data.result[i].count} price = ${event.data.result[i].price}>
						<img src="${event.data.result[i].src}"/>
						<h3 class = "h4"><font color=FFAE00>${event.data.result[i].label}</font></h3>
						<h4 class = "h4"><font color=00EE4F>$</font>${event.data.result[i].price} للحبة</h4>
						<h5 class = "h4"><font color=999999>في المخزن</font>: <font color=00A1FF>${event.data.result[i].count}</font>x</h5>
					</div>`
				);
			}
		}

		if (event.data.type2 == 'market') {
			$('#wrapper').append(
				` <h6 class = "h4" style = "position: absolute; right: 45%; font-size: 25px; color:rgb(100,221,23); " bottom = ${id - 5}>متجر - ${event.data.ShopName}</h6>`
			)
		}
		else if (event.data.type2 == 'bar') {
			$('#wrapper').append(
				` <h6 class = "h4" style = "position: absolute; right: 45%; font-size: 25px; color:rgb(124,0,190); " bottom = ${id - 5}>بار - ${event.data.ShopName}</h6>`
			)
		}
		else if (event.data.type2 == 'pharmacie') {
			$('#wrapper').append(
				` <h6 class = "h4" style = "position: absolute; right: 45%; font-size: 25px; color:rgb(245,48,48); " bottom = ${id - 5}>صيدلية - ${event.data.ShopName}</h6>`
			)
		}
		else if (event.data.type2 == 'rts') {
			$('#wrapper').append(
				` <h6 class = "h4" style = "position: absolute; right: 45%; font-size: 25px; color:rgb(255,143,0); " bottom = ${id - 5}>مـطـعـم - ${event.data.ShopName}</h6>`
			)
		}
		else if (event.data.type2 == 'weapons') {
			$('#wrapper').append(
				` <h6 class = "h4" style = "position: absolute; right: 45%; font-size: 25px; color:rgb(236,119,16); " bottom = ${id - 5}>متجر أسلحة - ${event.data.ShopName}</h6>`
			)
		}
		else if (event.data.type2 == 'SodaMachine') {
			$('#wrapper').append(
				` <h6 class = "h4" style = "position: absolute; right: 45%; font-size: 25px; color:rgb(236,167,27); " bottom = ${id - 5}>براد - ${event.data.ShopName}</h6>`
			)
		}

		var CartCount;

		$('.image').on('click', function () {
			$("#cart").load(location.href + " #cart");

			$('.carticon').show("fast");

			CartCount = CartCount + 1;
			var item = $(this).attr('id');
			var label = $(this).attr('label');
			var count = $(this).attr('count');
			var price = $(this).attr('price');

			$("#" + item).hide();
			

			$.post('http://esx_shops2/putcart', JSON.stringify({item: item, price : price, label : label, count : count, id : id}), function( cb ) {

				$('#cart').html('');

			var i;
				for (i = 0; i < cb.length; i++) { 

					$('#cart').append(
						`<div class = "cartitem" label = ${cb[i].label} count = ${cb[i].count} price = ${cb[i].price}>
						<img src="img/${cb[i].item}.png"/>
						<h4><font color=FFAE00>${cb[i].label}</font></h4>
						<h5><font color=00EE4F>$</font>${cb[i].price} للحبة</h4>
						<h6><font color=999999>في المحزن</font>: <font color=00A1FF>${cb[i].count}</font></h4>
						<input type="text" id = ${cb[i].item} count = ${cb[i].count} class = "textareas" placeholder = "حدد الكمية المطلوبة؟"></textarea>
						</div>`
							);
						};

						$('#cart').append(
						`
						<button class = "button" id = "buybutton" style = "position: absolute; right: 15px; top: 5px;">شراء</button>
						<button class = "button" id = "back" style = "position: absolute; left: 15px; top: 5px;">رجوع</button>
						`
					);
				});
		});
		
		$('.carticon').on('click', function () {
			$('#cart').show("fast");
			$('#wrapper').hide("fast");
			$('.carticon').hide("fast");
		});

		$("body").on("click", "#refreshcart", function() {
			$.post('http://esx_shops2/escape', JSON.stringify({}));
			location.reload(true);
			$('#wrapper').hide("fast");
			$('#payment').hide("fast");
			$('#cart').hide("fast");
			$.post('http://esx_shops2/refresh', JSON.stringify({}));
		});

		$("body").on("click", "#back", function() {
			$('#cart').hide("fast");
			$('#wrapper').show("fast");
			$('.carticon').show("fast");
		});

		$("body").on("click", "#buybutton", function() {
			var value = document.getElementsByClassName("textareas");

			for (i = 0; i < value.length; i++) {

				var isNumber = isNaN(value[i].value) === false;

				var count = $('#' + value[i].id).attr('count');

				if (parseInt(count) >= parseInt(value[i].value) && parseInt(value[i].value) != 0 && isNumber) {

					$.post('http://esx_shops2/escape', JSON.stringify({}));
				
					location.reload(true);

					$('#wrapper').hide("fast");
					$('#payment').hide("fast");
					$('#cart').hide("fast");
					$.post('http://esx_shops2/buy', JSON.stringify({Count : value[i].value, Item : value[i].id}));
				} 
				else {
					$.post('http://esx_shops2/notify', JSON.stringify({msg : "<font color=red>الكمية خاطئة</font>"}));
				}
			}
		});

		
		$("body").on("click", "#bossactions", function() {
			$.post('http://esx_shops2/bossactions', JSON.stringify({}));
			$.post('http://esx_shops2/escape', JSON.stringify({}));
			location.reload(true);
			$.post('http://esx_shops2/emptycart', JSON.stringify({}));
			$('#wrapper').hide("fast");
			$('#payment').hide("fast");
			$('#cart').hide("fast");
		});
	}
});




document.onkeyup = function (data) {
	if (data.which == 27) { // Escape key
		$.post('http://esx_shops2/escape', JSON.stringify({}));
		location.reload(true);
		$.post('http://esx_shops2/emptycart', JSON.stringify({}));
		$('#wrapper').hide("fast");
		$('#payment').hide("fast");
		$('#cart').hide("fast");
	}
}
});

function sortPlayerList() {
	var table = $('#playerlist'),
		rows = $('tr:not(.heading)', table);

	rows.sort(function(a, b) {
		var keyA = $('td', a).eq(1).html();
		var keyB = $('td', b).eq(1).html();

		return (keyA - keyB);
	});

	rows.each(function(index, row) {
		table.append(row);
	});
}