#!/usr/bin/env python
# coding: utf-8

# In[50]:


import requests
from bs4 import BeautifulSoup


# In[51]:


url = "https://www.mohfw.gov.in/"
req = requests.get(url)
soup = BeautifulSoup(req.content, 'html.parser')
moh_dict=[]


# In[52]:


divs = soup.find_all(class_="update-box")
for div in divs:
#     print(div)
    div_dict = {
            'link': div.find('a')['href'],
            'title': div.find('a').contents[0],
            'time': div.find('strong').contents[0],
            'handle': 'Ministry of Health and Family Healthcare'
            }
    moh_dict.append(div_dict)
    
moh_dict


# In[ ]:





# In[ ]:





# In[ ]:




