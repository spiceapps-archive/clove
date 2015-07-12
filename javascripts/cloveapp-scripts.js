var id_array= ["name", "email", "password", "code"];

function hover() {
   for( var i=0; i<id_array.length; i++ ){
      var elem = document.getElementById(id_array[i]);
      if( elem.value == "" ) { 
        elem.style.backgroundImage = "url('images/input.png')";
        elem.className = "";
      } else {
        elem.className = "done";
      }
   }
}


window.addEvent('domready', function() {
	SqueezeBox.assign($$('a[rel=boxed]'), {
		size: {x: 740, y: 463},
		ajaxOptions: {
			method: 'get'
		}
	});
});

Cufon.replace('ul#menu') 
Cufon.replace('.cufon, h1, h2, h3', { 
textShadow: ' #fff 1px 1px'
});