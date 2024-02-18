<p align="center">
  <img src="public/welcome_readme.jpg" alt="Hotwire Logo" width="150"/>
</p>

# Hotwired Application
This is a Rails application to play with different features of HTML Over the Wire.

- [Hotwired Application](#hotwired-application)
  - [Pre-requisites](#pre-requisites)
    - [Setup](#setup)
  - [Additional informations](#additional-informations)
    - [for creating modal controller the command used](#for-creating-modal-controller-the-command-used)
    - [For creating the fake data](#for-creating-the-fake-data)

## Pre-requisites

The following software is required to work with the repository.
This project currently works with:

![Ruby version](https://img.shields.io/static/v1?label=JRuby&message=3.2.2&color=red&&style=for-the-badge)
![Rails](https://img.shields.io/static/v1?label=Rails&message=7.1.3&color=9C312A&&style=for-the-badge)
![Bundler](https://img.shields.io/static/v1?label=Bundler&message=2.3.4&color=f77b07&&style=for-the-badge)
![Postgres Database](https://img.shields.io/static/v1?label=Postgres&message=16&color=green&style=for-the-badge)

### Setup ###

1. bundle install
2. rails importmap:install
3. rails turbo:install stimulus:install
4. rails db:create; db:seed
5. Open rails console and run `Developer.insert_fake_data 20`

## Additional informations

### for creating modal controller the command used
  `rails g stimulus turbomodal`

The controller nme of timulus should be a word like 'notification', 'pagination'
I have tried with 'notification_scroll' which is not working, may be the snake case is not valid.

### For creating the fake data
1. `Developer.insert_fake_data`
2. `Notification.bulk_create_for_testing`
3. `Notification.fake_notification_stream`
