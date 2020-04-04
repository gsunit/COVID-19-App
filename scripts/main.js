const getTweetsData  = require(__dirname + "/tweets.js");
const getVideosData  = require(__dirname + "/youtube.js");
const config  = require(__dirname + '/config.js');
const admin   = require('firebase-admin');

var serviceAccount = require(__dirname + '/covid-19-app-firebase-admin.json');
admin.initializeApp({
    credential: admin.credential.cert(serviceAccount),
    databaseURL: config["database_url"],
    authDomain: config["auth_domain"]
    });
var db = admin.firestore();

// if you add a new twiiter handle make sure to add it's corresponding since_id 
//for the first time in ids.log
twitter_handles = ["who", "narendramodi", "MoHFW_INDIA"];
function retrieveTweets(index){
    if(index >= twitter_handles.length)
        return;

    var handle = twitter_handles[index]
    getTweetsData(handle).then(function(data){
        if(data.length != 0){
            saveToFirebase(data, "tweets").then(function(){
                retrieveTweets(index+1);
            });
        }
        else{
            retrieveTweets(index+1);
        }
    })
}

// retrieve youtube videos data
youtube_channel_ids = [{"who": "UC07-dOwgza1IguKA86jqxNA"}, {"MoH-Fw": "UCsyPEi8BS07G8ZPXmpzIZrg"}, {"narendramodi": "UC1NF71EwP41VdjAU1iXdLkw"}]
function retrieveYoutubeVideos(index){
    if(index >= youtube_channel_ids.length)
        return;

    var channel_name, channel_id;
    for(var key in youtube_channel_ids[index]){
        channel_name = key;
        channel_id = youtube_channel_ids[index][key];
    }

    getVideosData(channel_name, channel_id, ((index+1) == youtube_channel_ids.length)).then(function(data){
        if(data.length != 0){
            saveToFirebase(data, "videos").then(function(){
                retrieveYoutubeVideos(index+1);
            });
        }
        else{
            retrieveYoutubeVideos(index+1);
        }
    });
}

function saveToFirebase(data, collection_name){
    var ref = db.collection(collection_name);
    promise_list = []
    data.forEach(element => {
        for(var document_name in element){
            let temp = ref.doc(document_name).set(element[document_name]);
            promise_list.push(temp);
        }
    });
    // console.log(data);
    return Promise.all(promise_list);
}

function getAllFromFirestore(collection_name){
    let ref = db.collection(collection_name);
    let allDocsPromise = ref.get()
        .then(snapshot => {
            snapshot.forEach(doc => {
                console.log(doc.data());
            });
        })
        .catch(err => {
            console.error('Error getting documents', err);
        });

    return allDocsPromise;
}

retrieveTweets(0)
retrieveYoutubeVideos(0);
console.log("Done at " + (new Date()).toString())
