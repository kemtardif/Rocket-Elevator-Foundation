# Rocket_Elevators : MAINT STUFF INTO PRODUCTION.

-WE created a g-mail account for you to access the services : supercodeboxx@gmail.com. Pass word c0deb0xx1!
-YOu can access both New Relic and Google Analytics using the above account.

-FOr the deployment, we created a new EC2 instance with ubuntu 18.04. WE then connected via ssh and installed rvm, ruby, rails and the necessary packages. Plus nginx. The rest follows what we have done earlier in the program.

-For Google Analytics, you can access the portal via analytics.google.com. We simply created an account and added the following script into the html layout, which then tracks the traffic. If you go to kemverynice.com, you will see the live stream in Google Analytics change after seconds :

```
<script async src="https://www.googletagmanager.com/gtag/js?id=G-8JVXE3SWK3"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());

  gtag('config', 'G-8JVXE3SWK3');
</script>
    <title>Rocket Elevator</title>
    <%= csrf_meta_tags %>
    <%= csp_meta_tag %>
	
    <%= javascript_include_tag 'application', media: 'all' %>
    <%= stylesheet_link_tag    'application', media: 'all' %>
    <script>var plugin_path = '../assets/'</script>
```

-For New Relic, we can acces the portial via https://login.newrelic.com/login, then go to dashboards. We added the following gem :
```
gem 'newrelic_rpm'
```
-Followed by adding a config/newrelic.yml file. This allow to connect New Relic to our app.





## Developper
- Kem Tardif (Team Leader)
- Kem Tardif
-Kem tardif
-And also Kem Tardif.

