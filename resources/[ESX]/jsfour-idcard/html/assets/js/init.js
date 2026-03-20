$(document).ready(function(){
  // LUA listener
  window.addEventListener('message', function( event ) {
    if (event.data.action == 'open') {
      var type        = event.data.type;
      if (event.data.array['user'] != null) {
      var userData    = event.data.array['user'][0];
      var sex         = userData.sex;
      }
      var licenseData = event.data.array['licenses'];
  	  var job         = event.data.array['job'];
      var jobname		= event.data.array['jobname']	  

      if ( type == 'driver' || type == null) {
        $('img').show();
        $('#name').css('color', '#282828');

        if ( sex.toLowerCase() == 'm' ) {
          $('img').attr('src', 'assets/images/male.png');
          $('#sex').text('ذكر');
        } else {
          $('img').attr('src', 'assets/images/female.png');
          $('#sex').text('أنثى');
        }

        $('#name').text(userData.firstname + ' ' + userData.lastname);
        $('#dob').text(userData.dateofbirth);
        $('#height').text(userData.height);
        $('#signature').text(userData.job.label);

        if ( type == 'driver' ) {
          if ( licenseData != null ) {
          Object.keys(licenseData).forEach(function(key) {
            var type = licenseData[key].type;

            if ( type == 'drive_bike') {
              type = 'دراجة';
            } else if ( type == 'drive_truck' ) {
              type = 'شاحنة';
            } else if ( type == 'drive' ) {
              type = 'سيارة';
            }

            if ( type == 'دراجة' || type == 'شاحنة' || type == 'سيارة' ) {
              $('#licenses').append('<p>'+ type +'</p>');
            }
          });
        }

          $('#id-card').css('background', 'url(assets/images/license.png)');
        } else {
			$('#id-card').css('background', 'url(assets/images/'+userData.job+'.png)');
        }
      } else if ( type == 'weapon' ) {
        $('img').hide();
        $('#name').css('color', '#d9d9d9');
        $('#name').text(userData.firstname + ' ' + userData.lastname);
        $('#dob').text(userData.dateofbirth);
        $('#signature').text(userData.firstname + ' ' + userData.lastname);

        $('#id-card').css('background', 'url(assets/images/firearm.png)');
      }

else if ( type == 'market' ) {
        $('img').show();
        $('#name').css('color', '#d9d9d9');
        $('#name').text(userData.firstname + ' ' + userData.lastname);
        $('#dob').text(userData.dateofbirth);
        $('#height').text(userData.height);		
        $('#signature').text(userData.firstname + ' ' + userData.lastname);

        $('#id-card').css('background', 'url(assets/images/market.png)');
      }


      else if ( type == 'daimend' ) {
        $('img').hide();
       
        $('#id-card').css('background', 'url(assets/images/sponserDiamond.png)');

      }


      else if ( type == 'plat' ) {
        $('img').hide();
       
        $('#id-card').css('background', 'url(assets/images/plat.png)');

      }

      else if ( type == 'sponserStrategy' ) {
        $('img').hide();
       
        $('#id-card').css('background', 'url(assets/images/sponserStrategy.png)');

      }


      else if ( type == 'gold' ) {
        $('img').hide();
       
        $('#id-card').css('background', 'url(assets/images/sponserGold.png)');
      }

      else if ( type == 'sponserSilver' ) {
        $('img').hide();
       
        $('#id-card').css('background', 'url(assets/images/sponserSilver.png)');
      }

      else if ( type == 'sponserOfficial' ) {
        $('img').hide();
       
        $('#id-card').css('background', 'url(assets/images/sponserOfficial.png)');
      }

      else if ( type == 'sponserbronze' ) {
        $('img').hide();
       
        $('#id-card').css('background', 'url(assets/images/sponserbronze.png)');
      }

else if ( type == 'sponser' ) {
  console.log(event.data.array.rolename)
        $('img').hide();

        $('#id-card').css('background', 'url(assets/images/sponserbronze.png)');
      }

      $('#id-card').show();
    } 

    

    else if (event.data.action == 'close')
     {
      $('#name').text('');
      $('#dob').text('');
      $('#height').text('');
      $('#signature').text('');
      $('#sex').text('');
      $('#id-card').hide();
      $('#licenses').html('');
    }
  });
});
