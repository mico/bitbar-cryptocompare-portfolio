# Cryptocompare portfolio holdings at bitbar

Shows your portfolio holdings at cryptocompare.

Put portfolio.1m.rb to your bitbar scripts directory.
Create ~/portfolio.yml with cookies before start using.
~/portfolio.yml should contain text like:
```
---
cookie: __cfduid=...; _ga=...; G_ENABLED_IDPS=google; lightsOff=1; _gid=..; sid=...
```

To obtain cookie value:
- Open browser network console, open page https://www.cryptocompare.com/portfolio/
- Copy cookie value from headers:
![image](https://i.imgur.com/qXLLLrd.png)
