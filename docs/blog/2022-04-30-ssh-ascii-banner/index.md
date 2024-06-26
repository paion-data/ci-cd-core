---
slug: ssh-ascii-banner
title: Add Custom ASCII Banner Logo to SSH Login Screen
authors: [jiaqi, mike-andreasen]
tags: [DevOps]
---

In the early 90's ASCII art became a thing. It was a way to make logos using regular ASCII characters to decorate readme
files and add some branding. Nowadays we can generate these banners using free tools like Text to ASCII Art Generator.
It can be used to create a server login banner that is displayed each time people log in via SSH.

<!--truncate-->

![./example.png](example.png)

First generate a ASCII logo with the [Text to ASCII Art Generator]. Then open up message of the day file

```bash
sudo nano /etc/motd
```

Add a text such as

```bash
The programs included with the Debian GNU/Linux system are free software;
the exact distribution terms for each program are described in the
individual files in /usr/share/doc/*/copyright.

Debian GNU/Linux comes with ABSOLUTELY NO WARRANTY, to the extent
permitted by applicable law.


______     _              ______      _
| ___ \   (_)             |  _  \    | |
| |_/ /_ _ _  ___  _ __   | | | |__ _| |_ __ _
|  __/ _` | |/ _ \| '_ \  | | | / _` | __/ _` |
| | | (_| | | (_) | | | | | |/ / (_| | || (_| |
\_|  \__,_|_|\___/|_| |_| |___/ \__,_|\__\__,_|
```

Save the file and open a new SSH session and log in, we should be greeted with our beautiful banner

[Text to ASCII Art Generator]: http://patorjk.com/software/taag/
