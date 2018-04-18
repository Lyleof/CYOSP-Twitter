Drop database if exists twitter_model;
create database twitter_model;
use twitter_model;

CREATE TABLE DeletedTweet
(
  tId           INT AUTO_INCREMENT
    PRIMARY KEY,
  message       VARCHAR(140) NOT NULL,
  currentUser   VARCHAR(45)  NOT NULL,
  originalUser  VARCHAR(45)  NOT NULL,
  dateCreated   DATE         NOT NULL,
  dateDeleted   DATE         NOT NULL,
  originalTweet INT          NULL,
  CONSTRAINT DeletedTweet_tId_uindex
  UNIQUE (tId)
)
  ENGINE = InnoDB;

CREATE INDEX DeletedTweet_Profile_username_fk
  ON DeletedTweet (currentUser);

CREATE INDEX DeletedTweet_Profile_username_fk_2
  ON DeletedTweet (originalUser);

CREATE INDEX DeletedTweet_Tweet_tId_fk
  ON DeletedTweet (originalTweet);

CREATE TABLE FavoriteTweet
(
  ftId     INT AUTO_INCREMENT
    PRIMARY KEY,
  username VARCHAR(45) NOT NULL,
  tweet    INT         NOT NULL,
  CONSTRAINT FavoriteTweet_ftId_uindex
  UNIQUE (ftId)
)
  ENGINE = InnoDB;

CREATE INDEX FavoriteTweet_User_username_fk
  ON FavoriteTweet (username);

CREATE INDEX FavoriteTweet_Tweet_tId_fk
  ON FavoriteTweet (tweet);

CREATE TABLE Following
(
  fId      INT AUTO_INCREMENT
    PRIMARY KEY,
  follower VARCHAR(45) NOT NULL,
  followee VARCHAR(45) NOT NULL,
  CONSTRAINT Following_fId_uindex
  UNIQUE (fId)
)
  ENGINE = InnoDB;

CREATE INDEX Following_User_username_fk
  ON Following (follower);

CREATE INDEX Following_User_username_fk_2
  ON Following (followee);

CREATE TABLE Profile
(
  username  VARCHAR(45)            NOT NULL
    PRIMARY KEY,
  ufn       VARCHAR(45)            NOT NULL,
  uln       VARCHAR(45)            NOT NULL,
  pass      VARCHAR(45)            NOT NULL,
  dateAdded DATE                   NOT NULL,
  active    TINYINT(1) DEFAULT '1' NOT NULL,
  CONSTRAINT User_username_uindex
  UNIQUE (username)
)
  ENGINE = InnoDB;

ALTER TABLE DeletedTweet
  ADD CONSTRAINT DeletedTweet_Profile_username_fk
FOREIGN KEY (currentUser) REFERENCES Profile (username)
  ON UPDATE CASCADE;

ALTER TABLE DeletedTweet
  ADD CONSTRAINT DeletedTweet_Profile_username_fk_2
FOREIGN KEY (originalUser) REFERENCES Profile (username)
  ON UPDATE CASCADE;

ALTER TABLE FavoriteTweet
  ADD CONSTRAINT FavoriteTweet_User_username_fk
FOREIGN KEY (username) REFERENCES Profile (username)
  ON UPDATE CASCADE;

ALTER TABLE Following
  ADD CONSTRAINT Following_User_username_fk
FOREIGN KEY (follower) REFERENCES Profile (username)
  ON UPDATE CASCADE;

ALTER TABLE Following
  ADD CONSTRAINT Following_User_username_fk_2
FOREIGN KEY (followee) REFERENCES Profile (username)
  ON UPDATE CASCADE;

CREATE TABLE Tweet
(
  tId           INT AUTO_INCREMENT
    PRIMARY KEY,
  message       VARCHAR(140) NOT NULL,
  dateCreated   DATE         NOT NULL,
  originalTweet INT          NULL,
  currentUser   VARCHAR(45)  NOT NULL,
  originalUser  VARCHAR(45)  NOT NULL,
  CONSTRAINT Tweet_tId_uindex
  UNIQUE (tId),
  CONSTRAINT Tweet_Tweet_tId_fk
  FOREIGN KEY (originalTweet) REFERENCES Tweet (tId)
    ON UPDATE CASCADE
    ON DELETE CASCADE,
  CONSTRAINT Tweet_User_username_fk
  FOREIGN KEY (currentUser) REFERENCES Profile (username)
    ON UPDATE CASCADE,
  CONSTRAINT Tweet_User_username_fk_2
  FOREIGN KEY (originalUser) REFERENCES Profile (username)
    ON UPDATE CASCADE
)
  ENGINE = InnoDB;

CREATE INDEX Tweet_Tweet_tId_fk
  ON Tweet (originalTweet);

CREATE INDEX Tweet_User_username_fk
  ON Tweet (currentUser);

CREATE INDEX Tweet_User_username_fk_2
  ON Tweet (originalUser);

ALTER TABLE DeletedTweet
  ADD CONSTRAINT DeletedTweet_Tweet_tId_fk
FOREIGN KEY (originalTweet) REFERENCES Tweet (tId)
  ON UPDATE CASCADE
  ON DELETE CASCADE;

ALTER TABLE FavoriteTweet
  ADD CONSTRAINT FavoriteTweet_Tweet_tId_fk
FOREIGN KEY (tweet) REFERENCES Tweet (tId)
  ON UPDATE CASCADE
  ON DELETE CASCADE;
  

grant all privileges on *.* to 'twitterAdmin'@'localhost' identified by 'tacos1235';


INSERT INTO twitter_model.Profile (username, ufn, uln, pass, dateAdded, active) VALUES ('codeWonderland', 'Alice', 'Easter', 'tacos1235', '2018-03-27', 1);
INSERT INTO twitter_model.Profile (username, ufn, uln, pass, dateAdded, active) VALUES ('half_n_half', 'Poppy', 'Tealeaf', 'barbarian1', '2018-03-27', 1);
INSERT INTO twitter_model.Profile (username, ufn, uln, pass, dateAdded, active) VALUES ('hammer_time', 'Kimpa', 'Redstone', 'rokthar4dayz', '2018-03-27', 1);
INSERT INTO twitter_model.Profile (username, ufn, uln, pass, dateAdded, active) VALUES ('lyleof', 'Finn', 'Jensen', 'sushi54', '2018-03-27', 1);
INSERT INTO twitter_model.Profile (username, ufn, uln, pass, dateAdded, active) VALUES ('realPotus', 'Joe', 'Biden', 'fucktrmp', '2018-03-27', 1);
INSERT INTO twitter_model.Profile (username, ufn, uln, pass, dateAdded, active) VALUES ('Skywalker', 'Luke', 'Skywalker', 'Jedi', '2018-03-27', 1);
INSERT INTO twitter_model.Profile (username, ufn, uln, pass, dateAdded, active) VALUES ('tentacle_queen', 'Alice2', 'Easter2', 'tacos1236', '2018-03-27', 1);
INSERT INTO twitter_model.Profile (username, ufn, uln, pass, dateAdded, active) VALUES ('The_cap', 'Steve', 'Rogers', 'Merica', '2018-03-27', 1);
INSERT INTO twitter_model.Profile (username, ufn, uln, pass, dateAdded, active) VALUES ('tree_hugger', 'Vonna', 'Treelight', 'humanzsuck', '2018-03-27', 1);
INSERT INTO twitter_model.Profile (username, ufn, uln, pass, dateAdded, active) VALUES ('walt', 'Walter', 'Hill', 'sky79', '2018-03-27', 1);

use twitter_model;

INSERT INTO twitter_model.Tweet (tId, message, dateCreated, originalTweet, currentUser, originalUser) VALUES (1, 'Hello World', '2018-03-27', null, 'codeWonderland', 'codeWonderland');
INSERT INTO twitter_model.Tweet (tId, message, dateCreated, originalTweet, currentUser, originalUser) VALUES (2, 'Hello World', '2018-03-27', 1, 'lyleof', 'codeWonderland');

/*Joe biden*/
INSERT INTO twitter_model.Tweet (tId, message, dateCreated, originalTweet, currentUser, originalUser) VALUES (3, 'sup twitter', '2018-03-27', null, 'realPotus', 'realPotus');
INSERT INTO twitter_model.Tweet (tId, message, dateCreated, originalTweet, currentUser, originalUser) VALUES (4, 'the coffee in this place sukssss', '2018-03-27', null, 'realPotus', 'realPotus');
INSERT INTO twitter_model.Tweet (tId, message, dateCreated, originalTweet, currentUser, originalUser) VALUES (5, 'just beat barack at basketball. nerd.', '2018-03-27', null, 'realPotus', 'realPotus');
INSERT INTO twitter_model.Tweet (tId, message, dateCreated, originalTweet, currentUser, originalUser) VALUES (6, 'air force one has no blankets and i am pissed', '2018-03-27', null, 'realPotus', 'realPotus');
INSERT INTO twitter_model.Tweet (tId, message, dateCreated, originalTweet, currentUser, originalUser) VALUES (7, 'another day another nickle', '2018-03-27', null, 'realPotus', 'realPotus');
INSERT INTO twitter_model.Tweet (tId, message, dateCreated, originalTweet, currentUser, originalUser) VALUES (8, 'north korea? more like dum bois!', '2018-03-27', null, 'realPotus', 'realPotus');
INSERT INTO twitter_model.Tweet (tId, message, dateCreated, originalTweet, currentUser, originalUser) VALUES (9, 'the only country on my bucket list is canada.', '2018-03-27', null, 'realPotus', 'realPotus');
INSERT INTO twitter_model.Tweet (tId, message, dateCreated, originalTweet, currentUser, originalUser) VALUES (10, 'Justin Trudeau could get it frfr', '2018-03-27', null, 'realPotus', 'realPotus');

/*alice*/
INSERT INTO twitter_model.Tweet (tId, message, dateCreated, originalTweet, currentUser, originalUser) VALUES (11, 'Code!', '2018-03-27', null, 'codeWonderland', 'codeWonderland');
INSERT INTO twitter_model.Tweet (tId, message, dateCreated, originalTweet, currentUser, originalUser) VALUES (12, 'The only other language I speak is binary', '2018-03-27', null, 'codeWonderland', 'codeWonderland');
INSERT INTO twitter_model.Tweet (tId, message, dateCreated, originalTweet, currentUser, originalUser) VALUES (13, 'RMS is bae', '2018-03-27', null, 'codeWonderland', 'codeWonderland');
INSERT INTO twitter_model.Tweet (tId, message, dateCreated, originalTweet, currentUser, originalUser) VALUES (14, 'Pfff if Windows sukkkkk', '2018-03-27', null, 'codeWonderland', 'codeWonderland');
INSERT INTO twitter_model.Tweet (tId, message, dateCreated, originalTweet, currentUser, originalUser) VALUES (15, 'walter is my friend but he kinda the wurst', '2018-03-27', null, 'codeWonderland', 'codeWonderland');


/*finn*/
INSERT INTO twitter_model.Tweet (tId, message, dateCreated, originalTweet, currentUser, originalUser) VALUES (16, 'Hi mom', '2018-03-27', null, 'lyleof', 'lyleof');
INSERT INTO twitter_model.Tweet (tId, message, dateCreated, originalTweet, currentUser, originalUser) VALUES (17, 'the is earth flat', '2018-03-27', null, 'lyleof', 'lyleof');
INSERT INTO twitter_model.Tweet (tId, message, dateCreated, originalTweet, currentUser, originalUser) VALUES (18, 'Code!', '2018-03-27', 11, 'lyleof', 'codeWonderland');
INSERT INTO twitter_model.Tweet (tId, message, dateCreated, originalTweet, currentUser, originalUser) VALUES (19, 'walter is my friend but he kinda the wurst', '2018-03-27', 15, 'lyleof', 'codeWonderland');
INSERT INTO twitter_model.Tweet (tId, message, dateCreated, originalTweet, currentUser, originalUser) VALUES (20, 'ni no kuni is my fav game', '2018-03-27', null, 'lyleof', 'lyleof');

/*Poppy Tealeaf*/
INSERT INTO twitter_model.Tweet (tId, message, dateCreated, originalTweet, currentUser, originalUser) VALUES (21, 'Hello World', '2018-03-27', 1, 'half_n_half', 'codeWonderland');
INSERT INTO twitter_model.Tweet (tId, message, dateCreated, originalTweet, currentUser, originalUser) VALUES (22, 'i like my coffee black', '2018-03-27', null, 'half_n_half', 'half_n_half');
INSERT INTO twitter_model.Tweet (tId, message, dateCreated, originalTweet, currentUser, originalUser) VALUES (23, 'and i hate tea', '2018-03-27', null, 'half_n_half', 'half_n_half');
INSERT INTO twitter_model.Tweet (tId, message, dateCreated, originalTweet, currentUser, originalUser) VALUES (24, 'chocolate milk is the goat', '2018-03-27', null, 'half_n_half', 'half_n_half');
INSERT INTO twitter_model.Tweet (tId, message, dateCreated, originalTweet, currentUser, originalUser) VALUES (25, 'shoutout to iced coffee', '2018-03-27', null, 'half_n_half', 'half_n_half');

/*Kimpa Redstone*/
INSERT INTO twitter_model.Tweet (tId, message, dateCreated, originalTweet, currentUser, originalUser) VALUES (26, 'Hello World', '2018-03-27', 1, 'hammer_time', 'codeWonderland');
INSERT INTO twitter_model.Tweet (tId, message, dateCreated, originalTweet, currentUser, originalUser) VALUES (27, 'ice ice baby', '2018-03-27', null, 'hammer_time', 'hammer_time');
INSERT INTO twitter_model.Tweet (tId, message, dateCreated, originalTweet, currentUser, originalUser) VALUES (28, 'pajama time', '2018-03-27', null, 'hammer_time', 'hammer_time');
INSERT INTO twitter_model.Tweet (tId, message, dateCreated, originalTweet, currentUser, originalUser) VALUES (29, 'chocolate milk is the goat', '2018-03-27', 24, 'hammer_time', 'half_n_half');
INSERT INTO twitter_model.Tweet (tId, message, dateCreated, originalTweet, currentUser, originalUser) VALUES (30, 'shoutout to iced coffee', '2018-03-27', 25, 'hammer_time', 'half_n_half');


/*Luke Skywalker*/
INSERT INTO twitter_model.Tweet (tId, message, dateCreated, originalTweet, currentUser, originalUser) VALUES (31, 'Hello World', '2018-03-27', 1, 'Skywalker', 'codeWonderland');
INSERT INTO twitter_model.Tweet (tId, message, dateCreated, originalTweet, currentUser, originalUser) VALUES (32, 'i have deep seated daddy issues', '2018-03-27', null, 'Skywalker', 'Skywalker');
INSERT INTO twitter_model.Tweet (tId, message, dateCreated, originalTweet, currentUser, originalUser) VALUES (33, 'robot hands are not the worst thing', '2018-03-27', null, 'Skywalker', 'Skywalker');
INSERT INTO twitter_model.Tweet (tId, message, dateCreated, originalTweet, currentUser, originalUser) VALUES (34, 'Yoda is my real dad', '2018-03-27', null, 'Skywalker', 'Skywalker');
INSERT INTO twitter_model.Tweet (tId, message, dateCreated, originalTweet, currentUser, originalUser) VALUES (35, 'shoutout to iced coffee', '2018-03-27', 25, 'Skywalker', 'half_n_half');

/*Alice's Rap Account*/
INSERT INTO twitter_model.Tweet (tId, message, dateCreated, originalTweet, currentUser, originalUser) VALUES (36, 'Hello World', '2018-03-27', 1, 'tentacle_queen', 'codeWonderland');
INSERT INTO twitter_model.Tweet (tId, message, dateCreated, originalTweet, currentUser, originalUser) VALUES (37, 'sushi belongs in my belly', '2018-03-27', null, 'tentacle_queen', 'tentacle_queen');
INSERT INTO twitter_model.Tweet (tId, message, dateCreated, originalTweet, currentUser, originalUser) VALUES (38, 'this is my real face', '2018-03-27', null, 'tentacle_queen', 'tentacle_queen');
INSERT INTO twitter_model.Tweet (tId, message, dateCreated, originalTweet, currentUser, originalUser) VALUES (39, 'Yoda is my real dad', '2018-03-27', 34, 'tentacle_queen', 'Skywalker');
INSERT INTO twitter_model.Tweet (tId, message, dateCreated, originalTweet, currentUser, originalUser) VALUES (40, 'shoutout to iced coffee', '2018-03-27', 25, 'tentacle_queen', 'half_n_half');

/*Capt America*/
INSERT INTO twitter_model.Tweet (tId, message, dateCreated, originalTweet, currentUser, originalUser) VALUES (41, 'Hello World', '2018-03-27', 1, 'The_cap', 'codeWonderland');
INSERT INTO twitter_model.Tweet (tId, message, dateCreated, originalTweet, currentUser, originalUser) VALUES (42, 'heh scarlet witch cant cook', '2018-03-27', null, 'The_cap', 'The_cap');
INSERT INTO twitter_model.Tweet (tId, message, dateCreated, originalTweet, currentUser, originalUser) VALUES (43, 'this is my real face', '2018-03-27', 38, 'The_cap', 'tentacle_queen');
INSERT INTO twitter_model.Tweet (tId, message, dateCreated, originalTweet, currentUser, originalUser) VALUES (44, 'the gov was wrong about the accords', '2018-03-27', null, 'The_cap', 'The_cap');
INSERT INTO twitter_model.Tweet (tId, message, dateCreated, originalTweet, currentUser, originalUser) VALUES (45, 'me and tony have a love hate thing', '2018-03-27', null, 'The_cap', 'The_cap');

/*Vonna Treelight*/
INSERT INTO twitter_model.Tweet (tId, message, dateCreated, originalTweet, currentUser, originalUser) VALUES (46, 'Hello World', '2018-03-27', 1, 'tree_hugger', 'codeWonderland');
INSERT INTO twitter_model.Tweet (tId, message, dateCreated, originalTweet, currentUser, originalUser) VALUES (47, 'heh scarlet witch cant cook', '2018-03-27', 42, 'tree_hugger', 'The_cap');
INSERT INTO twitter_model.Tweet (tId, message, dateCreated, originalTweet, currentUser, originalUser) VALUES (48, 'trees are quite cozy', '2018-03-27', null, 'tree_hugger', 'tree_hugger');
INSERT INTO twitter_model.Tweet (tId, message, dateCreated, originalTweet, currentUser, originalUser) VALUES (49, 'i do shots of maple syrup', '2018-03-27', null, 'tree_hugger', 'tree_hugger');
INSERT INTO twitter_model.Tweet (tId, message, dateCreated, originalTweet, currentUser, originalUser) VALUES (50, 'leaves are like hair but better', '2018-03-27', null, 'tree_hugger', 'tree_hugger');

INSERT INTO twitter_model.Following (fId, follower, followee) VALUES (1, 'lyleof', 'codeWonderland');
INSERT INTO twitter_model.Following (fId, follower, followee) VALUES (2, 'codeWonderland', 'lyleof');
INSERT INTO twitter_model.Following (fId, follower, followee) VALUES (3, 'walt', 'lyleof');
INSERT INTO twitter_model.Following (fId, follower, followee) VALUES (4, 'walt', 'codeWonderland');
INSERT INTO twitter_model.Following (fId, follower, followee) VALUES (5, 'codeWonderland', 'walt');
INSERT INTO twitter_model.Following (fId, follower, followee) VALUES (6, 'lyleof', 'walt');
INSERT INTO twitter_model.Following (fId, follower, followee) VALUES (7, 'realPotus', 'codeWonderland');
INSERT INTO twitter_model.Following (fId, follower, followee) VALUES (8, 'realPotus', 'lyleof');
INSERT INTO twitter_model.Following (fId, follower, followee) VALUES (9, 'tree_hugger', 'half_n_half');
INSERT INTO twitter_model.Following (fId, follower, followee) VALUES (10, 'walt', 'Skywalker');
INSERT INTO twitter_model.Following (fId, follower, followee) VALUES (11, 'Skywalker', 'lyleof');
INSERT INTO twitter_model.Following (fId, follower, followee) VALUES (12, 'tentacle_queen', 'lyleof');
INSERT INTO twitter_model.Following (fId, follower, followee) VALUES (13, 'The_cap', 'walt');
INSERT INTO twitter_model.Following (fId, follower, followee) VALUES (14, 'hammer_time', 'walt');

INSERT INTO twitter_model.FavoriteTweet (ftId, username, tweet) VALUES (1, 'realPotus', 1);
INSERT INTO twitter_model.FavoriteTweet (ftId, username, tweet) VALUES (2, 'realPotus', 11);
INSERT INTO twitter_model.FavoriteTweet (ftId, username, tweet) VALUES (3, 'realPotus', 15);
INSERT INTO twitter_model.FavoriteTweet (ftId, username, tweet) VALUES (4, 'realPotus', 8);

INSERT INTO twitter_model.FavoriteTweet (ftId, username, tweet) VALUES (5, 'codeWonderland', 1);
INSERT INTO twitter_model.FavoriteTweet (ftId, username, tweet) VALUES (6, 'codeWonderland', 17);
INSERT INTO twitter_model.FavoriteTweet (ftId, username, tweet) VALUES (7, 'codeWonderland', 22);
INSERT INTO twitter_model.FavoriteTweet (ftId, username, tweet) VALUES (8, 'codeWonderland', 10);

INSERT INTO twitter_model.FavoriteTweet (ftId, username, tweet) VALUES (9, 'half_n_half', 1);
INSERT INTO twitter_model.FavoriteTweet (ftId, username, tweet) VALUES (10, 'half_n_half', 31);
INSERT INTO twitter_model.FavoriteTweet (ftId, username, tweet) VALUES (12, 'half_n_half', 25);
INSERT INTO twitter_model.FavoriteTweet (ftId, username, tweet) VALUES (13, 'half_n_half', 18);

INSERT INTO twitter_model.FavoriteTweet (ftId, username, tweet) VALUES (14, 'hammer_time', 1);
INSERT INTO twitter_model.FavoriteTweet (ftId, username, tweet) VALUES (15, 'hammer_time', 22);
INSERT INTO twitter_model.FavoriteTweet (ftId, username, tweet) VALUES (16, 'hammer_time', 7);
INSERT INTO twitter_model.FavoriteTweet (ftId, username, tweet) VALUES (17, 'hammer_time', 3);

INSERT INTO twitter_model.FavoriteTweet (ftId, username, tweet) VALUES (18, 'Skywalker', 1);
INSERT INTO twitter_model.FavoriteTweet (ftId, username, tweet) VALUES (19, 'Skywalker', 4);
INSERT INTO twitter_model.FavoriteTweet (ftId, username, tweet) VALUES (20, 'Skywalker', 5);
INSERT INTO twitter_model.FavoriteTweet (ftId, username, tweet) VALUES (21, 'Skywalker', 19);

INSERT INTO twitter_model.FavoriteTweet (ftId, username, tweet) VALUES (22, 'tentacle_queen', 1);
INSERT INTO twitter_model.FavoriteTweet (ftId, username, tweet) VALUES (23, 'tentacle_queen', 41);
INSERT INTO twitter_model.FavoriteTweet (ftId, username, tweet) VALUES (24, 'tentacle_queen', 45);
INSERT INTO twitter_model.FavoriteTweet (ftId, username, tweet) VALUES (25, 'tentacle_queen', 48);

INSERT INTO twitter_model.FavoriteTweet (ftId, username, tweet) VALUES (26, 'The_cap', 1);
INSERT INTO twitter_model.FavoriteTweet (ftId, username, tweet) VALUES (27, 'The_cap', 13);
INSERT INTO twitter_model.FavoriteTweet (ftId, username, tweet) VALUES (28, 'The_cap', 16);
INSERT INTO twitter_model.FavoriteTweet (ftId, username, tweet) VALUES (29, 'The_cap', 25);

INSERT INTO twitter_model.FavoriteTweet (ftId, username, tweet) VALUES (30, 'tree_hugger', 1);
INSERT INTO twitter_model.FavoriteTweet (ftId, username, tweet) VALUES (31, 'tree_hugger', 22);
INSERT INTO twitter_model.FavoriteTweet (ftId, username, tweet) VALUES (32, 'tree_hugger', 30);
INSERT INTO twitter_model.FavoriteTweet (ftId, username, tweet) VALUES (33, 'tree_hugger', 17);

INSERT INTO twitter_model.FavoriteTweet (ftId, username, tweet) VALUES (34, 'walt', 1);
INSERT INTO twitter_model.FavoriteTweet (ftId, username, tweet) VALUES (35, 'walt', 37);
INSERT INTO twitter_model.FavoriteTweet (ftId, username, tweet) VALUES (36, 'walt', 39);
INSERT INTO twitter_model.FavoriteTweet (ftId, username, tweet) VALUES (37, 'walt', 8);

INSERT INTO twitter_model.FavoriteTweet (ftId, username, tweet) VALUES (38, 'lyleof', 1);
INSERT INTO twitter_model.FavoriteTweet (ftId, username, tweet) VALUES (39, 'lyleof', 23);
INSERT INTO twitter_model.FavoriteTweet (ftId, username, tweet) VALUES (40, 'lyleof', 33);
INSERT INTO twitter_model.FavoriteTweet (ftId, username, tweet) VALUES (41, 'lyleof', 50);

drop trigger if exists DeleteTweet;
DELIMITER //
create trigger DeleteTweet before delete
    on Tweet for EACH ROW
    begin
    insert into DeletedTweet(tId, message, currentUser, originalUser, dateCreated, dateDeleted, originalTweet)
    values (OLD.tId, OLD.message, OLD.currentUser, OLD.originalUser,
                                                                     OLD.dateCreated, NOW(), OLD.originalTweet);
    END; //
DELIMITER ;

drop procedure if exists add_tweet;
DELIMITER //
create procedure add_tweet(IN user_username varchar(45), IN user_message varchar(140))
  begin
        INSERT INTO twitter_model.Tweet (tId, message, dateCreated, originalTweet, currentUser, originalUser) VALUES (default, user_message, now(), default,
                                                                                                                        user_username, user_username);
    end;
//
DELIMITER ;

drop procedure if exists delete_tweet;
DELIMITER //
create procedure delete_tweet(IN tweet_id int)
  begin
    delete from Tweet where tId = tweet_id;
  end;
//
DELIMITER ;

drop procedure if exists favorite_tweet;
DELIMITER //
create procedure favorite_tweet(IN user_username varchar(45), IN tweet_id int)
  begin
    INSERT INTO twitter_model.FavoriteTweet (ftId, username, tweet) VALUES (default, user_username, tweet_id);
  end;
//
DELIMITER ;

drop procedure if exists follow_user;
DELIMITER //
create procedure follow_user(IN user_username varchar(45), IN user_to_follow varchar(45))
  begin
        INSERT INTO twitter_model.Following (fId, follower, followee) VALUES (default, user_username, user_to_follow);
  end;
//
DELIMITER ;

drop procedure if exists get_timeline;
DELIMITER //
create procedure get_timeline(IN user_username varchar(45))
  begin
		select t.tId, t.message, t.currentuser, t.dateCreated
			from Tweet t inner join Following f
			on t.currentuser = f.followee and
				f.follower = user_username AND
					followee in (
						select username from Profile p
							where p.active = 1
					)

		union

		select t.tId, t.message, t.currentuser, t.dateCreated
		from Tweet t, Profile p
		where t.currentuser = p.username and
			p.active = 1 and
			p.username = user_username
ORDER BY dateCreated desc;
	end;
//
DELIMITER ;

drop procedure if exists get_tweet_favs;
DELIMITER //
create procedure get_tweet_favs(IN tweet_id int)
  begin
		#How many times has a tweet been favorited ex: Tweet 1
		select count(tweet) as '# of Favs' , t.message
		from FavoriteTweet ft, Tweet t
		where ft.tweet = t.tID and t.tId = tweet_id
			and ft.username in (select username from Profile p
													where p.active = 1);
  end;
//
DELIMITER ;

drop procedure if exists get_user;
DELIMITER //
create procedure get_user(IN user_username varchar(45), IN user_password varchar(45))
  begin
		select username
		from Profile
		where username = user_username and
  	pass = user_password;
  end;
//
DELIMITER ;

drop procedure if exists get_user_tweets;
DELIMITER //
create procedure get_user_tweets(IN user_username varchar(45))
  begin
		select t.tId, t.message, t.currentuser, t.dateCreated
			from Tweet t, Profile p
			where t.currentuser = p.username AND
						p.username = user_username AND
						p.active = 1
			ORDER BY dateCreated desc;
  end;
//
DELIMITER ;

drop procedure if exists get_users_favs;
DELIMITER //
create procedure get_users_favs(IN user_username varchar(45))
  begin
		#How many times has a tweet been favorited ex: Tweet 1
		select t.currentUser, message
			from FavoriteTweet ft, Tweet t
			where ft.tweet = t.tID and
					ft.username = user_username AND
					t.originalUser in (select username from Profile p
														where p.active = 1);

  end;
//
DELIMITER ;

drop procedure if exists get_users_followers;
DELIMITER //
create procedure get_users_followers(IN user_username varchar(45))
  begin
		#How many times has a tweet been favorited ex: Tweet 1
		select followee
			from Following
			where follower = user_username AND
				followee in (select username from Profile p
														where p.active = 1);

  end;
//
DELIMITER ;

drop procedure if exists get_users_following;
DELIMITER //
create procedure get_users_following(IN user_username varchar(45))
  begin
		#How many times has a tweet been favorited ex: Tweet 1
		select follower
			from Following
			where followee = user_username AND
				follower in (select username from Profile p
														where p.active = 1);

  end;
//
DELIMITER ;

drop procedure if exists retweet_tweet;
DELIMITER //
create procedure retweet_tweet(IN user_username varchar(45), IN user_tid int, IN user_message varchar(45),
                               IN user_original varchar(45))
  begin
        insert twitter_model.Tweet (tId, message, dateCreated, originalTweet, currentUser, originalUser) VALUES (default, user_message,
                                                                                                                    now(), user_tid, user_username, user_original);
    end;
//
DELIMITER ;

drop procedure if exists unfollow_user;
DELIMITER //
create procedure unfollow_user(IN user_username varchar(45), IN user_to_unfollow varchar(45))
  begin
        delete from Following where follower = user_username and followee = user_to_unfollow;
    end;
//
DELIMITER ;
