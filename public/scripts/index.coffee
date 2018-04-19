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
      getFollowers()
      getFollowees()
    else
      window.location = '/login'
  else
    window.location = '/login'
  return

@tweet = () ->
  message = document.getElementById('tweet-message').value

  if message?
    $.ajax({
      'async' : true,
      'crossDomain' : true,
      'headers' :
        'username' : username,
        'user_message' : message
      ,
      type: 'POST',
      url: '/users/addTweet',
      success: () =>
        document.getElementById('tweet-message').value = ''
        getFeed()
        return
    })
  return

@follow = () ->
  followee = document.getElementById('new-follow-input').value

  if followee?
    $.ajax({
      'async' : true,
      'crossDomain' : true,
      'headers' :
        'follower' : username,
        'followee' : followee
      ,
      type: 'POST',
      url: '/users/followUser',
      success: () =>
        document.getElementById('new-follow-input').value = ''
        getFeed()
        return
    })
  return

getFeed = () ->
  $.ajax({
    'async' : true,
    'crossDomain' : true,
    'headers' :
      'username' : username
    ,
    type: 'GET',
    url: '/users/getTimeline',
    success: (response) =>
      buildPage(response)
      return
  })
  return

getFollowers = () ->
  $.ajax({
    'async' : true,
    'crossDomain' : true,
    'headers' :
      'username' : username
    ,
    type: 'GET',
    url: '/users/getUsersFollowing',
    success: (response) =>
      followerHtml = ''
      response[0].forEach((follower) =>
        console.log follower
        followerHtml += '' +
          '<li class="follower">' +
            follower['follower'] +
          '</li>'
        return
      )

      document.getElementById('followers-list').innerHTML = followerHtml
      return
  })
  return

getFollowees = () ->
  $.ajax({
    'async' : true,
    'crossDomain' : true,
    'headers' :
      'username' : username
    ,
    type: 'GET',
    url: '/users/getUsersFollowers',
    success: (response) =>
      console.log(response)
      followeeHtml = ''
      response[0].forEach((followee) =>
        followeeHtml += '' +
          '<li class="follower">' +
          followee['followee'] +
          '</li>'
        return
      )

      document.getElementById('following-list').innerHTML = followeeHtml
      return
  })
  return

@favTweet = (tId) ->
  $.ajax({
    'async' : true,
    'crossDomain' : true,
    'headers' :
      'username' : username,
      'tweet_id' : tId
    ,
    type: 'POST',
    url: '/users/favoriteTweet',
    success: (response) =>
      console.log response
      return
  })
  return

@reTweet = (tweet, tId) ->
  $.ajax({
    'async' : true,
    'crossDomain' : true,
    'headers' :
      'username' : username,
      'tweet_id' : tId,
      'message' : this.getElementsByClassName('tweet-message')[0].innerHTML,
      'original_user' : this.getElementsByClassName('tweet-author')[0].innerHTML
    ,
    type: 'POST',
    url: '/users/retweetTweet',
    success: () =>
      getFeed()
      return
  })
  return

buildPage = (feedData) ->
  tweets = feedData[0]
  feed = document.getElementById('main')

  if tweets.length
    tweets.forEach((tweet) =>
      tweetHTML = '' +
        '<div class="tweet card">' +
        ' <p class="tweet-message">' + tweet['message'] + '</p>' +
        ' <p class="tweet-author">' + tweet['currentuser'] + '</p>' +
        ' <button class="retweet-button" onclick="reTweet(this, ' + tweet['tId'] + ')">retweet</button>' +
        ' <button class="retweet-button" onclick="favTweet(' + tweet['tId'] + ')">fav</button>' +
        '</div>'
      feed.innerHTML += tweetHTML
    )

  else
    $(feed).html("<h1>Your feed Is Empty!</h1><p>Follow someone or make a tweet to see stuff here</p>")
