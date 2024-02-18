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
    - [In-Code Documentation with Yard](#in-code-documentation-with-yard)
      - [Setting Up Yard](#setting-up-yard)
      - [Additional Yard Configuration](#additional-yard-configuration)

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

### In-Code Documentation with Yard

This project utilizes [Yard](https://yardoc.org/) for in-code documentation. Yard is a documentation generation tool for Ruby that provides a clean and consistent way to document your code.

#### Setting Up Yard

To generate and view the documentation locally, follow these steps:

1. **Install Yard**: It is part of the Gemfile in the development environment, after the `bundle install`, it is ready to be used.
2. **Generate Documentation**: Run the following command to generate documentation for your project:     ```yar -o docs    ```     This will create a `docs` directory with the generated documentation.
3. **View Documentation Locally**:     - Open the `doc/index.html` file in your browser to browse the documentation. Or you can start the Yard server locally and access the documents.

#### Additional Yard Configuration

You can customize Yard's behavior by adding a `.yardopts` file in the root of your project. This file can contain various options and flags to control the documentation generation process. Refer to the [Yard documentation](https://yardoc.org/docs/yard/file-format.html) for more details.
