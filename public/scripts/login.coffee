username = ''

$(document).ready ->
  if localStorage.getItem('stwitter-login') isnt null
    loginData = $.parseJSON localStorage.getItem 'stwitter-login'

    # 2 hours in milliseconds
    twoHours = 1000 * 60 * 60 * 2

    now = new Date().getTime()

    if loginData.date && now - loginData.date < twoHours
      username = loginData.username
      window.location = '/'
  return

@loginClient = () ->
  if document.getElementById('username').value isnt '' and document.getElementById('password').value isnt ''
    $.ajax({
      'async' : true,
      'crossDomain' : true,
      'headers' :
        'username' : document.getElementById('username').value,
        'pass' : document.getElementById('password').value
      ,
      type: 'GET',
      url: '/users/getUser',
      success: (response) => manageLogin(response)
    })
  return

manageLogin = (response) ->
  if response[0].length
    loginData =
      username: response[0][0]['username']
      date: new Date().getTime()

    localStorage.setItem('stwitter-login', JSON.stringify(loginData))

    window.location = '/'

  else
    alert 'Incorrect login information'
  return