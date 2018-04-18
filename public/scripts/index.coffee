username = ''

$(document).ready ->
  if localStorage.getItem('stwitter-login') isnt null
    loginData = $.parseJSON localStorage.getItem 'stwitter-login'

    # 2 hours in milliseconds
    twoHours = 1000 * 60 * 60 * 2

    now = new Date().getTime()

    if loginData.date && now - loginData.date < twoHours
      username = loginData.username
      buildPage()
    else
      window.location = '/login'
  else
    window.location = '/login'
  return

buildPage = () ->
  # TODO: build home page
  return