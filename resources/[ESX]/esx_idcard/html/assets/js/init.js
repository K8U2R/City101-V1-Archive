$(document).ready(function(){
  // LUA listener
  window.addEventListener('message', function( event ) {
    if (event.data.action == 'open') {
      var type        = event.data.type;
      if (event.data.array['user'] != null) {
        
        var userData    = event.data.array['user'][0];
        var sex         = userData.sex;
        var jobm         = userData.job;
      }
      var licenseData = event.data.array['licenses'];

      if ( type == 'driver' || type == null) {
        $('img').show();
        $('#name').css('color', '#282828');

        if ( sex.toLowerCase() == 'm' ) {
          $('#sex').text('ذكر');
        } else {
          $('#sex').text('أنثى');
        }

        $('#name').text(userData.firstname + ' ' + userData.lastname);
        $('#dob').text(userData.dateofbirth);
        $('#height').text(userData.height);

        if ( jobm.toLowerCase() == 'police' ) {
          $('#jobwesam').text('الامن العام');
        } else if ( jobm.toLowerCase() == "agent" ) {
          $('#jobwesam').text('حرس الحدود');
        } else if ( jobm.toLowerCase() == "ambulance" ) {
          $('#jobwesam').text('الدفاع المدني');
        } else if ( jobm.toLowerCase() == "mechanic" ) {
          $('#jobwesam').text('كراج الميكانيك');
        } else if ( jobm.toLowerCase() == "famrer" ) {
          $('#jobwesam').text('شركة المزارع');
        } else if ( jobm.toLowerCase() == "miner" ) {
          $('#jobwesam').text('الشركة الدولية للمعادن');
        } else if ( jobm.toLowerCase() == "bread" ) {
          $('#jobwesam').text('شركة ابو بشير الخباز للخبز');
        } else if ( jobm.toLowerCase() == "fisherman" ) {
          $('#jobwesam').text('شركة الأسماك المتحدة');
        } else if ( jobm.toLowerCase() == "fueler" ) {
          $('#jobwesam').text('شركة النفط والغاز الدولية');
        } else if ( jobm.toLowerCase() == "lumberjack" ) {
          $('#jobwesam').text('شركة الأخشاب المحلية');
        } else if ( jobm.toLowerCase() == "reporter" ) {
          $('#jobwesam').text('الحدث للصحافة والإعلام');
        } else if ( jobm.toLowerCase() == "slaughterer" ) {
          $('#jobwesam').text('الشركة الوطنية للدواجن');
        } else if ( jobm.toLowerCase() == "tailor" ) {
          $('#jobwesam').text('شركة الأقمشة');
        } else if ( jobm.toLowerCase() == "taxi" ) {
          $('#jobwesam').text('تاكسي');
        } else if ( jobm.toLowerCase() == "unemployed" ) {
          $('#jobwesam').text('عاطل');
        } else if ( jobm.toLowerCase() == "vegetables" ) {
          $('#jobwesam').text('الرقابة');
        }

        if ( type == 'driver' ) {
          if ( licenseData != null ) {
          Object.keys(licenseData).forEach(function(key) {
            var type = licenseData[key].type;

            if ( type == 'drive_bike') {
              type = 'bike';
            } else if ( type == 'drive_truck' ) {
              type = 'truck';
            } else if ( type == 'drive' ) {
              type = 'car';
            }

            if ( type == 'bike' || type == 'truck' || type == 'car' ) {
              $('#id-card').append('<p>'+ type +'</p>');
            }
          });
        }

          $('#id-card').css('background', 'url(assets/images/license/license.png)');
        } else {
			$('#id-card').css('background', 'url(assets/images/license/picture_for_all_jobs.png)');
        }
      } else if ( type == 'weapon' ) {
        $('img').hide();
        $('#name').css('color', '#d9d9d9');
        $('#name').text(userData.firstname + ' ' + userData.lastname);
        $('#dob').text(userData.dateofbirth);
        $('#id-card').css('background', 'url(assets/images/firearm.png)');
      }

      else if ( type == 'market' ) {
        $('img').show();
        $('#name').css('color', '#d9d9d9');
        $('#name').text(userData.firstname + ' ' + userData.lastname);
        $('#dob').text(userData.dateofbirth);
        $('#height').text(userData.height);

        $('#id-card').css('background', 'url(assets/images/market.png)');
      }

      else if ( type == 'sponserStrategy' ) {
        $('img').hide();
       
        $('#id-card').css('background', 'url(assets/images/ra3i/strategy.png)');

      }

      else if ( type == 'gold' ) {
        $('img').hide();
       
        $('#id-card').css('background', 'url(assets/images/ra3i/gold.png)');
      }

      else if ( type == 'sponserSilver' ) {
        $('img').hide();
       
        $('#id-card').css('background', 'url(assets/images/ra3i/fdy.png)');
      }

      else if ( type == 'plat' ) {
        $('img').hide();
       
        $('#id-card').css('background', 'url(assets/images/ra3i/platyny.png)');
      }

      else if ( type == 'bht' ) {
        $('img').hide();
       
        $('#id-card').css('background', 'url(assets/images/bht.png)');
      }

      else if ( type == 'daimend' ) {
        $('img').hide();
       
        $('#id-card').css('background', 'url(assets/images/ra3i/almasy.png)');
      }

      else if ( type == 'sponserOfficial' ) {
        $('img').hide();
        $('#id-card').css('background', 'url(assets/images/ra3i/rsmy.png)');
      }
      else if ( type == 'sponser' ) {
        $('img').hide();
        $('#id-card').css('background', 'url(assets/images/ra3i/bronzy.png)');
      }
      $('#id-card').show();
    }
    else if (event.data.action == 'close') {
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
