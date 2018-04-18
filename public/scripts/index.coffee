username = ''

$(document).ready ->
  if localStorage.getItem('stwitter-login') isnt null
    loginData = $.parseJSON localStorage.getItem 'stwitter-login'

    # 2 hours in milliseconds
    twoHours = 1000 * 60 * 60 * 2

    now = new Date().getTime()

    if loginData.date && now - loginData.date < twoHours
      username = loginData.username
      getFeed()
    else
      window.location = '/login'
  else
    window.location = '/login'
  return

@getFeed = () ->
  $.ajax({
    'async' : true,
    'crossDomain' : true,
    'headers' :
      'username' : username
    ,
    type: 'GET',
    url: '/users/getTimeline',
    success: (response) => buildPage(response)
  })
  return

buildPage = (feedData) ->
  tweets = feedData[0]
  feed = document.getElementById('feed-container')

  if tweets.length
    tweets.forEach((tweet) =>
      tweetHTML = '' +
        '<div class="tweet">' +
        ' <p class="tweet-message">' + tweet['message'] + '</p>' +
        ' <p class="tweet-author">' + tweet['currentuser'] + '</p>' +
        ' <button class="retweet-button" onclick="reTweet(' + tweet['tId'] + ')">retweet</button>' +
        ' <button class="retweet-button" onclick="favTweet(' + tweet['tId'] + ')">fav</button>' +
        '</div>'
      feed.innerHTML += tweetHTML
    )

  else
    $(feed).html("<h1>Your feed Is Empty!</h1><p>Follow someone or make a tweet to see stuff here</p>")
