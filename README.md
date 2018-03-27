# ndown

## Required software

Install aria2, wget and youtube-dl

### Ubuntu
```bash
sudo apt install aria2 wget youtube-dl
```

### Archlinux
```bash
sudo pacman -S aria2 wget youtube-dl
```

## Setup

You can configure directory settings and others in **ndown/config/download.conf** . Variable description can be found in the required software manual pages.

Run install.sh, *your crontab will be replaced*.

```bash
./install.sh
```

Crontab should have the execution of download.sh at the desired time (when the time window of available bandwidth begins, ex. night time) and the execution of killer.sh to prevent the download process during the time where bandwidth will be scarce for a long time, ex. early morning.

### Example crontab

```bash
#   m h  dom mon dow   command
    0 23  *   *   *    bash /opt/ndown/download.sh
    0 8   *   *   *    bash /opt/ndown/killer.sh
```



## How to use

Append urls to the .links files in **ndown/inputs** depending on what they are.
- youtube videos the must be in youtube.links
- regular files with static links in aria2.links
- webpages in webs.links

Run download.sh and the files will be downloaded. If the the download is interrupted it will be resumed next time. You can check the logfile in ndown/download.log which will register a lot of info.
