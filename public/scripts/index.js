// Generated by CoffeeScript 2.2.1
(function() {
  var buildPage, username;

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
        buildPage();
      } else {
        window.load('/login');
      }
    } else {
      window.load('/login');
    }
  });

  buildPage = function() {};

  // TODO: build home page

}).call(this);

//# sourceMappingURL=index.js.map