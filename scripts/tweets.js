var Twitter = require('twitter');
var config  = require('./config.js');
var twitter_client = new Twitter(config["twitter"]);
const admin = require('firebase-admin');

var nconf = require('nconf');
nconf.use('file', { file: './ids.log' });

// Set up parameters
var api_endpoint = "statuses/user_timeline";
var params = {
    screen_name: '',
    since_id: '',
    include_rts: false,
    trim_user: true,
    tweet_mode: "extended",
    // count: 1 // for testing
}

const get_tweets = function(twitter_handle){
    let promise = new Promise(function(resolve, reject){
        var prev_ids = nconf.get('ids_' + twitter_handle);
        params["since_id"] = prev_ids[0];
        params["screen_name"] = twitter_handle;
        data = [];
        ids = [];

        twitter_client.get(api_endpoint, params, function(err, tweets, response) {
            if(!err){
                tweets.forEach(tweet => {
                    ids.push(tweet["id_str"]);
                    var date_obj = new Date(tweet["created_at"]);
                    var date_str = date_obj.toISOString().split('T')[0];
                    var hour_str = date_obj.toTimeString().replace(/:\d+ .*/, '').replace(':','-');
                    var curr_data = {};
                    curr_data[date_str + "-" + hour_str + "-" + twitter_handle] = {"handle": "@" + twitter_handle, "link": "https://twitter.com/" + twitter_handle + "/status/" + tweet["id_str"], "time": admin.firestore.Timestamp.fromDate(date_obj), "tweet": tweet["full_text"]};
                    data.push(curr_data); 
                });
            }
            else{
                console.error(err);
            }

            // write last written ids to file
            if(ids.length != 0){
                nconf.set('ids_' + twitter_handle, ids);
                nconf.save(function (err) {
                    if (err){
                        console.error(err.message);
                        return;
                    }
                    resolve(data);
                });
            }
            else{
                resolve(data)
            }
            
        });
    });

    return promise;
}

module.exports = get_tweets
