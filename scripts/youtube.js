const request = require('request');
const config  = require('./config.js');
const admin = require('firebase-admin');

const nconf = require('nconf');
nconf.use('file', { file: './ids.log' });

// set_date is a boolean to update last updated date
const get_videos = function(username, channel_id, set_date){
    var published_after = nconf.get("youtube_after_date");
    var type = "video";
    let data = [];
    let promise = new Promise(function(resolve, reject){
        request.get("https://www.googleapis.com/youtube/v3/search?key=" + config["youtube"]["api_key"] + "&channelId=" + channel_id + "&part=id,snippet&order=date&publishedAfter=" + published_after + "&type=" + type, function(err, header, body) {
            if (err){
                console.error(err);
                return;
            }
            let items = JSON.parse(body)["items"];
            for(let i=0; i<items.length; i++){
                let item = items[i];
                let date_obj = new Date(item["snippet"]["publishedAt"]);
                let video_id = item["id"]["videoId"];
                let processed_item = {"channel": item["snippet"]["channelTitle"], "title": item["snippet"]["title"], "time": admin.firestore.Timestamp.fromDate(date_obj), "link": "https://www.youtube.com/watch?v=" + video_id, "thumbnail": "https://img.youtube.com/vi/" + video_id + "/sddefault.jpg"};
                let doc_name = date_obj.toISOString().split('T')[0] + "-" + username + "-" + item["snippet"]["title"];
                let curr_data = {};
                curr_data[doc_name] = processed_item;
                data.push(curr_data);
            }

            if(set_date == true){
                nconf.set("youtube_after_date", (new Date()).toISOString());
                nconf.save(function (err) {
                    if (err){
                        console.error(err.message);
                        return;
                    }
                    resolve(data);
                });
            }
            else{
                resolve(data);
            }
        });
    });

    return promise;
}

module.exports = get_videos
