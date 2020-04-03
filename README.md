# COVID-19 App


## Objectives
- [x] Infection protection and control / WASH
- [ ] Guidance for schools/workplaces & institutions
- [ ] Points of entry / mass gatherings
- [x] Reduction of transmission from animals to humans 
- [x] 12 guides to help work from home 
- [x] Reminders to wash hands, drinking warm water, eating citric fruits, 
- [ ] Location finder and raising alert, if someone goes out from his/her home
- [ ] Ability to update Govt Guidelines from time to time as issued. This can be a page which can be hosted on github
- [x] Statistics about the people affected in the world,  India and Karnataka/ Bangalore section – If possible show https://www.covidvisualizer.com otherwise add a link 
- [x] Include state wise statistics from https://www.mohfw.gov.in
- [ ] Links to websites such as WHO, MOH GOI
- [x] Twitter feed from WHO, MOH GOI
- [x] Links/integrations to donate to PM Cares fund and state relief funds. Details can be found in this page.



## Script for notifications

```
DATA='{"notification": {"body": "this is a body","title": "this is a title"}, "priority": "high", "data": {"click_action": "FLUTTER_NOTIFICATION_CLICK", "id": "1", "status": "done"}, "to": "<FCM_TOKEN>"}'

curl https://fcm.googleapis.com/fcm/send -H "Content-Type:application/json"
-X POST -d "$DATA" -H "Authorization: key="<FCM_SERVER_KEY>"
```
