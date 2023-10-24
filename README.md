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
# Github Repo Viewer

```mermaid

graph TD;
  subgraph MainApp[<font size=7>App Flow]
    SplashScreen[<font size=6>SplashScreen]
    SplashScreen --> HomePage([<font size=5>HomePage - Screen])
    style SplashScreen fill:indigo
    HomePage --> MenuButton([<font size=5>HomePage - Drawer Widget Menu])
    style HomePage fill:blue
    MenuButton --> Home([<font size=5>Home - Screen])
    style Home fill:darkgreen
    MenuButton --> Profile([<font size=5>Profile - Screen])
    style Profile fill:darkgreen
    MenuButton --> Help([<font size=5>Help - Screen])
    style Help fill:darkgreen
    MenuButton --> ChangeTheme([<font size=5>Change Theme - Button])
    style ChangeTheme fill:darkgreen
    style MenuButton fill:purple
    HomePage --> SearchTab([<font size=5>Search Tab - Screen])
    style SearchTab fill:purple
    HomePage --> AboutUsTab([<font size=5>About Us Tab - Screen])
    style AboutUsTab fill:purple
    SearchTab --> SearchButton[<font size=4>Enter Your Search prompt, 
    Search - Button]
    style SearchButton fill:darkgreen;
    SearchButton --> RepoCards([<font size=5>Repo Cards - Widget])
    style RepoCards fill:red;
    RepoCards --> RepoInfo[<font size=4>Repo Information]
    style RepoInfo fill:orange;
    RepoCards --> DownArrow([<font size=5>Down Arrow - Button])
    style DownArrow fill:orange;
    DownArrow --> BookMark([<font size=5>Bookmark Button])
    style BookMark fill:blue;
    DownArrow --> Visit([<font size=5> Visit - Button])
    style Visit fill:blue;
    DownArrow --> Contributors([<font size=5>Contributors - Button])
    style Contributors fill:blue;
    Contributors --> ContributorsScreen([<font size=5>Contributors - Screen])
    style ContributorsScreen fill:purple;
    ContributorsScreen --> ContributorWidget([<font size=5>Contributor - Widget])
    style ContributorWidget fill:darkgreen;
    ContributorWidget --> ViewProfile([<font size=5>View Profile - Button])
    style ViewProfile fill:red;
    ContributorWidget --> Floating([<font size=5>Floating - Button])
    style Floating fill:red;
    ViewProfile --> ProfileCard[<font size=4>For each contributor, 
    a card is shown with 
    contributor's data and 
    a button to visit 
    contributor's profile]
    style ProfileCard fill:orange;
    Floating --> ContributorRequest[<font size=4>User requests to 
    become a contributor
     to the repo]
    style ContributorRequest fill:orange;
    HomePage --> BookMarkTab([<font size=5>BookMark Tab - Screen])
    style BookMarkTab fill:purple
    BookMarkTab --> BookmarkedRepos[<font size=4>Bookmarked repo will
    be shown here and
    can have the option
    to remove from bookmark.
    These repos will be
    shown in the Repo Card-Format]
    style BookmarkedRepos fill:darkgreen;
  end

```
