$(function() {
  //Main code

  setup_signup()
  setup_login()



  // FUNCTIONS

  function setup_signup() {
    $('#signup-show').click(function() {
      $('.panel').removeClass('show');
      $('#signup').addClass('show')
    })

    $('#signup .close').click(function() {
      $('#signup').removeClass('show')
    })

    $('#signup-button').click(function() {
      var data = {
        email: $('#signup .email').val(),
        password: $('#signup .password').val(),
        password_confirmation: $('#password_confirmation').val(),
        first_name: $('#first_name').val(),
        last_name: $('#last_name').val(),
        team_name: $('#team_name').val()
      }

      $.post(
        '/users/signup',
        data,
        function(response) {
          if (response.success) {
            $('#container').html(response.welcome)
          } else {
            $('#signup').removeClass('show')
            $('#message').html(response.errors)
          }
        }
      )
    })

  }

  function setup_login() {
    $('#login-show').click(function() {
      $('.panel').removeClass('show');
      $('#login').addClass('show')
    })

    $('#login .close').click(function() {
      $('#login').removeClass('show')
    })

    $('#login-button').click(function() {
      var data = {
        email: $('#login .email').val(),
        password: $('#login .password').val(),
      }

      $.post(
        '/sessions/login',
        data,
        function(response) {
          if (response.success) {
            $('#container').html(response.welcome)
          } else {
            $('#login').removeClass('show')
            $('#message').html('Either the email or password is Wrong!')
          }
        }
      )

    })
  }
})
