# PogDrive
Deliver Google Drive files as podcasts.

## Features
* No need to set Google Drive files as public / share by url 
* Can run on Heroku free plan

## Setup
* Get OAuth Client ID from Google
    * Application Type: Other
* Set env vars (example: `.env.sample`).
* Usual setup for rails application.
* Run `rake gdrive:auth` and login.
* Access `/admin/podcasts`.