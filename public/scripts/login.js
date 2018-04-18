// Generated by CoffeeScript 2.2.1
(function() {
  var manageLogin, username;

  username = '';

  $(document).ready(function() {
    var loginData, now, twoHours;
    if (localStorage.getItem('stwitter-login') !== null) {
      loginData = $.parseJSON(localStorage.getItem('stwitter-login'));
      // 2 hours in milliseconds
      twoHours = 1000 * 60 * 60 * 2;
      now = new Date().getTime();
      if (loginData.date && now - loginData.date < twoHours) {
        username = loginData.username;
        window.location = '/';
      }
    }
  });

  this.loginClient = function() {
    if (document.getElementById('username').value !== '' && document.getElementById('password').value !== '') {
      $.ajax({
        'async': true,
        'crossDomain': true,
        'headers': {
          'username': document.getElementById('username').value,
          'pass': document.getElementById('password').value
        },
        type: 'GET',
        url: '/users/getUser',
        success: (response) => {
          return manageLogin(response);
        }
      });
    }
  };

  manageLogin = function(response) {
    var loginData;
    if (response[0].length) {
      loginData = {
        username: response[0][0]['username'],
        date: new Date().getTime()
      };
      localStorage.setItem('stwitter-login', JSON.stringify(loginData));
      window.location = '/';
    } else {
      alert('Incorrect login information');
    }
  };

}).call(this);

//# sourceMappingURL=login.js.map