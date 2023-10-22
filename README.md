## Hackfest-Flutter
This app aims to simplify the process of finding repositories on GitHub, view the various contributors to the repos, and also allows the user to become a contributor to the desired project.


Kindly consider leaving a :star: if you like the repository and our organisation.


## Getting Started
* Fork it.
* Clone your forked repo and move inside it:\
  `git clone https://github.com/<your-github-username>/<repo-name>.git && cd <repo-name>`

* Checkout to a new branch to work on an issue:\
  `git checkout -b my-amazing-feature`

* Now you can open the project.
* Run `flutter pub get` in the project terminal and get the dependencies.
* Use `flutter run debug` to run the app in your local emulator.
* Once you're all done coding, it's time to open a PR :)
  Run the following commands from the root of the project directory:
  \
  `git add .`\
  `git commit -m "A short description about the feature."`\
  `git push origin <my-amazing-feature>`

Open your forked repo in your browser and then raise a PR to the `master` branch of this repository!


## Contributing

To start contributing, check out [CONTRIBUTING.md](https://github.com/IEEE-VIT/hacktoberfest-flutter/blob/master/CONTRIBUTING.md). New contributors are always welcome to support this project. If you want something gentle to start with, check out issues labelled as `easy` or `good-first-issue`

## License

This project is licensed under [MIT](https://github.com/IEEE-VIT/hacktoberfest-flutter/blob/master/LICENSE)


> [!NOTE]  
> This project is not officially affiliated with DigitalOcean or Hacktoberfest in any manner.
>
<br>

# Github Repo Viewer (Change this Name while merging)

## App Work Flow

**Click On App Icon -> Splash Screen (Screen)** -> **HomePage (Screen)**   
The main page of the app having AppBar and tabview
1. **Search Tab (Screen)** ->
>>Enter Your Search prompt and click on ***Search (Button)*** -> Api call for fetching Repositories ->
>>> **Repo Cards (Widget)** ->
>>1. Repo Information.
>>2. ***Down Arrow (Button)*** -> Opens a card showcasing more details
>>>1. ***Visit (Button)*** -> Opens browser and Navigates user to the github link of the repo.
>>>2. ***Contributors (Button)*** -> **Contributors (Screen)** -> **Contributor (Widget)**  
      Shows the list of contributors by navigating to contributors page
>>>>1. ***View Profile (Button)*** -> For each contributor a card is shown with contributors data and a button to visit contributors profile.
>>>>2. ***Floating (Button)*** -> User requests for becoming a contributor to the repo.
>>>>3. ***BookMark Icon (Button)*** -> Click to bookmark the repo.
2. **BookMark Tab (Screen)** ->
>>Bookmarked repo will be shown here and can have the option to remove from bookmark. These repos will be shown in the **Repo Card (Widget)** format.
3. **About Us Tab (Screen)** ->
>>Navigates to the page where user can check about the creators.
4. ***Settings Button on Appbar (Screen)*** ->
>>Settings and other app related options will be here
>1. **Help (Widget)** ->   
    Navigates the user to the Help Page where user can check the app flow (Documentation, Video Tutorial, etc).
>2. ***Change Theme (Button)*** -> When pressed changes theme from dark to light andd vise versa.
