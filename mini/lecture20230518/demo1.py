import segno
from segno import helpers

ecust_web = segno.make("https://www.ecust.edu.cn/")
ecust_web.save('ecust.png', scale=16)

contact_me = helpers.make_mecard(name='张晨峰', 
                             email='glenzhang@ecust.edu.cn')

contact_me.to_artistic(background="me.jpg", target='contact_me.jpg', scale=16)